class CreateAcademicPeriods < ActiveRecord::Migration[8.0]
  def change
    create_table :academic_periods do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.date :start_date
      t.date :end_date
      t.boolean :current, default: false

      t.timestamps
    end
  end
end
