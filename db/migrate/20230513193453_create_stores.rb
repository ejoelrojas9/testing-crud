class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :user
      t.string :article
      t.string :state
      t.integer :in_warehouse
      t.integer :on_counter
      t.decimal :price

      t.timestamps
    end
  end
end
