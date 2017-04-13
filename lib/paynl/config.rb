module Paynl
  class Config

    class << self
      attr_accessor :api_token, :valid_ips
    end

    # initialize - Set the api_token en retrieve valid callback ips
    def self.initialize(api_token, retrieve_valid_ips=true)
      @api_token = api_token
      @valid_ips = Api::ValidateGetPayServerIps.new.perform if retrieve_valid_ips
    end

    # apiToken= - Sets Pay.nl api token
    def self.apiToken=(api_token)
      @api_token = api_token
    end
  end
end