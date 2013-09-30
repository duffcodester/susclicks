class AdCopiesController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :import, :export]

  def index
    @ad_copies = AdCopy.all # debug only, remove later
    respond_to do |format|
      format.html
      format.csv { render text: AdCopy.to_ad_copy_csv }
    end
  end

  def show
    @ad_copies = AdCopy.all # debug only, remove later
    respond_to do |format|
      format.html
      format.csv { render text: AdCopy.to_ad_copy_csv }
    end
  end

  def import
    AdCopy.all.each do |record|
      record.destroy
    end
    begin
      AdCopy.import_ad_headlines(params[:ad_headlines_file], params[:campaign])
      begin
        AdCopy.import_ad_body_copy(params[:ad_body_copy_file])
        flash[:success] = "Ad Copy file imported"
        redirect_to '/ad_copies'
      rescue
        flash[:error] = "Invalid Ad Copy File"
        redirect_to '/process_ad_copy_headline_files'
      end
    rescue
      flash[:error] = "Invalid Ad Headlines File"
      redirect_to '/process_ad_copy_headline_files'
    end
  end

  def export
    respond_to do |format|
      format.csv { render text: Keyword.to_ad_copy_csv }
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
