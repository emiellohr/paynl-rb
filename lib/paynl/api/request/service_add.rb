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
        response.data.status == "FALSE"
      end

      def error!(response)
        error_response = Paynl::ErrorResponse.new(nil, 'N/A', response.data.message)
        raise Paynl::Exception, error_response.message and return
      end

      def clean(response)
        if response.data.arrStatsData?
          response.data.arrStatsData
        end
      end

    end
  end
end
