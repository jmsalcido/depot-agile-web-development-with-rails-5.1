require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(image_url)
    Product.new(title: "My Book Title #{rand(1000)}",
                description: 'yyy',
                price: 1,
                image_url: image_url)
  end

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = new_product("zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test 'image_url scenarios' do
    ok = %w[fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.com/s/f/gg.gif]
    bad = %w[fred.doc fred.gif/more not.gif.gg]

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} shouldn't be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} should be invalid"
    end
  end

  test 'product title is unique' do
    product = Product.new(title: products(:ruby).title,
                          description: 'yyy',
                          price: 1,
                          image_url: 'any.jpg')
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test 'product title length' do
    product = Product.new
    product.title = 'Less'

    assert product.invalid?
    assert_equal ["'Less' size is not the minimum of: 5"], product.errors[:title]
  end
end
