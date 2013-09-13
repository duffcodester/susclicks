class Keyword < ActiveRecord::Base
	def self.to_csv
		CSV.generate do |csv|
			csv << ['ad_group', 'keyword_type', 'campaign_name']
			all.each do |keyword|
				csv << [keyword.ad_group, keyword.keyword_type, keyword.campaign_name]
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
				row << ["campaign_name", campaign_name]
				Keyword.create! row.to_hash
			end
			CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
				row[:ad_group] << " 3 ModBroad"
				row[:keyword] = row[:keyword].split.map! { |x| "+#{x}" }.join ' '
				row << ["keyword_type", "Broad"]
				row << ["campaign_name", campaign_name]
				Keyword.create! row.to_hash
			end
			CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			  row[:ad_group] << " 4 Broad"
			  row << ["keyword_type", "Broad"]
			  row << ["campaign_name", campaign_name]
			  Keyword.create! row.to_hash
			end
		# self.each_row(file) do |row|
		# 	self.one_exact_manipulate(row, campaign_name)
		# 	debugger
		# 	self.two_phrase_manipulate(row, campaign_name)
		# 	self.three_modbroad_manipulate(row, campaign_name)
		# 	self.four_broad_manipulate(row, campaign_name)
		# end
	end

	# def self.each_row(file, &block)
	# 	CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
	# 		block.call(row)
	# 	end
	# end

	# def self.one_exact_manipulate(row, campaign_name)
	# 	row = row.dup
	# 	row[:ad_group] << " 1 Exact"
	# 	row["keyword_type"] = "Exact"
	# 	row["campaign_name"] = campaign_name
	# 	Keyword.create! row.to_hash
	# end

	# def self.two_phrase_manipulate(row, campaign_name)
	# 	debugger
	# 	row = row.dup
	# 	row[:ad_group] << " 2 Phrase"
	# 	row << ["keyword_type", "Phrase"]
	# 	row << ["campaign_name", campaign_name]
	# 	Keyword.create! row.to_hash
	# end

	# def self.three_modbroad_manipulate(row, campaign_name)
	# 	row = row.dup
	# 	row[:ad_group] << " 3 ModBroad"
	# 	row[:keyword] = row[:keyword].split.map! { |x| "+#{x}" }.join ' '
	# 	row << ["keyword_type", "Broad"]
	# 	row << ["campaign_name", campaign_name]
	# 	Keyword.create! row.to_hash
	# end

	# def self.four_broad_manipulate(row, campaign_name)
	# 	row = row.dup
	# 	row[:ad_group] << " 4 Broad"
	# 	row << ["keyword_type", "Broad"]
	# 	row << ["campaign_name", campaign_name]
	# 	Keyword.create! row.to_hash
	# end
end