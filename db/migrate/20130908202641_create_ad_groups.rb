class CreateAdGroups < ActiveRecord::Migration
  def change
    create_table :ad_groups do |t|
      t.string :ad_group
      t.string :max_cpc
      t.string :campaign_name
    end
  end
end
