# This migration comes from exchange_rates (originally 20220413101419)
class CreateExchangeRatesAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_rates_accounts do |t|
      t.text :description
      t.decimal :total_orders_pln, precision: 11, scale: 2
      t.decimal :total_orders_eur, precision: 11, scale: 2

      t.timestamps
    end
  end
end