module Paynl
  module Api
    class TransactionStatus < Transaction
      MANDATORY_PARAMETERS = [:transactionId]

      def initialize(transactionId, options={})
        @params = {
          transactionId: transactionId
        }
        super(options)
      end

      private

      def api_version
        'v12'
      end

      def method
        'status'
      end

      def clean(response)
        if response.data?
          response.data
        end
      end

    end
  end
end