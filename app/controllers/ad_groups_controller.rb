class AdGroupsController < ApplicationController
  def create
    @ad_group = Ad_group.new(ad_group_params)
    @ad_group.save
  end

  def index
    @ad_group = Ad_group.all # debug only, remove later
    respond_to do |format|
      format.csv { render text: Keyword.to_csv }
    end
  end
end
