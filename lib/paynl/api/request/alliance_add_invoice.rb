module Paynl
  module Api
    class AllianceAddInvoice < Alliance
      MANDATORY_PARAMETERS = [:serviceId, :merchantId, :invoiceId, :amount, :description]
      OPTIONAL_PARAMETERS = [:invoiceUrl, :makeYesterday]

      # options hash can hold the following:
      #   invoiceUrl - string - A URL pointing to the location of the invoice
      #   makeYesterday - boolean - Wether the transaction should be backdated to yesterday
      def initialize(serviceId, merchantId, invoiceId, amount, description, options={})
        @params = {
          serviceId: serviceId,
          merchantId: merchantId,
          invoiceId: invoiceId,
          amount: amount,
          description: description
        }
        super(options)
      end

      def method
        'addInvoice'
      end

      def clean(response)
        if response.data.referenceId?
          response.data.referenceId
        end
      end

    end
  end
end
