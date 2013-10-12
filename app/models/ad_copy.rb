class AdCopy < ActiveRecord::Base
  validates :ad_group, presence: true
  validates :headline, presence: true
  validates :campaign, presence: true


  def self.validate_ad_headlines_file(file)
    ad_headlines_file_contents = CSV.read(file.path)           #returns array of arrays for all of file contents
    headlines_header_row = ad_headlines_file_contents.first #returns just the header row
    puts 'Headlines Header Row = ' + headlines_header_row.to_s
    test_ad_headlines_header = ['Ad Group']
    number_of_headlines = headlines_header_row.size - 1
    count = 1
    while count <= number_of_headlines # check for headline1, headline2, ... headers
      test_ad_headlines_header << 'Headline' + count.to_s
      count += 1
    end

    puts 'Test Headlines Header Row = ' + test_ad_headlines_header.to_s 
    if test_ad_headlines_header == headlines_header_row
      $valid_ad_headlines_file = true
    else
      $valid_ad_headlines_file = false
    end
    puts 'Test Result is ' + $valid_ad_headlines_file.to_s
  end

  def self.validate_ad_body_copy_file(file)
    ad_body_copy_file_contents = CSV.read(file.path)           #returns array of arrays for all of file contents
    ad_body_copy_header_row = ad_body_copy_file_contents.first              #returns just the header row
    puts 'Ad Body Copy Header Row = ' + ad_body_copy_header_row.to_s             

    test_ad_body_copy_header = ['Description1', 'Description2', 'Display URL', 'Destination URL', 'Status'] #Defines the correct header row to test against
    puts 'Test Ad Body Copy Header Row = ' + test_ad_body_copy_header.to_s 

    if test_ad_body_copy_header == ad_body_copy_header_row
      $valid_ad_body_copy_file = true
    else
      $valid_ad_body_copy_file = false
    end
    puts 'Test Result is ' + $valid_ad_body_copy_file.to_s

  end

  def self.import_ad_headlines(ad_headlines_file, campaign_name)
    CSV.foreach(ad_headlines_file.path, headers: true, header_converters: :symbol) do |row|
      AdCopy.create([{ headline: row[:headline1] }, { headline: row[:headline2] }, { headline: row[:headline3] }, { headline: row[:headline4] }, { headline: row[:headline5] }, { headline: row[:headline6] }, { headline: row[:headline7] }, { headline: row[:headline8] }, { headline: row[:headline9] }, { headline: row[:headline10] } ]) do |r|
        r.ad_group = row[:ad_group]
        r.campaign = campaign_name
      end
    end
  end

  def self.import_ad_body_copy(ad_body_copy_file)
    @original_ad_copies = AdCopy.all
    CSV.foreach(ad_body_copy_file.path, headers: true, header_converters: :symbol) do |row|
      @original_ad_copies.each do |ad|
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
            n.status = row[:status]
          end
        end
      end
    end
  end

  def self.to_ad_copy_csv
    CSV.generate do |csv|
      csv << ['AdGroup', 'Headline', 'Description1', 'Description2','Display URL', 'Destination URL', 'Campaign', 'Status']
      one = " 1 Exact"
      two = " 2 Phrase"
      three = " 3 ModBroad"
      four = " 4 Broad"

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + one, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign, ad_copy.status]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + two, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign, ad_copy.status]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + three, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign, ad_copy.status]
      end

      all.each do |ad_copy|
      csv << [ad_copy.ad_group + four, ad_copy.headline, ad_copy.description1, ad_copy.description2, ad_copy.display_url, ad_copy.destination_url, ad_copy.campaign, ad_copy.status]
      end
    end
  end
end
