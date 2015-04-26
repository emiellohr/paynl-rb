module Paynl
  class ErrorResponse
    attr_accessor :code, :message

    def initialize(response)
      @code    = response.data.request.errorId
      @message = response.data.request.errorMessage
    end

    def message
      "An error occurred: #{@code}. #{@message}"
    end
  end
end