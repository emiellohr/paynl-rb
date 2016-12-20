require 'spec_helper'

describe Paynl::Api::Callback do

  before :each do
    @service_id  = 'SL-123-123'
    @transaction_id = 'trx-123'
    Paynl::Config.apiToken = '1234token5678'
  end

  describe "transaction status" do

    it "should be success" do
      prepare_and_call_callback('100')
      expect(@callback.expired?).to eq(false)
      expect(@callback.cancelled?).to eq(false)
      expect(@callback.success?).to eq(true)
    end

    it "should be expired" do
      prepare_and_call_callback('-80')
      expect(@callback.success?).to eq(false)
      expect(@callback.cancelled?).to eq(false)
      expect(@callback.expired?).to eq(true)
    end

    it "should be cancelled" do
      prepare_and_call_callback('-90')
      expect(@callback.success?).to eq(false)
      expect(@callback.expired?).to eq(false)
      expect(@callback.cancelled?).to eq(true)
    end

    it "should be pending" do
      prepare_and_call_callback('20')
      expect(@callback.success?).to eq(false)
      expect(@callback.expired?).to eq(false)
      expect(@callback.cancelled?).to eq(false)
      expect(@callback.pending?).to eq(true)
    end

  end

  describe "check remote_ip" do

    it "should be success with valid remote_ip" do
      prepare_and_call_callback('100', '85.158.206.17')
      expect{@callback.validate!}.not_to raise_error
    end

    it "should raise exception with invalid remote_ip" do
      prepare_and_call_callback('100', '1.2.3.4')
      expect{@callback.validate!}.to raise_error(Paynl::Exception)
    end

  end

  def prepare_and_call_callback(state,remote_ip=nil)
    stub_request(:get, "https://token:1234token5678@rest-api.pay.nl/v6/Transaction/info/xml/?transactionId=trx-123").
      to_return(:status => 200, :body => Paynl::Api::Callback::CALLBACK_XML.gsub('{{STATE_RESULT}}',state), :headers => {})
    params = {
      service_id: @service_id,
      transaction_id: @transaction_id }
    @callback = Paynl::Api::Callback.new(params, remote_ip)
  end

end

Paynl::Api::Callback::CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <result>1</result>
    <errorId></errorId>
    <errorMessage></errorMessage>
  </request>
  <connection>
    <trust>10</trust>
    <country>NL</country>
    <city></city>
    <locationLat></locationLat>
    <locationLon></locationLon>
    <browserData></browserData>
    <ipAddress>135.240.153.183</ipAddress>
    <blacklist>0</blacklist>
    <host>135-240-153-183.ip.telfort.nl</host>
    <orderIpAddress>135.240.153.183</orderIpAddress>
    <orderReturnURL>http://example.com</orderReturnURL>
    <merchantCode>M-6028-1100</merchantCode>
    <merchantName>Avayo</merchantName>
  </connection>
  <enduser>
    <accessCode></accessCode>
    <language>NL</language>
    <initials></initials>
    <lastName></lastName>
    <gender></gender>
    <dob></dob>
    <phoneNumber></phoneNumber>
    <emailAddress></emailAddress>
    <bankAccount></bankAccount>
    <iban></iban>
    <bic></bic>
    <sendConfirmMail></sendConfirmMail>
    <confirmMailTemplate></confirmMailTemplate>
    <address>
      <streetName></streetName>
      <streetNumber></streetNumber>
      <zipCode></zipCode>
      <city></city>
      <countryCode>NL</countryCode>
    </address>
    <invoiceAddress>
      <initials></initials>
      <lastName></lastName>
      <gender></gender>
      <streetName></streetName>
      <streetNumber></streetNumber>
      <zipCode></zipCode>
      <city></city>
      <countryCode>NL</countryCode>
    </invoiceAddress>
  </enduser>
  <saleData>
    <invoiceDate></invoiceDate>
    <deliveryDate></deliveryDate>
    <orderData></orderData>
  </saleData>
  <paymentDetails>
    <amount>1299</amount>
    <paidAmount>0</paidAmount>
    <paidBase>0</paidBase>
    <paidCosts>0</paidCosts>
    <paidCostsVat>0</paidCostsVat>
    <paidCurrency>EUR</paidCurrency>
    <paidAttemps>1</paidAttemps>
    <paidDuration>0</paidDuration>
    <description>Pay.nl 5164 0041 7067 6222</description>
    <processTime>3725</processTime>
    <state>{{STATE_RESULT}}</state>
    <stateName>CANCEL</stateName>
    <exchange></exchange>
    <storno>0</storno>
    <paymentOptionId>10</paymentOptionId>
    <paymentOptionSubId>1</paymentOptionSubId>
    <secure>0</secure>
    <secureStatus></secureStatus>
    <identifierName></identifierName>
    <identifierPublic></identifierPublic>
    <identifierHash></identifierHash>
    <serviceId>SL-1234-5678</serviceId>
    <serviceName>www.avayo.nl</serviceName>
    <serviceDescription>Avayo faciliteert de online verkoop van e-tickets voor een brede doelgroep zoals attractieparken, theaters, congressen, workshops, etc.</serviceDescription>
    <created>2015-04-24 22:45:49</created>
    <modified>2015-04-24 23:47:54</modified>
    <paymentMethodId>4</paymentMethodId>
    <paymentMethodName>Transacties </paymentMethodName>
    <paymentMethodDescription>Pay Per Transaction</paymentMethodDescription>
    <paymentProfileName>iDEAL</paymentProfileName>
  </paymentDetails>
  <statsDetails>
    <tool></tool>
    <info></info>
    <object></object>
    <extra1></extra1>
    <extra2></extra2>
    <extra3></extra3>
    <promotorId>0</promotorId>
    <transferData></transferData>
    <paymentSessionId>516400417</paymentSessionId>
  </statsDetails>
  <stornoDetails>
    <stornoId></stornoId>
    <stornoAmount></stornoAmount>
    <bankAccount></bankAccount>
    <iban></iban>
    <bic></bic>
    <city></city>
    <datetime></datetime>
    <reason></reason>
    <emailAddress></emailAddress>
  </stornoDetails>
</data>
EOF

