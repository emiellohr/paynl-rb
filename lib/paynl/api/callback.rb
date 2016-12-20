module Paynl
  module Api
    class Callback
      VALID_IPS =
        [
          '85.158.206.17', '85.158.206.18', '85.158.206.19', '10.35.37.5',
          '85.158.206.20', '85.158.206.21', '37.46.137.128', '37.46.137.129',
          '37.46.137.130', '37.46.137.131', '37.46.137.132', '37.46.137.133',
          '37.46.137.134', '37.46.137.135', '37.46.137.136', '37.46.137.137',
          '37.46.137.138', '37.46.137.139', '37.46.137.140', '37.46.137.141',
          '37.46.137.142', '37.46.137.143', '37.46.137.144', '37.46.137.145',
          '37.46.137.146', '37.46.137.147', '37.46.137.148', '37.46.137.149',
          '37.46.137.150', '37.46.137.151', '37.46.137.152', '37.46.137.153',
          '37.46.137.154', '37.46.137.155', '37.46.137.156', '37.46.137.157',
          '37.46.137.158', '172.16.2.141', '172.16.2.142', '172.16.2.143',
          '172.16.2.144', '10.35.37.4'
        ]

      attr_accessor :service_id,
                    :transaction_id,
                    :entrance_code

      def initialize(attributes = {}, remote_ip = nil)
        attributes.each do |k, v|
          send("#{k}=", v)
        end
        @remote_ip = remote_ip
      end

      def valid?
        valid_callback == true
      end

      def validate!
        return true if valid_callback == true
        fail Paynl::Exception, 'This callback is forged'
      end

      def success?
        response && @status.success?
      end

      def cancelled?
        response && @status.cancelled?
      end

      def expired?
        response && @status.expired?
      end

      # depricated, since pay.nl doesn't has changed -60
      # to canceled (was failure).
      def failure?
        response && @status.failure?
      end

      def pending?
        response && @status.pending?
      end

      # def reversed?
      #   @status == 'Reversed'
      # end

      def data
        response
      end

      private

      def valid_callback
        @remote_ip.nil? ? true : VALID_IPS.include?(@remote_ip)
      end

      def response
        @raw_response ||= request.perform
        @status = Paynl::TransactionStatus.new(@raw_response.paymentDetails.state)
        @raw_response
      end

      def request
        @request ||= Paynl::Api::TransactionInfo.new(
          @transaction_id,
          entranceCode: @entrance_code
        )
      end
    end
  end
end
