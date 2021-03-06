module Paynl
  module Api
    class TransactionGetService < Transaction
      MANDATORY_PARAMETERS = [:serviceId]
      OPTIONAL_PARAMETERS = [:paymentMethodId]

      def initialize(serviceId, options={})
        # self.token_in_querystring = true
        @params = {
          # token: Paynl::Config.api_token,
          serviceId: serviceId
        }
        super(options)
      end

      private

      def api_version
        'v16'
      end

      def method
        'getService'
      end

      def clean(response)
        if response.data?
          response.data
        end
      end

    end
  end
end