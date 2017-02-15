class AddMaterialsToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :materials, :string
  end
end
