require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase

  test 'highlight cart item' do
    visit store_index_url

    assert_no_selector '#cart>article'
    assert_no_selector '.line-item'

    first('.catalog li').click_on 'Add to Cart'

    # add the article element into the page
    assert_selector '#cart>article'
    assert_selector '.line-item', count: 1
    assert_selector '.line-item-highlight', count: 1 # should be highlighted only 1 element

  end

end
