require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test 'check form' do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Jose Salcido'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'js@otfusion.org'

    assert_no_selector '#order_routing_number'
    assert_no_selector '#order_account_number'

    select 'Check', from: 'pay_type'

    assert_selector '#order_routing_number'
    assert_selector '#order_account_number'

    fill_in 'Routing #', with: '123456'
    fill_in 'Account #', with: '987654'

    perform_enqueued_jobs do
      click_button 'Place Order'
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal 'Jose Salcido', order.name
    assert_equal '123 Main Street', order.address
    assert_equal 'js@otfusion.org', order.email
    assert_equal 'Check', order.pay_type.name
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last

    assert_equal ['js@otfusion.org'], mail.to
    assert_equal 'from@example.com', mail[:from].value
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end

  test 'credit card form' do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Jose Salcido'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'js@otfusion.org'

    assert_no_selector '#order_credit_card_number'
    assert_no_selector '#order_expiration_date'

    select 'Credit Card', from: 'pay_type'

    assert_selector '#order_credit_card_number'
    assert_selector '#order_expiration_date'

  end

  test 'purchase order form' do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Jose Salcido'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'js@otfusion.org'

    assert_no_selector '#order_po_number'

    select 'Purchase Order', from: 'pay_type'

    assert_selector '#order_po_number'

  end

  test 'default form' do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Jose Salcido'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'js@otfusion.org'

    assert_no_selector '#order_po_number'
    assert_no_selector '#order_routing_number'
    assert_no_selector '#order_account_number'
    assert_no_selector '#order_credit_card_number'
    assert_no_selector '#order_expiration_date'

  end
end
