class CreateBeverages < ActiveRecord::Migration[6.1]
  def change
    create_table :beverages do |t|
      t.string :name
      t.integer :credits
      t.references :alcohol
      t.references :mixer
      t.references :tab
    end
  end
end
