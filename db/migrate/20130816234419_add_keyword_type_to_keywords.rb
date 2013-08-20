class AddKeywordTypeToKeywords < ActiveRecord::Migration
  def change
  	add_column :keywords, :keyword_type, :string
  end
end
