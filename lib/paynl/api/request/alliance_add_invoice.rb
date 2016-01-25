module Paynl
  module Api
    class AllianceAddInvoice < Alliance

      KEY_TRANSLATIONS = { 
        :invoice_url => :invoiceUrl, 
        :make_yesterday => :makeYesterday
      }

      # options hash can hold the following:
      #   invoice_url - string - A URL pointing to the location of the invoice
      #   make_yesterday - boolean - Wether the transaction should be backdated to yesterday
      def initialize(token, service_id, merchant_id, invoice_id, amount, description, options={})
        @params = {
          token: token,
          serviceId: service_id,
          merchantId: merchant_id,
          invoiceId: invoice_id,
          amount: amount,
          description: description
        }

        options.each do |key, value|
          next unless KEY_TRANSLATIONS.has_key?(key)
          @params[KEY_TRANSLATIONS[key]] = value
        end
      end

      def method
        'addInvoice'
      end

      def params
        @params
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
