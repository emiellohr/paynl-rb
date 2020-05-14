module Paynl
  module Api
    class Transaction < Request

      def api_version
        'v7'
      end

      def api_namespace
        'Transaction'
      end

    end
  end
end