class KeywordsController < ApplicationController
	def create
		@keyword = Keyword.new(keyword_params)
		@keyword.save
	end

	def show
		@keywords = Keyword.all
		respond_to do |format|
			format.html
			format.csv { send_data @keywords.to_csv }
		end
	end

	def index
		@keywords = Keyword.all
		respond_to do |format|
			format.html
			format.csv { render text: @keywords.to_csv }
		end
	end

	def import
		Keyword.import(params[:file], params[:campaign_name])
		redirect_to '/keywords/', notice: "Keyword file imported"
	end
end
