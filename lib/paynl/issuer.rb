module Paynl
  class Issuer
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

      ideal = result.NL.paymentOptionList.item.find {|item| item.name == "iDEAL"}
      ideal.paymentOptionSubList.item.map do |issuer|
        new(
          :id => issuer.id,
          :name => issuer.visibleName
        )
      end
    end

  end
end