module Paynl
  module Api
    class AllianceGetMerchant < Alliance
      MANDATORY_PARAMETERS = [:merchantId]

      def initialize(merchantId)
        @params = { merchantId: merchantId }
      end

      def method
        'getMerchant'
      end

      def clean(response)
        response.data
      end
    end
  end
end
