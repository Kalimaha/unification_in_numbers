class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.string :state
      t.float :taxes_per_person
      t.float :taxes_total

      t.timestamps null: false
    end
  end
end
