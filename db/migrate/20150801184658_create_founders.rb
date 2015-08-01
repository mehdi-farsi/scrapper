class CreateFounders < ActiveRecord::Migration
  def change
    create_table :founders do |t|
      t.string :name
      t.string :job_title
      t.string :picture
      t.references :startup, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
