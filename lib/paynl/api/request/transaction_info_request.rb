module Paynl
  module Api
    class TransactionInfoRequest < Request

      attr_accessor :transaction_id,
                    :entrance_code

      def initialize(attributes = {})
        attributes.each do |k,v|
          send("#{k}=", v)
        end
      end

      def method
        'info'
      end

      def params
        { token: @token,
          serviceId: @service_id,
          transactionId: @transaction_id,
          entranceCode: @entrance_code }
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