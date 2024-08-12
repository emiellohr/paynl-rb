module Paynl
  class Exception < StandardError

    PAYMENT_METHOD_UNAVAILABLE = 0
    MERCHANT_BALANCE_IS_TOO_LOW = 101
    INVALID_ID_TRANSACTION_ID = 404
    TERMINAL_NOT_FOUND = 9110
    TERMINAL_IN_USE = 9206

    attr_accessor :id

    def initialize(msg, id=nil)
      @id = id
      super(msg)
    end

    def payment_method_unavailable?
      @id == PAYMENT_METHOD_UNAVAILABLE
    end

    def merchant_balance_too_low?
      @id == MERCHANT_BALANCE_IS_TOO_LOW
    end

    def terminal_not_found?
      @id == TERMINAL_NOT_FOUND
    end

    def terminal_in_use?
      @id == TERMINAL_IN_USE
    end

    def invalid_transaction_id?
      @id == INVALID_ID_TRANSACTION_ID
    end

  end
end