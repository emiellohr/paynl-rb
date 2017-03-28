module Paynl
  module Api
    class AllianceAddService < Alliance
      MANDATORY_PARAMETERS = [:merchantId, :name, :description, :categoryId, :publication]
      OPTIONAL_PARAMETERS = [:publicationUrls, :paymentOptions, :exchange]

      def initialize(merchantId, name, description, categoryId, publication, options={})
        @params = {
          merchantId: merchantId,
          name: name,
          description: description,
          categoryId: categoryId,
          publication: publication
        }
        super(options)
      end

      def method
        'addService'
      end

      def clean(response)
        if response.data.serviceId?
          response.data.serviceId
        end
      end

    end
  end
end
