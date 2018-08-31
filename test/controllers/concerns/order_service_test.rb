require 'test_helper'

class OrderServiceTest < ActiveSupport::TestCase
  test 'charge! passess with no problem' do
    mock = mock('payment_processor')
    mock.expects(:make_payment).with(order_id: 1, payment_method: :check, payment_details: {routing: nil, account: nil})
        .returns(OpenStruct.new(succeeded?: true))

    service = OrderService.new(mock)
    order = Order.new(id: 1, pay_type: PayType.new(name: 'Check'))

    service.charge!(order, {})
  end

  test 'charge! fails with error' do
    mock = mock('payment_processor')
    mock.expects(:make_payment)
        .with(order_id: 1, payment_method: :check, payment_details: {routing: nil, account: nil})
        .returns(OpenStruct.new(succeeded?: false, message: 'foo error'))

    service = OrderService.new(mock)
    order = Order.new(id: 1, pay_type: PayType.new(name: 'Check'))

    exception = assert_raises RuntimeError do
      service.charge!(order, {})
    end

    assert_equal('foo error', exception.message)
  end
end
