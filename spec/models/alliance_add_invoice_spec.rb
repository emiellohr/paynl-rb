require 'spec_helper'

describe Paynl::Api::AllianceAddInvoice do

  before :each do
    @service_id  = 'SL-123-123'
    @merchant_id = 'M-0000-0000'
    Paynl::Config.username = '1234'
    Paynl::Config.password = 'token5678'
  end

  describe "add invoice" do

    it "should raise exception Invalid ID merchantId" do
     stub_request(:get, "https://rest-api.pay.nl/v6/Alliance/addInvoice/xml/?amount=1000&description=Dit%20is%20een%20test&invoiceId=Invoice123&invoiceUrl=https://www.avayo.nl/invoice&merchantId=M-0000-0000&serviceId=SL-123-123").
       with(
         headers: {
        'Accept'=>'*/*',
        # 'User-Agent'=>'HTTPClient/1.0 (2.8.3, ruby 2.5.0 (2017-12-25))'
         }).
       to_return(status: 200, body: Paynl::Api::AllianceAddInvoice::ERROR_CALLBACK_XML, headers: {})

      expect {
        Paynl::Api::AllianceAddInvoice.new(
          @service_id,
          @merchant_id,
          'Invoice123',
          1000,
          'Dit is een test',
          { invoiceUrl: 'https://www.avayo.nl/invoice' }
          ).perform
      }.to raise_error(Paynl::Exception, "An error occurred: 404. Invalid ID merchantId")
    end

    it "should return a referenceId on successfull calls" do
       stub_request(:get, "https://rest-api.pay.nl/v6/Alliance/addInvoice/xml/?amount=1000&description=Dit%20is%20een%20test&invoiceId=Invoice123&invoiceUrl=https://www.avayo.nl/invoice&merchantId=M-0000-0000&serviceId=SL-123-123").
         with(
           headers: {
          'Accept'=>'*/*',
          # 'User-Agent'=>'HTTPClient/1.0 (2.8.3, ruby 2.5.0 (2017-12-25))'
           }).
         to_return(status: 200, body: Paynl::Api::AllianceAddInvoice::CALLBACK_XML, headers: {})

      expect(
        Paynl::Api::AllianceAddInvoice.new(
          @service_id,
          @merchant_id,
          'Invoice123',
          1000,
          'Dit is een test',
          { invoiceUrl: 'https://www.avayo.nl/invoice' }
          ).perform
      ).to eql '12345'
    end

  end

end

Paynl::Api::AllianceAddInvoice::ERROR_CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <result>0</result>
    <errorId>404</errorId>
    <errorMessage>Invalid ID merchantId</errorMessage>
  </request>
  <referenceId></referenceId>
</data>
EOF

Paynl::Api::AllianceAddInvoice::CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <request>
    <result>1</result>
    <errorId></errorId>
    <errorMessage></errorMessage>
  </request>
  <referenceId>12345</referenceId>
</data>
EOF

