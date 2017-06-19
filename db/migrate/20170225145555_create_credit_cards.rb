class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.references :order, foreign_key: true
      t.string :number
      t.string :name
      t.string :cvv 
      t.integer :expiry_month
      t.integer :expiry_year
      
      t.timestamps
    end
  end
end
