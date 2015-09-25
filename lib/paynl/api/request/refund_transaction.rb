module Paynl
  module Api
    class RefundTransaction < Refund

      # transactionId: The ID of the transaction.
      # --- Optional ---
      # amount: The amount to be paid should be given in cents. For example € 3.50 becomes 350.
      # description: Description to include with the payment.
      # processDate: The date on which the refund needs to be processed, format Y-m-d (eg. 2014-12-31).

      def initialize(token, service_id, transaction_id, options={})
        @token = token
        @service_id = service_id
        @transaction_id = transaction_id
        @options = ActiveSupport::HashWithIndifferentAccess.new(options)
      end

      def method
        'transaction'
      end

      def params
        params = { token: @token,
          serviceId: @service_id,
          transactionId: @transaction_id }
        %w(amount description processDate).each do |key|
          params[key.to_sym] = @options[key] if @options.has_key?(key)
        end
        params
      end

      def clean(response)
        if response.data?
          response.data
        end
      end

      def validate!
        !@transaction_id.nil?
      end

    end
  end
end