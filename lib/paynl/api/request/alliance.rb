module Paynl
  module Api
    class Alliance < Request

      def api_version
        'v2'
      end

      def api_namespace
        'Alliance'
      end

    end
  end
end