Paynl
=====

This gem provides an easy way of using the Pay.nl API for Ruby. It supports only a limited number of operations.

[![Build Status](https://travis-ci.org/emiellohr/paynl-rb.svg?branch=master)](https://travis-ci.org/emiellohr/paynl-rb)

## Installation

To install Resque, add the gem to your Gemfile:

```ruby
gem 'paynl-rb', '0.4.0', git: "git://github.com/emiellohr/paynl-rb.git"
```

Then run `bundle`. If you're not using Bundler, just `gem install paynl-rb`.


## Initialization

To get started you should initialize the gem by setting your API token. 

```ruby
Paynl::Config.apiToken = '1234token5678'
```

## Usage

### Receive a list of iDEAL Issuers
This method returns an array of iDEAL issuer id's together with their display name.

```ruby
issuers = Paynl::Issuer.list 'SL-1234-0000'
puts issuers.first.inspect
#<Paynl::Issuer:0x007f8a9424adf8 @id="1", @name="ABN Amro">
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

### Recieve transaction information


  info = Paynl::Api::TransactionInfoRequest.new(payment_attributes)
  result = info.perform


