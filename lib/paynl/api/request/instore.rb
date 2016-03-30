module Paynl
  module Api
    class Instore < Request

      def api_version
        'v2'
      end

      def api_namespace
        'Instore'
      end

    end
  end
end