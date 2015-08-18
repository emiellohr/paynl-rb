module Paynl
  module Api
    class Statistics < Request

      def api_version
        'v5'
      end

      def api_namespace
        'Statistics'
      end

    end
  end
end