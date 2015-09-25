require 'spec_helper'

describe Paynl::Api::StatisticsSessions do

  before :each do
    @token  = '1234token5678'
  end

  describe "sessions" do

    it "should raise exception when called with invalid filter field" do
      stub_request(:get, "https://rest-api.pay.nl/v5/Statistics/sessions/xml/?endDate=2015-12-31&filterType%5B%5D=invalid-input&startDate=2015-01-01&token=1234token5678").
        to_return(:status => 200, :body => Paynl::Api::StatisticsSessions::ERROR_CALLBACK_XML, :headers => {})

      expect {
        Paynl::Api::StatisticsSessions.new(
          token = @token,
          start_date = '2015-01-01',
          end_date = '2015-12-31',
          filter_types = [['invalid-input']]).perform
      }.to raise_error(Paynl::Exception, "An error occurred: N/A. Parameter 'filterType' is invalid: Invalid filter field")
    end

    it "should return statistics on successfull calls" do
      stub_request(:get, "https://rest-api.pay.nl/v5/Statistics/sessions/xml/?endDate=2015-12-31&filterOperator%5B%5D=eq&filterType%5B%5D=payment_session_id&filterValue%5B%5D=550303978&startDate=2015-01-01&token=1234token5678").
        to_return(:status => 200, :body => Paynl::Api::StatisticsSessions::CALLBACK_XML, :headers => {})

      result = Paynl::Api::StatisticsSessions.new(
        token = @token,
        start_date = '2015-01-01',
        end_date = '2015-12-31',
        filter_types = ['payment_session_id'],
        filter_operators = ['eq'],
        filter_values = ['550303978'],
        ).perform

      expect(result.item.size).to eql 2
      expect(result.item[0].payment_profile_id).to eql '1645'
      expect(result.item[0].stats_id).to eql '239714899'
      expect(result.item[0].enduser_payment).to eql '90.000'
      expect(result.item[0].cst).to eql '8.7'
      expect(result.item[1].payment_profile_id).to eql '10'
      expect(result.item[1].stats_id).to eql '239715268'
      expect(result.item[1].enduser_payment).to eql '10.000'
      expect(result.item[1].cst).to eql '0.2'
    end

  end
end


Paynl::Api::StatisticsSessions::ERROR_CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <status>FALSE</status>
  <message>Parameter 'filterType' is invalid: Invalid filter field</message>
</data>
EOF

