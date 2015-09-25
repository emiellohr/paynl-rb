require 'spec_helper'

describe Paynl::Api::RefundTransaction do

  subject { Paynl::Api::RefundTransaction.new('1234token5678', 'SL-123-123', 'my_transaction_id', {amount: 10, description: 'Test', processDate: '2025-12-31'}) }

  describe "transaction" do

    it "should return a refundId for succesfull refund" do
      stub_request(:get, "https://rest-api.pay.nl/v2/Refund/transaction/xml/?amount=10&description=Test&processDate=2025-12-31&serviceId=SL-123-123&token=1234token5678&transactionId=my_transaction_id").
        to_return(:status => 200, :body => Paynl::Api::RefundTransaction::CALLBACK_XML, :headers => {})
      result = subject.perform
      expect(result.refundId).to eql('12345')
    end

    it "should raise exception when called with invalid arguments" do
      stub_request(:get, "https://rest-api.pay.nl/v2/Refund/transaction/xml/?amount=10&description=Test&processDate=2025-12-31&serviceId=SL-123-123&token=1234token5678&transactionId=my_transaction_id").
        to_return(:status => 200, :body => Paynl::Api::RefundTransaction::ERROR_CALLBACK_XML, :headers => {})
      expect { subject.perform }.to raise_error(Paynl::Exception, "An error occurred: 404. Amount must be a positive value")
    end

  end
end

Paynl::Api::RefundTransaction::CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <result>1</result>
  </request>
  <refundId>12345</refundId>
</data>
EOF

Paynl::Api::RefundTransaction::ERROR_CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <result>0</result>
    <errorId>404</errorId>
    <errorMessage>Amount must be a positive value</errorMessage>
  </request>
</data>
EOF
