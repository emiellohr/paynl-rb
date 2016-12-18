require 'spec_helper'

describe Paynl::Api::DirectDebit do

  subject { Paynl::Api::DirectDebitDebitAdd.new('SL-123-123', 123, 'Emiel Lohr', 'NL91ABNA0417164300') }

  describe "DebitAdd" do

    it "should return a mandateId for succesfull directdebit" do
      Paynl::Config.apiToken = '1234token5678'
      stub_request(:get, "https://token:1234token5678@rest-api.pay.nl/v3/DirectDebit/debitAdd/xml/?amount=123&bankaccountHolder=Emiel%20Lohr&bankaccountNumber=NL91ABNA0417164300&serviceId=SL-123-123").
        to_return(:status => 200, :body => Paynl::Api::DirectDebitDebitAdd::CALLBACK_XML, :headers => {})
      response = subject.perform
      expect(response.request.result).to eql('12345')
    end

    it "should raise exception when called with invalid arguments" do
      Paynl::Config.apiToken = '1234token5678'
      stub_request(:get, "https://token:1234token5678@rest-api.pay.nl/v3/DirectDebit/debitAdd/xml/?amount=123&bankaccountHolder=Emiel%20Lohr&bankaccountNumber=NL91ABNA0417164300&serviceId=SL-123-123").
        to_return(:status => 200, :body => Paynl::Api::DirectDebitDebitAdd::ERROR_CALLBACK_XML, :headers => {})
      expect { subject.perform }.to raise_error(Paynl::Exception, "An error occurred: 404. Amount must be a positive value")
    end

  end
end

Paynl::Api::DirectDebitDebitAdd::CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <result>12345</result>
  </request>
</data>
EOF

Paynl::Api::DirectDebitDebitAdd::ERROR_CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <errorId>404</errorId>
    <errorMessage>Amount must be a positive value</errorMessage>
  </request>
</data>
EOF
