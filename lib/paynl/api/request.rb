module Paynl
  module Api
    class Request
      attr_reader :params
      attr_accessor :token_in_querystring

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

        paynl_request_url = base_uri + uri
        Paynl.logger.info "Request -- " + filtered(paynl_request_url)

        http_response = HTTPI.get(paynl_request_url)
        parsed_response = Crack::XML.parse(http_response.body)
        response = Hashie::Mash.new(parsed_response)

        error!(response) if error?(response)

        clean(response)
      end

      private

      def method;     raise 'Implement me in a subclass'; end
      def clean;      raise 'Implement me in a subclass'; end
      def validate!;  raise 'Implement me in a subclass'; end

      def can_perform?
        !Paynl::Config.api_token.empty?
      end

      def filtered(string)
        string.gsub(/(token:|token=)([0-9a-z]+)(\&|\@|)/) { |s| "#{$1}*******************#{$3}" }
      end

      def validate!
        result = self.class::MANDATORY_PARAMETERS.all? {|parameter| !@params[parameter].nil?}
        raise Paynl::Exception, "#{self.class.name}: Mandatory parameter missing. Excepted: #{self.class::MANDATORY_PARAMETERS}, Received: #{@params}" unless result
      end

      def uri
        [ method, "/#{API_OUTPUT}/?", encoded_params ].join
      end

      def encoded_params
        params.to_query
      end

      def error?(response)
        response.data.request.result == "0"
      end

      def error!(response)
        error_response = Paynl::ErrorResponse.new(response)
        raise Paynl::Exception, error_response.message and return
      end

      def base_uri
        if token_in_querystring
          "https://rest-api.pay.nl/#{api_version}/#{api_namespace}/"
        else
          "https://token:#{Paynl::Config.api_token}@rest-api.pay.nl/#{api_version}/#{api_namespace}/"
        end
      end

    end
  end
end