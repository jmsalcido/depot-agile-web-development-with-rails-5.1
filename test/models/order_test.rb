require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'valid order' do
    order = Order.new(name: 'foo', address: 'foo addr', email: 'foo@email.com', pay_type: PayType.new)
    assert order.valid?, 'user model test is missing validations'
  end

  test 'invalid order' do
    order = Order.new
    refute order.valid?, 'order should be invalid'
    assert_not_nil order.errors[:name]
    assert_not_nil order.errors[:address]
    assert_not_nil order.errors[:email]
    assert_not_nil order.errors[:pay_type]
  end
end
