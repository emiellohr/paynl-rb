module Paynl
  module Api
    class ValidateGetPayServerIps < Validate
      def initialize
        @params = {}
      end

      private

      def method
        'getPayServerIps'
      end

      def can_perform?
        true
      end

      def error?(response)
        false
      end

      def clean(response)
        if response.data? && response.data.item?
          response.data.item.to_a
        end
      end
    end
  end
end
