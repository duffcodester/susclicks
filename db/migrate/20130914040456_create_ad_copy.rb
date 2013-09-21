class CreateAdCopy < ActiveRecord::Migration
  def change
    create_table :ad_copies do |t|
      t.string :ad_group
      t.string :headline
      t.string :description1
      t.string :description2
      t.string :display_url
      t.string :destination_url
      t.string :campaign
    end
  end
end
