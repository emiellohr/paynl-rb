module Paynl
  module Api
    class DirectDebit < Request

      def api_version
        'v3'
      end

      def api_namespace
        'DirectDebit'
      end

    end
  end
end