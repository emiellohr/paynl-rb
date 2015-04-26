module Paynl
  class Payment

    attr_accessor :token,
                  :service_id,
                  :description,
                  :amount,
                  :ip_address,
                  :return_url,
                  :callback_url,
                  :payment_method_id,
                  :issuer_id

    def initialize(attributes = {})
      attributes.each do |k,v|
        send("#{k}=", v)
      end
    end

    def payment_url
      CGI::unescape(response.paymentURL) if response.paymentURL?
    end

    def transaction_id
      response.transactionId if response.transactionId?
    end

    # def valid?
    #   entrance_code.index(/-|_/).nil? &&
    #   purchase_id.index(/\#|_/).nil? &&
    #   (!amount.nil? && amount != '') &&
    #   !merchant_id.blank? && !merchant_key.blank?
    # end

    # def ideal?
    #   payment_method == 'ideal'
    # end

    # def test_mode_enabled?
    #   test_mode == true
    # end

    # def payment_method; raise 'Implement me in a subclass'; end

    # def validity_string(response)
    #   [ response.transactionrequest.transaction.trxid,
    #     response.transactionrequest.transaction.issuerurl,
    #     merchant_id,
    #     merchant_key
    #   ].join
    # end

    private

      def response
        @raw_response ||= request.perform
      end

      def request
        @request ||= Paynl::Api::TransactionStartRequest.new(self)
      end

  end
end