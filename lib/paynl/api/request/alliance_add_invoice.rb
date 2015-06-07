module Paynl
  module Api
    class AllianceAddInvoice < Alliance

      attr_accessor :merchant_id, :invoice_id, :amount, :description, :invoice_url

      def initialize(token, service_id, merchant_id, invoice_id, amount, description, invoice_url)
        @token = token
        @service_id = service_id
        @merchant_id = merchant_id
        @invoice_id = invoice_id
        @amount = amount
        @description = description
        @invoice_url = invoice_url
      end

      def method
        'addInvoice'
      end

      def params
        { token: @token,
          serviceId: @service_id,
          merchantId: @merchant_id,
          invoiceId: @invoice_id,
          amount: @amount,
          description: @description,
          invoiceUrl: @invoice_url }
      end

      def clean(response)
        if response.data.referenceId?
          response.data.referenceId
        end
      end

      def validate!
        true
      end

    end
  end
end
