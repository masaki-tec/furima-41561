class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string  :name,                    null: false
      t.text    :product_description,     null: false
      t.integer :category_id,             null: false
      t.integer :status_id,               null: false
      t.integer :cover_delivery_cost_id,  null: false
      t.integer :prefecture_id,           null: false
      t.integer :delivery_id,             null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
