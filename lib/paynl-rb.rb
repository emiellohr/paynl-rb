require 'active_support'
require 'active_support/core_ext/object/to_param'
require 'active_support/core_ext/hash/indifferent_access'
require 'cgi'
require 'crack/xml'
require 'hashie'
require 'net/http'
require 'uri'

require 'paynl/api/callback'
require 'paynl/api/request'
require 'paynl/api/request/alliance'
require 'paynl/api/request/alliance_add_invoice'
require 'paynl/api/request/alliance_add_service'
require 'paynl/api/request/alliance_get_merchant'
require 'paynl/api/request/direct_debit'
require 'paynl/api/request/direct_debit_debit_add'
require 'paynl/api/request/direct_debit_info'
require 'paynl/api/request/instore'
require 'paynl/api/request/instore_payment'
require 'paynl/api/request/refund'
require 'paynl/api/request/refund_transaction'
require 'paynl/api/request/service'
require 'paynl/api/request/service_add'
require 'paynl/api/request/statistics'
require 'paynl/api/request/statistics_sessions'
require 'paynl/api/request/transaction'
require 'paynl/api/request/transaction_get_service'
require 'paynl/api/request/transaction_start'
require 'paynl/api/request/transaction_info'
require 'paynl/api/request/transaction_status'
require 'paynl/api/request/validate'
require 'paynl/api/request/validate_get_pay_server_ips'
require 'paynl/error_response'
require 'paynl/payment_option'
require 'paynl/transaction_status'
require 'paynl/config'
require 'paynl/exception'
require 'paynl/issuer'
require 'paynl/payment'

module Paynl
  class << self
    attr_writer :logger

    def logger
      if Paynl::Config.debug
        @logger ||= Logger.new($stdout).tap do |log|
          log.progname = self.name
        end
      else
        @logger = NullLoger.new
      end
    end
  end
end

class NullLoger < Logger
  def initialize(*args)
  end

  def add(*args, &block)
  end
end