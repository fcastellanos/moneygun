class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.references :membership, null: false, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
