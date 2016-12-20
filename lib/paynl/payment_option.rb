module Paynl
  class PaymentOption
    attr_accessor :id, :name

    def self.list(service_id, cached=true)
      return @list if @list && cached
      @list = find_all_from_api(service_id)
    end

    def self.find(payment_option_id)
      list.select { |issuer| issuer.id.to_i == payment_option_id.to_i }.first
    end

    def initialize(attributes = {})
      @id   = attributes[:id]
      @name = attributes[:name]
    end

    private

    def self.find_all_from_api(service_id)

      result = Paynl::Api::TransactionGetService.new(
        service_id,
        paymentMethodId: 2).perform

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