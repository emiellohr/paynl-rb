
  require 'paynl'

  payment_attributes = {
    token: 'xxxxxxxxxxxxxxxxx',
    service_id: 'SL-xxxx-xxxx',
    payment_method_id: 2}

  result = Paynl::Api::TransactionGetServiceRequest.new(payment_attributes).perform


  payment_attributes = {
    token: 'xxxxxxxxxxxxxxxxx',
    service_id: 'SL-xxxx-xxxx',
    amount: 1299,
    description: 'description...'
    ip_address: '0.0.0.0',
    return_url: 'http://example.com',
    callback_url: 'http://example.com',
    payment_method_id: 10,
    issuer_id: 1
  }

  payment = Paynl::Payment.new(payment_attributes)

  redirect_url   = payment.payment_url
  transaction_id = payment.transaction_id


  payment_attributes = {
    token: 'xxxxxxxxxxxxxxxxx',
    service_id: 'SL-xxxx-xxxx',
    transaction_id: "516400417Xf6435e"}

  info = Paynl::Api::TransactionInfoRequest.new(payment_attributes)
  result = info.perform


