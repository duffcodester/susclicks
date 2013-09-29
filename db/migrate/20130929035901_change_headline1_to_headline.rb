class ChangeHeadline1ToHeadline < ActiveRecord::Migration
  def change
    remove_column :ad_copies, :headline1
    add_column :ad_copies, :headline, :string
  end
end
