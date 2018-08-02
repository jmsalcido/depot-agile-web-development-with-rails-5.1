require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get store_index_url
    assert_equal session[:visit_counter], 1
    assert_response :success
    assert_select 'nav.side_nav a', minimum: 4
    assert_select 'main ul.catalog li', 3
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test 'visit_counter should increment in 1' do
    get store_index_url
    assert_equal session[:visit_counter], 1

    get store_index_url
    assert_equal session[:visit_counter], 2

    get store_index_url
    assert_equal session[:visit_counter], 3
  end

  test 'visit_counter should not be shown if not greater than 5' do
    get store_index_url
    assert_equal session[:visit_counter], 1

    assert_response :success
    assert_select '#visit_counter', minimum: 0

    get store_index_url
    assert_equal session[:visit_counter], 2

    assert_response :success
    assert_select '#visit_counter', minimum: 0

    get store_index_url
    get store_index_url
    get store_index_url
    get store_index_url
    assert_select '#visit_counter', minimum: 1
    
  end
end
