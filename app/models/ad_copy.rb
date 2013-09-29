class AdCopy < ActiveRecord::Base
  def self.import_ad_headlines(ad_headlines_file, campaign_name)
    for i in 0..1
      CSV.foreach(ad_headlines_file.path, headers: true, header_converters: :symbol) do |row|
        row << ["campaign", campaign_name]
        AdCopy.create row.to_hash
      end
    end
  end

  def self.import_ad_body_copy(ad_body_copy_file)
    # numRows = CSV.readlines(ad_body_copy_file.path).size - 1
    CSV.foreach(ad_body_copy_file.path, headers: true, header_converters: :symbol) do |row|
      AdCopy.all.each do |ad|
        if ad.description1?
          AdCopy.create! row.to_hash
        else
          ad.attributes = row.to_hash
          ad.save!
        end
      end
    end
  end

  def self.to_ad_copy_csv
    CSV.generate do |csv|
      csv << ['AdGroup', 'Headline', 'Description1', 'Description2','Display URL', 'Destination URL', 'Campaign']
      one = " 1 Exact"
      two = " 2 Phrase"
      three = " 3 ModBroad"
      four = " 4 Broad"

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + one, ad_copy.headline1, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end
      all.each do |ad_copy|
      csv << [ad_copy.ad_group + one, ad_copy.headline2, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + two, ad_copy.headline1, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end
      all.each do |ad_copy|
      csv << [ad_copy.ad_group + two, ad_copy.headline2, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + three, ad_copy.headline1, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end
      all.each do |ad_copy|
      csv << [ad_copy.ad_group + three, ad_copy.headline2, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + four, ad_copy.headline1, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end
      all.each do |ad_copy|
      csv << [ad_copy.ad_group + four, ad_copy.headline2, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end
    end
  end
end
