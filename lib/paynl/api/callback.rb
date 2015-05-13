module Paynl
  module Api
    class Callback

      attr_accessor :token,
                    :service_id,
                    :transaction_id,
                    :entrance_code

      def initialize(attributes = {})
        attributes.each do |k,v|
          send("#{k}=", v)
        end
      end

      def valid?
        valid_callback == true
      end

      def validate!
        return true if valid_callback == true
        raise Paynl::Exception, "This callback is forged" and return if valid_callback == false
      end

      def success?
        @raw_response.paymentDetails.state == '100'
      end

      def expired?
        @raw_response.paymentDetails.state == '-80'
      end

      def cancelled?
        @raw_response.paymentDetails.state == '-90'
      end

      # def failure?
      #   @status == 'Failure'
      # end

      def pending?
        %w(20 25 50).include? @raw_response.paymentDetails.state
      end

      # def reversed?
      #   @status == 'Reversed'
      # end

      private

        def valid_callback
          true
          # string = [ @transaction_id, @entrance_code, @status, Sisow.configuration.merchant_id, Sisow.configuration.merchant_key ].join
          # calculated_sha1 = Digest::SHA1.hexdigest(string)

          # calculated_sha1 == @sha1
        end

        def response
          @raw_response ||= request.perform
        end

        def params
          { token: @token,
            service_id: @service_id,
            transaction_id: @transaction_id,
            entrance_code: @entrance_code }
        end

        def request
          @request ||= Paynl::Api::TransactionInfoRequest.new(params)
        end

    end
  end
end