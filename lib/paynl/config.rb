module Paynl
  class Config
    @@apiToken=''

    # apiToken - Retrieves Pay.nl api token
    def self.apiToken
      return @@apiToken
    end

    # apiToken= - Sets Pay.nl api token
    def self.apiToken=(apiToken)
      @@apiToken = apiToken
    end
  end
end