class AddPriceToLineItem < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :price, :integer
  end
end
