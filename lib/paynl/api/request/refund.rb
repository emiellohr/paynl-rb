module Paynl
  module Api
    class Refund < Request

      def api_version
        'v2'
      end

      def api_namespace
        'Refund'
      end

    end
  end
end