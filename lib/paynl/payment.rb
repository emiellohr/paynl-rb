module Paynl
  class Payment

    attr_accessor :service_id,
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

    def initialize(attributes={})
      @test_mode = 1
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
      transaction = {}
      if @callback_url
        @transaction[:orderExchangeUrl] = @callback_url
      end

      if @description
        @transaction[:description] = @description
      end

      options = {testMode: test_mode}
      if @payment_method_id
        options[:paymentOptionId] = @payment_method_id
      end

      if @issuer_id
        options[:paymentOptionSubId] = @issuer_id
      end

      unless transaction.empty?
        options[:transaction] = transaction
      end

      if @end_user && @end_user.is_a?(Hash) && !@end_user.empty?
        options[:enduser] = @end_user
      end

      if @stats_data && @stats_data.is_a?(Hash) && !@stats_data.empty?
        options[:statsData] = @stats_data
      end

      if @sale_data && @sale_data.is_a?(Hash) && !@sale_data.empty?
        options[:saleData] = @sale_data
      end

      @request ||= Paynl::Api::TransactionStart.new(
        service_id,
        amount,
        ip_address,
        return_url,
        options)
    end

  end
end