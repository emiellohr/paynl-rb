module Paynl
  module Api
    class Validate < Request

      def api_version
        'v1'
      end

      def api_namespace
        'Validate'
      end

    end
  end
end