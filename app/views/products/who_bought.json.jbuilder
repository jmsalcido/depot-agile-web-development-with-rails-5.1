json.title "Who bought #{@product.title}"
json.updated @latest_order.try(:updated_at)

json.orders @product.orders do |order|
  json.title "Order #{order.id}"
  json.address "Shipped to #{order.address}"

  json.items order.line_items do |line_item|
    json.product line_item.product.title
    json.quantity line_item.quantity
    json.total_price number_to_currency line_item.total_price
  end

  json.total number_to_currency order.line_items.map(&:total_price).sum
  json.pay_type "Paid by #{order.pay_type}"

  json.author do
    json.name order.name
    json.email order.email
  end
end