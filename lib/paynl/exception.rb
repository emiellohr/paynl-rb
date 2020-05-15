module Paynl
  class Exception < StandardError

    PAYMENT_METHOD_UNAVAILABLE = 0
    MERCHANT_BALANCE_IS_TOO_LOW = 101
    INVALID_ID_TRANSACTION_ID = 404

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

    def merchant_balance_too_low?
      @id == MERCHANT_BALANCE_IS_TOO_LOW
    end

    def invalid_transaction_id?
      @id == INVALID_ID_TRANSACTION_ID
    end

  end
end