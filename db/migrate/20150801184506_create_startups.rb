class CreateStartups < ActiveRecord::Migration
  def change
    create_table :startups do |t|
      t.string :public_name
      t.string :description
      t.string :logo

      t.timestamps null: false
    end
  end
end
