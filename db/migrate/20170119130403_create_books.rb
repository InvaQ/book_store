class CreateBooks < ActiveRecord::Migration[5.0]

  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :height
      t.integer :weight
      t.integer :depth
      t.integer :publication
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
