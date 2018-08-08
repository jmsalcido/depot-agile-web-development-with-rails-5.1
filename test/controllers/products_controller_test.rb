require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The great book #{rand(1000)}"
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @title } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test 'should show products within app' do
    get products_url
    assert_response :success
    assert_select 'main.products', minimum: 1
    assert_select 'main.products table', minimum: 1
  end

  test 'can\'t delete product in cart' do
    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    end

    assert_response :redirect
    assert_redirected_to products_url
    assert_equal 'Line Items present', flash[:notice]
  end

  test 'generate XML correctly' do
    get who_bought_product_url(products(:ruby).id, format: :xml)
    assert_response :success

    assert_select 'who_bought' do
      assert_select 'title', "Who bought #{products(:ruby).title}"
      assert_select 'latest_order', 1
      assert_select 'orders' do
        assert_select 'order' do |elements|
          elements.each do |element|
            assert_select element, 'shipped_to', 1
            assert_select element, 'items' do
              assert_select 'item' do |item|
                assert_select 'item'
              end
            end
            assert_select element, 'total', 1
            assert_select element, 'paid_by', 1
            assert_select element, 'bought_by', 1
            assert_select element, 'email', 1
          end
        end
      end
    end
  end
end
