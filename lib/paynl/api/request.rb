module Paynl
  module Api
    class Request

      API_OUTPUT    = 'xml'

      attr_accessor :token,
                    :service_id

      def perform
        raise Paynl::Exception, 'Your token or service_id are not set' unless can_perform?

        validate!

        http_response = HTTPI.get(base_uri + uri)
        parsed_response = Crack::XML.parse(http_response.body)
        response = Hashie::Mash.new(parsed_response)

        error!(response) if error?(response)

        clean(response)
      end

      def params;     raise 'Implement me in a subclass'; end
      def method;     raise 'Implement me in a subclass'; end
      def clean;      raise 'Implement me in a subclass'; end
      def validate!;  raise 'Implement me in a subclass'; end

      private

      def can_perform?
        !(params[:token].nil? || params[:serviceId].nil?)
      end

      def uri
        [ method, "/#{API_OUTPUT}/?", encoded_params ].join
      end

      def encoded_params
        # URI.encode(params.to_query)
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
        "https://rest-api.pay.nl/#{api_version}/#{api_namespace}/"
      end

    end
  end
end