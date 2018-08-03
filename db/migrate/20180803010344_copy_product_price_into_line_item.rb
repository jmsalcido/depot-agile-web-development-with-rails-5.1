class CopyProductPriceIntoLineItem < ActiveRecord::Migration[5.2]
  def up
    LineItem.all.each do |line_item|
      line_item.price = line_item.product.price
      line_item.save!
    end
  end

  def down
    # not required, will just remove prices in past migration.
  end
end
