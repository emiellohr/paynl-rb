module Paynl
  module Api
    class InstorePayment < Instore
      def initialize(token, service_id, transaction_id, terminal_id=nil)
        @token = token
        @service_id = service_id
        @transaction_id = transaction_id
        @terminal_id = terminal_id
      end

      def method
        'payment'
      end

      def params
        params = { token: @token,
          serviceId: @service_id,
          transactionId: @transaction_id }
        params[:terminalId] = @terminal_id if @terminal_id
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