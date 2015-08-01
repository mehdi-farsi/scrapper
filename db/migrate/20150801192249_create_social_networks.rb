class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :name
      t.string :link
      t.references :startup, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
