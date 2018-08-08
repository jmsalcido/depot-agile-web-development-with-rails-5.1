class AddPayTypes < ActiveRecord::Migration[5.2]
  def up
    PayType.create!(name: 'Check')
    PayType.create!(name: 'Credit Card')
    PayType.create!(name: 'Purchase Order')
  end

  def down
    PayType.delete_all
  end
end
