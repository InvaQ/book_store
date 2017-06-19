class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :state
      t.references :user, foreign_key: true
      t.decimal :total_price, precision: 10, scale: 2
      
      t.timestamps
    end
  end
end
