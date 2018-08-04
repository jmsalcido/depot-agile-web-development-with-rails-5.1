require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_equal session[:visit_counter], 1 # redirected to store index now.
    assert_select 'h2', 'Your Cart'
    assert_select 'td', products(:ruby).title
  end

  test 'should update the quantity of line_items' do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_select 'h2', 'Your Cart'
    assert_select 'td.quantity', '1'
    assert_select 'td.price', '$49.00'
    assert_select 'tfoot td.price', '$49.00'

    assert_no_changes('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_select 'h2', 'Your Cart'
    assert_select 'td.quantity', '2'
    assert_select 'td.price', '$98.00'
    assert_select 'tfoot td.price', '$98.00'
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to store_index_url
  end

  test 'should reduce quantity by 1 in line_item when there is greater than 1' do
    line_item = line_items(:two)

    assert_equal LineItem.find(line_item.id).quantity, 2

    assert_no_changes('LineItem.count') do
      delete line_item_url(line_item)
    end

    assert_redirected_to store_index_url

    assert_equal LineItem.find(line_item.id).quantity, 1
  end
end
