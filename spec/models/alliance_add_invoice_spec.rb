require 'spec_helper'

describe Paynl::Api::AllianceAddInvoice do


  before :each do
    @token  = '1234token5678'
    @service_id  = 'SL-123-123'
    @merchant_id = 'M-0000-0000'
  end

  describe "add invoice" do

    it "should raise exception Invalid ID merchantId" do
      stub_request(:get, "https://rest-api.pay.nl/v2/Alliance/addInvoice/xml/?amount=1000&description=Dit%20is%20een%20test&invoiceId=Invoice123&invoiceUrl=https://www.avayo.nl/invoice&merchantId=M-0000-0000&serviceId=SL-123-123&token=1234token5678").
        to_return(:status => 200, :body => Paynl::Api::AllianceAddInvoice::ERROR_CALLBACK_XML, :headers => {})

      expect {
        Paynl::Api::AllianceAddInvoice.new(
          token = @token,
          service_id = @service_id,
          merchant_id = @merchant_id,
          invoice_id = 'Invoice123',
          amount = 1000,
          description = 'Dit is een test',
          invoice_url = 'https://www.avayo.nl/invoice'
          ).perform
      }.to raise_error(Paynl::Exception, "An error occurred: 404. Invalid ID merchantId")
    end

    it "should return a referenceId on successfull calls" do
      stub_request(:get, "https://rest-api.pay.nl/v2/Alliance/addInvoice/xml/?amount=1000&description=Dit%20is%20een%20test&invoiceId=Invoice123&invoiceUrl=https://www.avayo.nl/invoice&merchantId=M-0000-0000&serviceId=SL-123-123&token=1234token5678").
        to_return(:status => 200, :body => Paynl::Api::AllianceAddInvoice::CALLBACK_XML, :headers => {})

      expect(
        Paynl::Api::AllianceAddInvoice.new(
          token = @token,
          service_id = @service_id,
          merchant_id = @merchant_id,
          invoice_id = 'Invoice123',
          amount = 1000,
          description = 'Dit is een test',
          invoice_url = 'https://www.avayo.nl/invoice'
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

