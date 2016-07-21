module Paynl
  module Api
    class AllianceGetMerchant < Alliance

      def initialize(token, merchant_id)
        @params = {
          token: token,
          serviceId: 'dummy',
          merchantId: merchant_id,
        }
      end

      def method
        'getMerchant'
      end

      def params
        @params
      end

      def clean(response)
        response.data
      end

      def validate!
        !@params[:merchantId].nil?
      end

    end
  end
end
