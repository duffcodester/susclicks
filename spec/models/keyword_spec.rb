# require 'spec_helper'

# describe Keyword do
#   let(:row) { CSV::Row.new([:ad_group, :keyword], ['Gift Animal', 'one two']) }
#   let(:campaign_name) { 'test campaign' }

#   describe '#one_exact_manipulate' do
#     before do
#       Keyword.one_exact_manipulate(row, campaign_name)
#     end

#     it 'should append create the correct db object' do
#       Keyword.last[:ad_group].should == 'Gift Animal 1 Exact'
#       Keyword.last['keyword_type'].should == 'Exact'
#       Keyword.last['campaign_name'].should == campaign_name
#     end
#   end

#   describe '#two_phrase_manipulate' do
#     before do
#       Keyword.two_phrase_manipulate(row, campaign_name)
#     end

#     it 'should append create the correct db object' do
#       Keyword.last[:ad_group].should == 'Gift Animal 2 Phrase'
#       Keyword.last['keyword_type'].should == 'Phrase'
#       Keyword.last['campaign_name'].should == campaign_name
#     end
#   end

#   describe '#three_modbroad_manipulate' do
#     before do
#       Keyword.three_modbroad_manipulate(row, campaign_name)
#     end

#     it 'should append create the correct db object' do
#       Keyword.last[:ad_group].should == 'Gift Animal 3 ModBroad'
#       Keyword.last[:keyword].should == '+one +two'
#       Keyword.last['keyword_type'].should == 'Broad'
#       Keyword.last['campaign_name'].should == campaign_name
#     end
#   end

#   describe '#four_broad_manipulate' do
#     before do
#       Keyword.four_broad_manipulate(row, campaign_name)
#     end

#     it 'should append create the correct db object' do
#       Keyword.last[:ad_group].should == 'Gift Animal 4 Broad'
#       Keyword.last['keyword_type'].should == 'Broad'
#       Keyword.last['campaign_name'].should == campaign_name
#     end
#   end
# end