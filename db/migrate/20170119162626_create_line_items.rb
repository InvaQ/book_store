class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.references :book, foreign_key: true
      t.belongs_to :cart, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
