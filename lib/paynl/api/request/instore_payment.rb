module Paynl
  module Api
    class InstorePayment < Instore
      MANDATORY_PARAMETERS = [:serviceId, :transactionId]
      OPTIONAL_PARAMETERS = [:terminalId]

      def initialize(serviceId, transactionId, options={})
        @params = {
          serviceId: serviceId,
          transactionId: transactionId
        }
        super(options)
      end

      def method
        'payment'
      end

      def clean(response)
        response.data if response.data?
      end

    end
  end
end
