Paynl
=====

This gem provides an easy way of using the Pay.nl API for Ruby. It supports only a limited number of operations.

[![Build Status](https://travis-ci.org/emiellohr/paynl-rb.svg?branch=master)](https://travis-ci.org/emiellohr/paynl-rb)

## Documentation
For more background info about parameters and responses, please take a look at:
https://docs.pay.nl/docpanel/api

## Installation

To install Resque, add the gem to your Gemfile:

```ruby
gem 'paynl-rb', '0.4.0', git: "git://github.com/emiellohr/paynl-rb.git"
```

Then run `bundle`. If you're not using Bundler, just `gem install paynl-rb`.


## Initialization

To get started you should initialize the gem by setting your API token.

```ruby
Paynl::Config.initialize('1234token5678')
```

By default the gem will retrieve a list of valid Pay.nl ip's the check callbacks
agains to detect callback forgery. You can disable the behaviour by passing false
as a second parameter.

```ruby
# Disable retrieval of valid IP's from Paynl servers.
Paynl::Config.initialize('1234token5678')
```

Errors on request made to the Pay.nl Api will be reported as:
```ruby
Paynl::Exception
```

## Usage (fixed) payments

### Receive a list of Payment methods
To receive a list of supported payment methods for a service id you can use:

```ruby
payment_methods = Paynl::PaymentOption.list('SL-1234-0000', false)
puts issuers.first.inspect
[#<Paynl::PaymentOption:0x007f926c488e00 @id="10", @name="iDEAL">,...
```
It returns an array with id and name per payment method.

### Receive a list of iDEAL Issuers
This method returns an array of iDEAL issuer id's together with their display name.

```ruby
issuers = Paynl::Issuer.list 'SL-1234-0000'
puts issuers.first.inspect
#<Paynl::Issuer:0x007f8a9424adf8 @id="1", @name="ABN Amro">,...
```

### Start a transaction
The code example shows how to start an iDEAL transaction

```ruby
payment_attributes = {
  service_id:        'SL-1234-0000',  # Your Service id
  amount:            1234,            # Payment amount in cents
  description:       'Purchase 123',  # A description of the transaction
  ip_address:        xxx.xxx.xxx.xxx, # Buyers ip address
  return_url:        xxxx,            # The url where the buyer returns after the payment
  callback_url:      xxxx,            # The url where status updates should be reported
  payment_method_id: '10',            # The payment method to use (iDEAL)
  issuer_id:         '1',             # Issuer id from Paynl::Issuer.list
  test_mode:         '0'              # Run in test_mode ('1' default or not '0')
}

payment = Paynl::Payment.new(payment_attributes)

payment_url = payment.payment_url
@payment.transaction_id
```

After the payment_url method is called, the transaction_id is assigned.
This id can be used at a later stage to request the actual payment status.
So save the transaction_id and redirect the browser to the payment_url.

### Process pay.nl status update

To easily process the status updates from Pay.nl you can use the Callback class.

```ruby
callback = Paynl::Api::Callback.new({
  service_id: 'SL-1234-0000',         # Your Service id
  transaction_id: '123898450X96e34c'  # Retrieved from Payment classs
  }, request.remote_ip)               # If remote_ip is set, it will be compared to the list of ip's of Pay.nl servers.
if callback.valid?
    if callback.success?
      # purchase paid, compare order amout with params[:amount]
      # handle paid
    elsif callback.cancelled?
      # handle cancelled
    elsif callback.pending?
      # handle pending
    elsif callback.expired?
      # handle expired
    elsif callback.failure?
      # handle failure
    else
      fail "Paynl unsupported callback status. Params: #{params.inspect}"
    end
  end
else
  fail "Paynl callback invalid. Params: #{params.inspect}"
end

...
render text: 'TRUE'
```

The callback_url should render "TRUE" if all is okay.

### Deeper level

#### Receive transaction information

```ruby
info = Paynl::Api::TransactionInfo.new(transactionId, {entranceCode: 'entranceCode'} )
result = info.perform
```

#### Transaction status

```ruby
payment_status = Paynl::TransactionStatus.new(params["orderStatusId"])

# checks
payment_status.success?
payment_status.cancelled?
payment_status.expired?
payment_status.failure?
payment_status.pending?
```

## Usage Refund

### Transaction

```ruby
response = Paynl::Api::RefundTransaction.new(
  'SL-1234-0000',     # Service id
  '123898450X96e34c'  # Transaction id - Retrieved from Payment classs
  amount: 1234,       # The amount to be refunded
  description: 'Description').perform
refund_id = response.refundId
```

## Usage Instore payment

### Payment

```ruby
# Start payment transaction
payment = Paynl::Payment.new(payment_attributes)
transaction_id = payment.transaction_id

instore_payment = Paynl::Api::InstorePayment.new(
  'SL-1234-0000',     # Service id
  transaction_id
  terminalId: 'TH-0000-0000')
result = instore_payment.perform
```

## Usage Statistics

### Sessions

```ruby
request = Paynl::Api::StatisticsSessions.new(
  start_date,       # Format .strftime('%Y-%m-%d')
  end_date,         # Format .strftime('%Y-%m-%d')
  filterType: filter_types,
  filterOperator: filter_operators,
  filterValue: filter_values)
result = request.perform
```

## Usage Alliance

### GetMerchant

```ruby
merchant_info = Paynl::Api::AllianceGetMerchant.new(
  merchant_id).perform
```

### AddInvoice

```ruby
paynl_invoice_id = Paynl::Api::AllianceAddInvoice.new(
  'SL-1234-0000',
  merchant_id,
  'invoice id',
  amount_cents,
  "invoice description",
  invoiceUrl: url,
  makeYesterday: 'true').perform
```

## Usage DirectDebit

### DebitAdd

```ruby
response = Paynl::Api::DirectDebitDebitAdd.new(
  'SL-1234-0000',
  amount_cents,
  bankaccountHolder,
  bankaccountNumber,
  { optional arguments.... } ).perform

# respose.result will hold the mandateId for the new order.
respose.result
```

### Info

```ruby
response = Paynl::Api::DirectDebitInfo.new(mandateId, { optional referenceId... }).perform

# respose.mandate will hold the mandate information.
# respose.directDebit will hold the directDebit information.
```



