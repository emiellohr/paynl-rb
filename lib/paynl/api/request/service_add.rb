module Paynl
  module Api
    class ServiceAdd < Service
      MANDATORY_PARAMETERS = [:name, :description, :categoryId, :paymentOptions, :submoduleId, :publication]
      OPTIONAL_PARAMETERS = [:publicationUrls, :programId, :contentCategoryId, :pluginVersionId, :testmode, :alwaysSendExchange, :enableAllPaymentOptions]

      def initialize(name, description, categoryId, paymentOptions, submoduleId, publication, options={})
        @params = {
          name: name,
          description: description,
          categoryId: categoryId,
          paymentOptions: paymentOptions,
          submoduleId: submoduleId,
          publication: publication
        }
        super(options)
      end

      private

      def method
        'add'
      end

      def error?(response)
        false
      end

      def error!(response)
        true
      end

      def clean(response)
        response
      end

    end
  end
end
