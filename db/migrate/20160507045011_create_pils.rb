class CreatePils < ActiveRecord::Migration
  def change
    create_table :pils do |t|
      t.string :state
      t.string :region
      t.integer :year
      t.float :pil_per_person

      t.timestamps null: false
    end
  end
end
