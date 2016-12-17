module Paynl
  module Api
    class TransactionStart < Transaction
      MANDATORY_PARAMETERS = [:serviceId, :amount, :ipAddress, :finishUrl]
      OPTIONAL_PARAMETERS = [:paymentOptionId, :paymentOptionSubId, :transaction, :statsData, :enduser,
        :saleData, :testMode, :transferType, :transferValue]

      def initialize(serviceId, amount, ipAddress, finishUrl, options={})
        self.token_in_querystring = true
        @payment = payment

        @params = {
          token: Paynl::Config.apiToken,
          serviceId: serviceId,
          amount: amount,
          ipAddress: ipAddress,
          finishUrl: finishUrl
        }
        super(options)
      end

      private

      def method
        'start'
      end

      # def params
      #   params = {
      #     token: @payment.token,
      #     serviceId: @payment.service_id,
      #     amount: @payment.amount,
      #     ipAddress: @payment.ip_address,
      #     finishUrl: @payment.return_url,
      #     paymentOptionId: @payment.payment_method_id,
      #     paymentOptionSubId: @payment.issuer_id,
      #     transaction: {
      #       orderExchangeUrl: @payment.callback_url,
      #       description: @payment.description
      #       },
      #     statsData: @payment.stats_data,
      #     enduser: @payment.end_user,
      #     saleData: @payment.sale_data,
      #     testMode: @payment.test_mode
      #   }
      #   sweep(params)
      # end

      # def sweep(params)
      #   params.each do |key, value|
      #     params.delete(key) if value.nil?
      #     if value.is_a?(Hash)
      #       if value.empty?
      #         params.delete(key)
      #       else
      #         value.each do |key, nested_value|
      #           value.delete(key) if nested_value.nil?
      #         end
      #       end
      #     end
      #   end
      #   params
      # end

      def clean(response)
        if response.data? && response.data.transaction?
          response.data.transaction
        end
      end

    end
  end
end