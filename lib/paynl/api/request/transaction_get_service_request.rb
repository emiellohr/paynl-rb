module Paynl
  module Api
    class TransactionGetServiceRequest < Transaction

      attr_accessor :payment_method_id

      def initialize(attributes = {})
        @payment_method_id = 2
        attributes.each do |k,v|
          send("#{k}=", v)
        end
      end

      def method
        'getService'
      end

      def params
        { token: @token,
          serviceId: @service_id,
          paymentMethodId: @payment_method_id }
      end

      def clean(response)
        if response.data?
          response.data
        end
      end

      def validate!
        true
      end

    end
  end
end