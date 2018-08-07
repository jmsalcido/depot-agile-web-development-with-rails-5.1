xml.instruct!

xml.who_bought do
  xml.title "Who bought #{@product.title}"
  xml.latest_order @latest_order.try(:updated_at)
  xml.orders do
    @product.orders.each do |order|
      xml.order do
        xml.shipped_to order.address
        xml.items do
          order.line_items.each do |line_item|
            xml.item do
              xml.product line_item.product.title
              xml.quantity line_item.quantity
              xml.total_price number_to_currency line_item.total_price
            end
          end
        end
        xml.total number_to_currency order.line_items.map(&:total_price).sum
        xml.paid_by order.pay_type
        xml.bought_by order.name
        xml.email order.email
      end
    end
  end
end