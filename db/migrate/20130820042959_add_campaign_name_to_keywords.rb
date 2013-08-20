class AddCampaignNameToKeywords < ActiveRecord::Migration
  def change
  	add_column :keywords, :campaign_name, :string
  end
end
