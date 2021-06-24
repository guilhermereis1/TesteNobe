class AddTaxToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :tax, :decimal, default: 0.0, null: false
  end
end
