class StaticPagesController < ApplicationController
  def home
  end

  def instructions
  end

  def upload_form
    respond_to do |format|
      format.html
      format.js
    end
  end
end
