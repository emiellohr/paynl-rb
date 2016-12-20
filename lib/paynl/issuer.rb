module Paynl
  class Issuer
    attr_accessor :id, :name

    def self.list(service_id)
      @list ||= find_all_from_api(service_id)
    end

    def self.find(issuer_id)
      list.select { |issuer| issuer.id.to_i == issuer_id.to_i }.first
    end

    def initialize(attributes = {})
      @id   = attributes[:id]
      @name = attributes[:name]
    end

    private

    def self.find_all_from_api(service_id)

      result = Paynl::Api::TransactionGetService.new(
        Paynl::Config.apiToken,
        service_id,
        paymentMethodId: 2).perform

      if result.countryOptionList.NL.paymentOptionList.item.is_a? Array
        ideal = result.countryOptionList.NL.paymentOptionList.item.find {|item| item.name == "iDEAL"}
      else
        ideal = result.countryOptionList.NL.paymentOptionList.item
      end
      ideal.paymentOptionSubList.item.map do |issuer|
        new(
          :id => issuer.id,
          :name => issuer.visibleName
        )
      end
    end

  end
end