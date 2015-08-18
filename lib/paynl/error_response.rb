module Paynl
  class ErrorResponse
    attr_accessor :code, :message

    def initialize(response=nil, code=nil, message=nil)
      if response
        @code    = response.data.request.errorId
        @message = response.data.request.errorMessage
      else
        @code = code
        @message = message
      end
    end

    def message
      "An error occurred: #{@code}. #{@message}"
    end
  end
end