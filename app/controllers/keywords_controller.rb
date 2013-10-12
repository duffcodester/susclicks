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
		# flash[:success] = 'File Downloaded, Database has been cleared'
    respond_to do |format|
			format.csv { render text: Keyword.to_ad_group_csv }
		end
    Keyword.all.each do |record| #Clear the database after download
      record.destroy
    end
	end

	def import
    begin
      Keyword.validate_keyword_file(params[:file])
      if $valid_keyword_file
        Keyword.import(params[:file], params[:campaign_name])
        flash[:success] = "Keyword File Imported"
        redirect_to '/keywords/'
      else
        flash[:error] = "Invalid Keyword Input File"
        redirect_to '/process_keyword_file'
      end
    rescue
      flash[:error] = 'Please check your file'
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
