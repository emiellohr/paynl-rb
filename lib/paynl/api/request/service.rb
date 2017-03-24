module Paynl
  module Api
    class Service < Request
      def api_version
        'v3'
      end

      def api_namespace
        'Service'
      end
    end
  end
end
