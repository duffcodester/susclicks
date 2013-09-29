class RemoveHeadline2FromAdCopies < ActiveRecord::Migration
  def change
    remove_column :ad_copies, :headline2
  end
end
