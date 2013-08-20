class Keyword < ActiveRecord::Base
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |keyword|
				csv << keyword.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file, campaign_name)
		CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			row[:ad_group] << " 1 Exact"
			row << ["keyword_type", "Exact"]
			row << ["campaign_name", campaign_name]
			Keyword.create! row.to_hash
		end
		CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			row[:ad_group] << " 2 Phrase"
			row << ["keyword_type", "Phrase"]
			row << ["campaign_name", "Example Campaign"]
			Keyword.create! row.to_hash
		end
		CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			row[:ad_group] << " 3 ModBroad"
			row << ["keyword_type", "Broad"]
			row << ["campaign_name", "Example Campaign"]
			Keyword.create! row.to_hash
		end
		CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			row[:ad_group] << " 4 Broad"
			row << ["keyword_type", "Broad"]
			row << ["campaign_name", "Example Campaign"]
			Keyword.create! row.to_hash
		end
	end
end