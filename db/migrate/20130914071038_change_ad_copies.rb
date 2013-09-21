class ChangeAdCopies < ActiveRecord::Migration
  def change
    remove_column :ad_copies, :headline
    add_column :ad_copies, :headline1, :string
    add_column :ad_copies, :headline2, :string
  end
end
