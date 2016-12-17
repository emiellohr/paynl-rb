module Paynl
  module Api
    class DebitAdd < DirectDebit
      MANDATORY_PARAMETERS = [:serviceId, :amount, :bankaccountHolder, :bankaccountNumber]
      OPTIONAL_PARAMETERS = [:bankaccountBic, :processDate, :description, :ipAddress,
        :email, :promotorId, :tool, :info, :object, :extra1, :extra2, :extra3, :currency,
        :exchangeUrl]

      def initialize(serviceId, amount, bankaccountHolder, bankaccountNumber, options={})
        @params = {
          serviceId: serviceId,
          amount: amount,
          bankaccountHolder: bankaccountHolder,
          bankaccountNumber: bankaccountNumber
        }
        super(options)
      end

      def method
        'debitAdd'
      end

      def clean(response)
        response.data if response.data?
      end

    end
  end
end
