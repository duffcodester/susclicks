class KeywordsController < ApplicationController
	before_action :signed_in_user, only: [:index, :show, :create, :import, :export_ad_group]

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
		Keyword.all.each do |record|
		  record.destroy
		end
		begin
			Keyword.import(params[:file], params[:campaign_name])
			flash[:success] = "Keyword file imported"
			redirect_to '/keywords/'
		rescue
			flash[:error] = "Invalid Keyword Input File"
      redirect_to '/process_keyword_file'
    end
	end

	private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
end
