class MigratePayTypesInOrders < ActiveRecord::Migration[5.2]
  def up
    Order.all.each do |order|
      order.pay_type = PayType.find_by_name order.pay_type_enum
      order.save!
    end
  end

  def down
    Order.all.each do |order|
      order.pay_type_enum = Order.pay_type_enums[pay_type.name]
      order.save!
    end
  end
end
