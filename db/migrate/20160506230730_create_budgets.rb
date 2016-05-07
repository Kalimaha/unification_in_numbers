class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :state
      t.float :value

      t.timestamps null: false
    end
  end
end