Paynl::Api::StatisticsSessions::CALLBACK_XML=<<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<data>
  <login>1</login>
  <arrStatsData>
    <item>
      <id>240780403</id>
      <stats_id>239714899</stats_id>
      <payment_session_id>550303978</payment_session_id>
      <country_id>12</country_id>
      <parent_id>240780793</parent_id>
      <tariff_group_type_id>18718</tariff_group_type_id>
      <payment_profile_id>1645</payment_profile_id>
      <stop_dateshort>2015-07-30</stop_dateshort>
      <payment_method_id>4</payment_method_id>
      <company_id>20662</company_id>
      <program_id>18367</program_id>
      <stopstamp>1438261208</stopstamp>
      <startstamp>1438261208</startstamp>
      <enduser_payment>90.000</enduser_payment>
      <extra1></extra1>
      <domain_id>0</domain_id>
      <ip_address>94.214.16.80</ip_address>
      <is_transaction>1</is_transaction>
      <tariff>0.000</tariff>
      <made_by_tintel>1</made_by_tintel>
      <customer_id>6280504400033880852</customer_id>
      <customer_id_presentation>1</customer_id_presentation>
      <starttime>2015-07-30 15:00:08</starttime>
      <start_timeshort>15:00:08</start_timeshort>
      <stoptime>2015-07-30 15:00:08</stoptime>
      <stop_timeshort>15:00:08</stop_timeshort>
      <website_id>1</website_id>
      <week>Week: 201531</week>
      <month>2015-07</month>
      <hour>15</hour>
      <year>2015</year>
      <real_website_id>32113</real_website_id>
      <enduser_id>0</enduser_id>
      <transactions_distinct>0</transactions_distinct>
      <amount>90.00</amount>
      <duration>0.00</duration>
      <transactions>1</transactions>
      <explain_payment>
        <item>
          <payout_ex_vat>-0.15</payout_ex_vat>
          <payout>-0.15</payout>
          <amount>1</amount>
          <tariff>-0.1500</tariff>
          <tariff_id>140185</tariff_id>
          <account_type>company</account_type>
          <account_id>18007</account_id>
          <tariff_group_id>1723</tariff_group_id>
          <tariff_unit_id>3</tariff_unit_id>
          <vat_included>0</vat_included>
          <bank_source>0</bank_source>
        </item>
        <item>
          <payout_ex_vat>-8.55</payout_ex_vat>
          <payout>-8.55</payout>
          <amount>90.00</amount>
          <tariff>-0.095</tariff>
          <tariff_id>140188</tariff_id>
          <account_type>company</account_type>
          <account_id>18007</account_id>
          <tariff_group_id>1723</tariff_group_id>
          <tariff_unit_id>12</tariff_unit_id>
          <vat_included>0</vat_included>
          <bank_source>0</bank_source>
        </item>
      </explain_payment>
      <payment>-8.7</payment>
      <total_payment>-8.7</total_payment>
      <country_code>NL</country_code>
      <country_name>Netherlands</country_name>
      <company_name>Perfect Marketing &amp; Sales B.V.</company_name>
      <real_website_name>Funforkidskaart</real_website_name>
      <website_name>Funforkidskaart</website_name>
      <payment_method_name>Transacties </payment_method_name>
      <payment_profile_name>Yourgift.nl</payment_profile_name>
      <root_id>240780403</root_id>
      <service> &amp;euro;</service>
      <sub>
        <item>
          <switches>
            <item>
              <id>240780403</id>
              <stats_id>239714899</stats_id>
              <payment_session_id>550303978</payment_session_id>
              <country_id>12</country_id>
              <parent_id>240780793</parent_id>
              <tariff_group_type_id>18718</tariff_group_type_id>
              <payment_profile_id>1645</payment_profile_id>
              <stop_dateshort>2015-07-30</stop_dateshort>
              <payment_method_id>4</payment_method_id>
              <company_id>20662</company_id>
              <program_id>18367</program_id>
              <stopstamp>1438261208</stopstamp>
              <startstamp>1438261208</startstamp>
              <enduser_payment>90.000</enduser_payment>
              <extra1></extra1>
              <domain_id>0</domain_id>
              <ip_address>94.214.16.80</ip_address>
              <is_transaction>1</is_transaction>
              <tariff>0.000</tariff>
              <made_by_tintel>1</made_by_tintel>
              <customer_id>6280504400033880852</customer_id>
              <customer_id_presentation>1</customer_id_presentation>
              <starttime>2015-07-30 15:00:08</starttime>
              <start_timeshort>15:00:08</start_timeshort>
              <stoptime>2015-07-30 15:00:08</stoptime>
              <stop_timeshort>15:00:08</stop_timeshort>
              <website_id>1</website_id>
              <week>Week: 201531</week>
              <month>2015-07</month>
              <hour>15</hour>
              <year>2015</year>
              <real_website_id>32113</real_website_id>
              <enduser_id>0</enduser_id>
              <transactions_distinct>0</transactions_distinct>
              <amount>90.00</amount>
              <duration>0.00</duration>
              <transactions>1</transactions>
              <explain_payment>
                <item>
                  <payout_ex_vat>-0.15</payout_ex_vat>
                  <payout>-0.15</payout>
                  <amount>1</amount>
                  <tariff>-0.1500</tariff>
                  <tariff_id>140185</tariff_id>
                  <account_type>company</account_type>
                  <account_id>18007</account_id>
                  <tariff_group_id>1723</tariff_group_id>
                  <tariff_unit_id>3</tariff_unit_id>
                  <vat_included>0</vat_included>
                  <bank_source>0</bank_source>
                </item>
                <item>
                  <payout_ex_vat>-8.55</payout_ex_vat>
                  <payout>-8.55</payout>
                  <amount>90.00</amount>
                  <tariff>-0.095</tariff>
                  <tariff_id>140188</tariff_id>
                  <account_type>company</account_type>
                  <account_id>18007</account_id>
                  <tariff_group_id>1723</tariff_group_id>
                  <tariff_unit_id>12</tariff_unit_id>
                  <vat_included>0</vat_included>
                  <bank_source>0</bank_source>
                </item>
              </explain_payment>
              <payment>-8.7</payment>
              <total_payment>-8.7</total_payment>
              <country_code>NL</country_code>
              <country_name>Netherlands</country_name>
              <company_name>Perfect Marketing &amp; Sales B.V.</company_name>
              <real_website_name>Funforkidskaart</real_website_name>
              <website_name>Funforkidskaart</website_name>
              <payment_method_name>Transacties </payment_method_name>
              <payment_profile_name>Yourgift.nl</payment_profile_name>
              <root_id>240780403</root_id>
              <service> &amp;euro;</service>
              <cst>8.7</cst>
              <org>90</org>
              <org_ext>0</org_ext>
              <org_vat>0</org_vat>
              <org_tot>90</org_tot>
              <pay>-8.7</pay>
            </item>
          </switches>
        </item>
      </sub>
      <cst>8.7</cst>
      <org>90</org>
      <org_ext>0</org_ext>
      <org_vat>0</org_vat>
      <org_tot>90</org_tot>
      <pay>-8.7</pay>
    </item>
    <item>
      <id>240780790</id>
      <stats_id>239715268</stats_id>
      <payment_session_id>550303978</payment_session_id>
      <country_id>12</country_id>
      <parent_id>240780793</parent_id>
      <tariff_group_type_id>18718</tariff_group_type_id>
      <payment_profile_id>10</payment_profile_id>
      <stop_dateshort>2015-07-30</stop_dateshort>
      <payment_method_id>4</payment_method_id>
      <company_id>20662</company_id>
      <program_id>18367</program_id>
      <stopstamp>1438261378</stopstamp>
      <startstamp>1438261378</startstamp>
      <enduser_payment>10.000</enduser_payment>
      <extra1></extra1>
      <domain_id>0</domain_id>
      <ip_address>94.214.16.80</ip_address>
      <is_transaction>1</is_transaction>
      <tariff>0.000</tariff>
      <made_by_tintel>1</made_by_tintel>
      <customer_id>6280504400033880852</customer_id>
      <customer_id_presentation>1</customer_id_presentation>
      <starttime>2015-07-30 15:02:58</starttime>
      <start_timeshort>15:02:58</start_timeshort>
      <stoptime>2015-07-30 15:02:58</stoptime>
      <stop_timeshort>15:02:58</stop_timeshort>
      <website_id>1</website_id>
      <week>Week: 201531</week>
      <month>2015-07</month>
      <hour>15</hour>
      <year>2015</year>
      <real_website_id>32113</real_website_id>
      <enduser_id>0</enduser_id>
      <transactions_distinct>0</transactions_distinct>
      <amount>10.00</amount>
      <duration>0.00</duration>
      <transactions>1</transactions>
      <explain_payment>
        <item>
          <payout_ex_vat>-0.2</payout_ex_vat>
          <payout>-0.2</payout>
          <amount>1</amount>
          <tariff>-0.2000</tariff>
          <tariff_id>138841</tariff_id>
          <account_type>company</account_type>
          <account_id>18007</account_id>
          <tariff_group_id>1723</tariff_group_id>
          <tariff_unit_id>3</tariff_unit_id>
          <vat_included>0</vat_included>
          <bank_source>0</bank_source>
        </item>
      </explain_payment>
      <payment>-0.2</payment>
      <total_payment>-0.2</total_payment>
      <country_code>NL</country_code>
      <country_name>Netherlands</country_name>
      <company_name>Perfect Marketing &amp; Sales B.V.</company_name>
      <real_website_name>Funforkidskaart</real_website_name>
      <website_name>Funforkidskaart</website_name>
      <payment_method_name>Transacties </payment_method_name>
      <payment_profile_name>iDEAL</payment_profile_name>
      <root_id>240780790</root_id>
      <service> &amp;euro;</service>
      <sub>
        <item>
          <switches>
            <item>
              <id>240780790</id>
              <stats_id>239715268</stats_id>
              <payment_session_id>550303978</payment_session_id>
              <country_id>12</country_id>
              <parent_id>240780793</parent_id>
              <tariff_group_type_id>18718</tariff_group_type_id>
              <payment_profile_id>10</payment_profile_id>
              <stop_dateshort>2015-07-30</stop_dateshort>
              <payment_method_id>4</payment_method_id>
              <company_id>20662</company_id>
              <program_id>18367</program_id>
              <stopstamp>1438261378</stopstamp>
              <startstamp>1438261378</startstamp>
              <enduser_payment>10.000</enduser_payment>
              <extra1></extra1>
              <domain_id>0</domain_id>
              <ip_address>94.214.16.80</ip_address>
              <is_transaction>1</is_transaction>
              <tariff>0.000</tariff>
              <made_by_tintel>1</made_by_tintel>
              <customer_id>6280504400033880852</customer_id>
              <customer_id_presentation>1</customer_id_presentation>
              <starttime>2015-07-30 15:02:58</starttime>
              <start_timeshort>15:02:58</start_timeshort>
              <stoptime>2015-07-30 15:02:58</stoptime>
              <stop_timeshort>15:02:58</stop_timeshort>
              <website_id>1</website_id>
              <week>Week: 201531</week>
              <month>2015-07</month>
              <hour>15</hour>
              <year>2015</year>
              <real_website_id>32113</real_website_id>
              <enduser_id>0</enduser_id>
              <transactions_distinct>0</transactions_distinct>
              <amount>10.00</amount>
              <duration>0.00</duration>
              <transactions>1</transactions>
              <explain_payment>
                <item>
                  <payout_ex_vat>-0.2</payout_ex_vat>
                  <payout>-0.2</payout>
                  <amount>1</amount>
                  <tariff>-0.2000</tariff>
                  <tariff_id>138841</tariff_id>
                  <account_type>company</account_type>
                  <account_id>18007</account_id>
                  <tariff_group_id>1723</tariff_group_id>
                  <tariff_unit_id>3</tariff_unit_id>
                  <vat_included>0</vat_included>
                  <bank_source>0</bank_source>
                </item>
              </explain_payment>
              <payment>-0.2</payment>
              <total_payment>-0.2</total_payment>
              <country_code>NL</country_code>
              <country_name>Netherlands</country_name>
              <company_name>Perfect Marketing &amp; Sales B.V.</company_name>
              <real_website_name>Funforkidskaart</real_website_name>
              <website_name>Funforkidskaart</website_name>
              <payment_method_name>Transacties </payment_method_name>
              <payment_profile_name>iDEAL</payment_profile_name>
              <root_id>240780790</root_id>
              <service> &amp;euro;</service>
              <cst>0.2</cst>
              <org>10</org>
              <org_ext>0</org_ext>
              <org_vat>0</org_vat>
              <org_tot>10</org_tot>
              <pay>-0.2</pay>
            </item>
          </switches>
        </item>
      </sub>
      <cst>0.2</cst>
      <org>10</org>
      <org_ext>0</org_ext>
      <org_vat>0</org_vat>
      <org_tot>10</org_tot>
      <pay>-0.2</pay>
    </item>
  </arrStatsData>
  <totalRows>2</totalRows>
  <lastPage>1</lastPage>
  <page>1</page>
  <currency_symbol>&amp;euro;</currency_symbol>
</data>
EOF
