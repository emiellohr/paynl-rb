module Paynl
  module Api
    class RefundTransaction < Refund
      MANDATORY_PARAMETERS = [:serviceId, :transactionId]
      OPTIONAL_PARAMETERS = [:amount, :description, :processDate]

      def initialize(serviceId, transactionId, options={})
        @params = {
          serviceId: serviceId,
          transactionId: transactionId
        }
        super(options)
      end

      def method
        'transaction'
      end

      def clean(response)
        if response.data?
          response.data
        end
      end

    end
  end
end