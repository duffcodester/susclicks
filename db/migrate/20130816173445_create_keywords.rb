class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
    	t.string :ad_group
    	t.string :keyword
    end
  end
end
