# 20151212070122
class AddDoneAndUninterestingToStartup < ActiveRecord::Migration
  def change
    add_column :startups, :done,          :boolean, default: false
    add_column :startups, :uninteresting, :boolean, default: false
  end
end
