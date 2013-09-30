class AddStatusToAdCopies < ActiveRecord::Migration
  def change
    add_column :ad_copies, :status, :string
  end
end
