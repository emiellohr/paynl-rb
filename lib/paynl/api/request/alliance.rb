module Paynl
  module Api
    class Alliance < Request

      API_VERSION   = 'v2'
      API_NAMESPACE = 'Alliance'

      def api_version
        API_VERSION
      end

      def api_namespace
        API_NAMESPACE
      end

    end
  end
end