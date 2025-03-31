class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.references :membership, null: false, foreign_key: true
      t.string :id_number, null: false

      t.timestamps
    end
  end
end
