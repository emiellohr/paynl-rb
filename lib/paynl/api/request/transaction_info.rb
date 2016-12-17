module Paynl
  module Api
    class TransactionInfo < Transaction
      MANDATORY_PARAMETERS = [:transactionId]
      OPTIONAL_PARAMETERS = [:entranceCode]

      def initialize(transactionId, options={})
        @params = {
          transactionId: transactionId
        }
        super(options)
      end

      private

      def method
        'info'
      end

      def clean(response)
        if response.data?
          response.data
        end
      end

    end
  end
end