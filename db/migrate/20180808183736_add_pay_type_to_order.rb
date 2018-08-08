class AddPayTypeToOrder < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :pay_type, :pay_type_enum
    add_reference :orders, :pay_type, foreign_key: true
  end
end
