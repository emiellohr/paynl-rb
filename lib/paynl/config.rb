module Paynl
  class Config

    class << self
      attr_accessor :username, :password, :valid_ips, :debug, :core
    end

    # initialize - Set the api_token en retrieve valid callback ips
    def self.initialize(username, password, options={})
      @username = username
      @password = password
      @debug = options[:debug] ? options[:debug] : false
      @core = options[:core] ? options[:core] : nil
      @valid_ips = Api::ValidateGetPayServerIps.new.perform if options[:retrieve_valid_ips] == true
    end

  end
end