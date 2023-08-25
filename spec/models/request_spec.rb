require 'spec_helper'

describe Paynl::Api::Request do

  describe "setup" do

    it "Raises an exception when the configuration is invalid" do
      Paynl::Config.api_token = nil
      expect {
        Paynl::Api::Request.new.perform
      }.to raise_error(Paynl::Exception, "No api token configured.")
    end

  end

  describe "general" do
    before :each do
      Paynl::Config.api_token = '1234token5678'
    end

    it "should raise exception when called with invalid filter field" do
      expect(Paynl::Config.api_token).to eql('1234token5678')

      stub_request(:get, "https://1234token5678@rest-api.pay.nl/v12/Transaction/status/xml/?transactionId=pay_id").
         with(
           headers: {
          'Accept'=>'*/*',
           }).
         to_return(status: 200, body: Paynl::Api::AllianceAddInvoice::SUCCESS_XML, headers: {})


      callback = Paynl::Api::Callback.new(service_id: 'order.account.paynl_service_id',
                                    transaction_id: 'pay_id')
      expect(callback.valid?).to be true
      expect(callback.success?).to be true
    end

    it "should return statistics on successfull calls" do
      expect( Paynl::Api::Request.new.send('can_perform?') ).to be true
    end

  end
end

Paynl::Api::AllianceAddInvoice::SUCCESS_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <result>1</result>
    <errorId></errorId>
    <errorMessage></errorMessage>
  </request>
  <paymentDetails>
    <transactionId>EX-4296-9358-1211</transactionId>
    <orderId>2182669368X83636</orderId>
    <paymentProfileId>10</paymentProfileId>
    <state>100</state>
    <stateName>PAID</stateName>
    <amount>
      <value>9480</value>
      <currency>EUR</currency>
    </amount>
    <created>2023-08-25 16:12:56</created>
    <identifierName>M. Prins eo J.I.A. Hendriks</identifierName>
    <identifierPublic>NL98RABO0334692814</identifierPublic>
    <identifierHash>a8491d6adf70fc132281909069f64cd1</identifierHash>
    <startIpAddress>84.85.164.201</startIpAddress>
    <completedIpAddress>84.85.164.201</completedIpAddress>
    <orderNumber></orderNumber>
    <amountOriginal>
      <value>9480</value>
      <currency>EUR</currency>
    </amountOriginal>
    <amountPaidOriginal>
      <value>9480</value>
      <currency>EUR</currency>
    </amountPaidOriginal>
    <amountPaid>
      <value>9480</value>
      <currency>EUR</currency>
    </amountPaid>
    <amountRefundOriginal>
      <value>0</value>
      <currency>EUR</currency>
    </amountRefundOriginal>
    <amountRefund>
      <value>0</value>
      <currency>EUR</currency>
    </amountRefund>
  </paymentDetails>
</data>
EOF




