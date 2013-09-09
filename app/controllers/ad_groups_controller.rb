class AdGroupsController < ApplicationController
  def create
    @ad_group = Ad_group.new(ad_group_params)
    @ad_group.save
  end
end
