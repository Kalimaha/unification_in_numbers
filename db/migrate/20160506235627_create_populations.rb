class CreatePopulations < ActiveRecord::Migration
  def change
    create_table :populations do |t|
      t.string :state
      t.integer :value

      t.timestamps null: false
    end
  end
end
