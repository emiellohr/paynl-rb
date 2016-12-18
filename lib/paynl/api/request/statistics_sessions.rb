module Paynl
  module Api
    class StatisticsSessions < Statistics
      MANDATORY_PARAMETERS = [:startDate, :endDate]
      OPTIONAL_PARAMETERS = [:filterType, :filterOperator, :filterValue, :staffels, :page,
        :pageAmount, :currencyId, :separateSwitchesFromParents]

      def initialize(startDate, endDate, options={})
        @params = {
          startDate: startDate,
          endDate: endDate
        }
        super(options)
      end

      private

      def method
        'sessions'
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
