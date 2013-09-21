class AdCopiesController < ApplicationController
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
    AdCopy.import_ad_headlines(params[:ad_headlines_file], params[:campaign])
    AdCopy.import_ad_body_copy(params[:ad_body_copy_file])
    redirect_to '/ad_copies', notice: "Ad Copy file imported"
  end

  def export
    respond_to do |format|
      format.csv { render text: Keyword.to_ad_copy_csv }
    end
  end
end
