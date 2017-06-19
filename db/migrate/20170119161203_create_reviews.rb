class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rate
      t.text :description
      t.references :book, foreign_key: true
      t.boolean :verified, default: false
      t.string :state

      t.timestamps
    end
  end
end
