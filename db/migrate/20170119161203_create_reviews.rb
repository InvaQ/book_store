class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :first_name
      t.string :last_name
      t.string :avatar_url, default: "https://goo.gl/Q5p7FL"
      t.integer :rate
      t.text :description
      t.boolean :verified

      t.timestamps
    end
  end
end
