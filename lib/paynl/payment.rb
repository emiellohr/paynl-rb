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
                  :issuer_id,
                  :end_user,
                  :sale_data,
                  :stats_data,
                  :test_mode

    def initialize(attributes = {})
      @test_mode = 1
      @end_user = {}
      @sale_data = {}
      @stats_data = {}

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

    private

    def response
      @raw_response ||= request.perform
    end

    def request
      @request ||= Paynl::Api::TransactionStartRequest.new(self)
    end

  end
end