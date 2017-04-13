module Paynl
  module Api
    class TransactionStart < Transaction
      MANDATORY_PARAMETERS = [:serviceId, :amount, :ipAddress, :finishUrl]
      OPTIONAL_PARAMETERS = [:paymentOptionId, :paymentOptionSubId, :transaction, :statsData,
        :enduser, :saleData, :testMode, :transferType, :transferValue]

      def initialize(serviceId, amount, ipAddress, finishUrl, options={})
        self.token_in_querystring = true
        @params = {
          token: Paynl::Config.api_token,
          serviceId: serviceId,
          amount: amount,
          ipAddress: ipAddress,
          finishUrl: finishUrl
        }
        super(options)
      end

      private

      def method
        'start'
      end

      def clean(response)
        if response.data? && response.data.transaction?
          response.data.transaction
        end
      end

    end
  end
end