module Paynl
  module Api
    class Transaction < Request

      API_VERSION   = 'v5'
      API_NAMESPACE = 'Transaction'

      def api_version
        API_VERSION
      end

      def api_namespace
        API_NAMESPACE
      end

    end
  end
end