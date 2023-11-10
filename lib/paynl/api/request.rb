module Paynl
  module Api
    class Request
      attr_reader :params

      API_OUTPUT = 'xml'
      MANDATORY_PARAMETERS = []
      OPTIONAL_PARAMETERS = []

      def initialize(options={})
        options.each do |key, value|
          next if !self.class::OPTIONAL_PARAMETERS.include?(key) || value.nil?
          @params[key] = value
        end
      end

      def perform
        raise Paynl::Exception, 'No api token configured.' unless can_perform?

        validate!

        api_url = URI.parse(uri)
        http = Net::HTTP.new(api_url.host, api_url.port)
        http.use_ssl = (api_url.scheme == 'https')
        request = Net::HTTP::Get.new(api_url.request_uri)
        request.basic_auth( Paynl::Config.username, Paynl::Config.password)
        http_response = http.request(request)
        if http_response.code == '200'
          parsed_response = Crack::XML.parse(http_response.body)
          response = Hashie::Mash.new(parsed_response)
          error!(response) if error?(response)
          clean(response)
        else
          raise Paynl::Exception, "http error: status code:#{http_response.code}, url:#{http_response.url}"
        end
      end

      private

      def method;     raise 'Implement me in a subclass'; end
      def clean;      raise 'Implement me in a subclass'; end
      def validate!;  raise 'Implement me in a subclass'; end

      def can_perform?
        Paynl::Config.username.present? && Paynl::Config.password.present?
      end

      def filtered(string)
        string.gsub(/(token:|token=)([0-9a-z]+)(\&|\@|)/) { |s| "#{$1}*******************#{$3}" }
      end

      def validate!
        result = self.class::MANDATORY_PARAMETERS.all? {|parameter| !@params[parameter].nil?}
        raise Paynl::Exception, "#{self.class.name}: Mandatory parameter missing. Excepted: #{self.class::MANDATORY_PARAMETERS}, Received: #{@params}" unless result
      end

      def uri
        [ base_uri, method, "/#{API_OUTPUT}/?", encoded_params ].join
      end

      def encoded_params
        params.to_query
      end

      def error?(response)
        return true if response&.data&.request&.result.nil?

        response.data.request.result == "0"
      end

      def error!(response)
        error_response = Paynl::ErrorResponse.new(response)
        raise Paynl::Exception.new(error_response.message, error_response.code) and return
      end

      def base_uri
        "https://rest-api.#{Paynl::Config.core || 'pay.nl'}/#{api_version}/#{api_namespace}/"
      end

    end
  end
end