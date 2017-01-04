module Paynl
  module Api
    class DirectDebitInfo < DirectDebit
      MANDATORY_PARAMETERS = [:mandateId]
      OPTIONAL_PARAMETERS = [:referenceId]

      def initialize(mandateId, options = {})
        @params = { mandateId: mandateId }
        super(options)
      end

      private

      def error?(response)
        !!response.data.request.errorId
      end

      def method
        'info'
      end

      def clean(response)
        response.data.result if response.data.result?
      end
    end
  end
end
