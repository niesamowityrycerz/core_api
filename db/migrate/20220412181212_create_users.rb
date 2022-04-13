class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.decimal :total_orders_pln, null: false, precision: 11, scale: 2
      t.decimal :total_orders_eur, null: false, default: 0, precision: 11, scale: 2

      t.timestamps
    end
  end
end
