module Paynl
  module Api
    class Callback
      attr_accessor :service_id,
                    :transaction_id

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
        fail Paynl::Exception, "This callback is forged, remote_ip: #{@remote_ip}"
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
        if Paynl::Config.valid_ips && @remote_ip
          Paynl::Config.valid_ips.include?(@remote_ip)
        else
          true # no ip check
        end
      end

      def response
        @raw_response ||= request.perform
        @status = Paynl::TransactionStatus.new(@raw_response.paymentDetails.state)
        @raw_response
      end

      def request
        @request ||= Paynl::Api::TransactionStatus.new(@transaction_id)
      end
    end
  end
end
