module Paynl
  class Config

    class << self
      attr_accessor :username, :password, :valid_ips, :debug
    end

    # initialize - Set the api_token en retrieve valid callback ips
    def self.initialize(username, password, options={})
      @debug = false

      @username = username
      @password = password

      @valid_ips = Api::ValidateGetPayServerIps.new.perform if options[:retrieve_valid_ips] == true
    end

  end
end