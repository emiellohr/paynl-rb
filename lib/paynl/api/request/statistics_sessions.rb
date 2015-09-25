module Paynl
  module Api
    class StatisticsSessions < Statistics

      def initialize(token, start_date, end_date, filter_types=[], filter_operators=[], filter_values=[])
        @token = token
        @start_date = start_date
        @end_date = end_date
        @filter_types = filter_types
        @filter_operators = filter_operators
        @filter_values = filter_values
      end

      private

      def can_perform?
        !params[:token].nil?
      end

      def method
        'sessions'
      end

      def params
        { token: @token,
          startDate: @start_date,
          endDate: @end_date,
          filterType: @filter_types,
          filterOperator: @filter_operators,
          filterValue: @filter_values }
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

      def validate!
        true
      end

    end
  end
end
