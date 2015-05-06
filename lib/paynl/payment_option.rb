module Paynl
  class PaymentOption
    attr_accessor :id, :name

    def self.list(token, service_id)
      @list ||= find_all_from_api(token, service_id)
    end

    def self.find(issuer_id)
      list.select { |issuer| issuer.id.to_i == issuer_id.to_i }.first
    end

    def initialize(attributes = {})
      @id   = attributes[:id]
      @name = attributes[:name]
    end

    private

    def self.find_all_from_api(token, service_id)

      payment_attributes = {
        token: token,
        service_id: service_id,
        payment_method_id: 2}

      result = Paynl::Api::TransactionGetServiceRequest.new(payment_attributes).perform

      payment_options = []
      result.countryOptionList.each do |country, values|
        if values.paymentOptionList.item.is_a?(Array)
          payment_options += values.paymentOptionList.item
        else
          payment_options << values.paymentOptionList.item
        end
      end

      payment_options.map do |payment_option|
        new(
          :id => payment_option.id,
          :name => payment_option.visibleName
        )
      end
    end

  end
end