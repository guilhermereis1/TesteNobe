class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :name, :null => false
      t.integer :kind, :null => false
      t.decimal :value, :null => false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
