module Paynl
  class TransactionStatus
    CHARGEBACK       = %w(-70 -71)
    PAID_CHECKAMOUNT = %w(-51)
    EXPIRED          = %w(-80)
    REFUND           = %w(-81)
    PARTIAL_REFUND   = %w(-82)
    PENDING          = %w(20 25 40 50 90)
    OPEN             = %w(60)
    CONFIRMED        = %w(75 76)
    PARTIAL_PAYMENT  = %w(80)
    VERIFY           = %w(85)
    PAID             = %w(100)
    CANCEL           = %w(-60 -90)
    DENIED           = %w(-63)

    def initialize(status)
      @status = status.to_s
    end

    def success?
      PAID.include?(@status)
    end

    def cancelled?
      CANCEL.include?(@status)
    end

    def expired?
      EXPIRED.include?(@status)
    end

    def failure?
      CANCEL.include?(@status)
    end

    def pending?
      PENDING.include?(@status)
    end
  end
end
