class CreateEducationLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :education_levels do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.integer :level, default: 0, null: false

      t.timestamps
    end
  end
end
