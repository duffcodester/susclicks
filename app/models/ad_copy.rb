class AdCopy < ActiveRecord::Base
  validates :headline, presence: true

  def self.import_ad_headlines(ad_headlines_file, campaign_name)
    # for i in 0..1
      CSV.foreach(ad_headlines_file.path, headers: true, header_converters: :symbol) do |row|
        AdCopy.create([{ headline: row[:headline1] }, { headline: row[:headline2] }, { headline: row[:headline3] }, { headline: row[:headline4] }, { headline: row[:headline5] }, { headline: row[:headline6] }, { headline: row[:headline7] }, { headline: row[:headline8] }, { headline: row[:headline9] }, { headline: row[:headline10] } ]) do |r|
          r.ad_group = row[:ad_group]
          r.campaign = campaign_name
        end
      end
    # end
  end

  def self.import_ad_body_copy(ad_body_copy_file)
    # numRows = CSV.readlines(ad_body_copy_file.path).size - 1
    CSV.foreach(ad_body_copy_file.path, headers: true, header_converters: :symbol) do |row|

      AdCopy.all.each do |ad|
        if ad.description1.nil?
          ad.attributes = row.to_hash
          ad.save
        else
          AdCopy.create([{ headline: ad[:headline] }]) do |n|
            n.ad_group = ad.ad_group
            n.campaign = ad[:campaign]
            n.description1 = row[:description1]
            n.description2 = row[:description2]
            n.destination_url = row[:destination_url]
            n.display_url = row[:display_url]
          end
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
      csv << [ad_copy.ad_group + one, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + two, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + three, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + four, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign]
      end
    end
  end
end
