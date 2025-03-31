class CreateSchoolGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :school_groups do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :academic_period, null: false, foreign_key: true
      t.references :education_level, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.integer :group_type, null: false, default: 0
      t.integer :grade, null: false, default: 1

      t.timestamps

    end
    
    add_index :school_groups, [ :organization_id, :academic_period_id, :education_level_id, :group_type, :grade ], unique: true
  end
end
