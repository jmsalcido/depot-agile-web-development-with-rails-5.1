class RemovePayTypeEnumFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :pay_type_enum
  end
end
