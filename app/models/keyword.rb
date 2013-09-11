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
		self.each_row(file) do |row|
			self.one_exact_manipulate(row.dup, campaign_name)
			self.two_phrase_manipulate(row.dup, campaign_name)
			self.three_modbroad_manipulate(row.dup, campaign_name)
		end
	end

	def self.each_row(file, &block)
		CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			block.call(row)
		end
	end

	def self.one_exact_manipulate(row, campaign_name)
		row[:ad_group] << " 1 Exact"
		row["keyword_type"] = "Exact"
		row["campaign_name"] = campaign_name
		Keyword.create! row.to_hash
	end

	def self.two_phrase_manipulate(row, campaign_name)
		row[:ad_group] << " 2 Phrase"
		row << ["keyword_type", "Phrase"]
		row << ["campaign_name", campaign_name]
		Keyword.create! row.to_hash
	end

	def self.three_modbroad_manipulate(row, campaign_name)
		row[:ad_group] << " 3 ModBroad"
		row[:keyword] = row[:keyword].split.map! { |x| "+#{x}" }.join ' '
		row << ["keyword_type", "Broad"]
		row << ["campaign_name", campaign_name]
		Keyword.create! row.to_hash
	end

	def self.four_broad_manipulate(row, campaign_name)
		row[:ad_group] << " 4 Broad"
		row << ["keyword_type", "Broad"]
		row << ["campaign_name", campaign_name]
		Keyword.create! row.to_hash
	end
end