class KeywordsController < ApplicationController
	def create
		@keyword = Keyword.new(keyword_params)
		@keyword.save
	end

	def show
		@keywords = Keyword.all
		respond_to do |format|
			format.html
			format.csv { send_data @keywords.to_keyword_csv }
		end
	end

	def index
		@keywords =	Keyword.all # debug only, remove later
		respond_to do |format|
			format.html
			format.csv { render text: Keyword.to_keyword_csv }
		end
	end

	def export_ad_group
		respond_to do |format|
			format.csv { render text: Keyword.to_ad_group_csv }
		end
	end

	def import
		Keyword.import(params[:file], params[:campaign_name])
		redirect_to '/keywords/', notice: "Keyword file imported"
	end
end
