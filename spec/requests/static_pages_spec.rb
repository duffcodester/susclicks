require 'spec_helper'

describe "Static Pages" do
	describe "Home page" do
  		it "should have content 'Sustainable Clicks'" do
  			visit '/static_pages/home'
  			expect(page).to have_content('Sustainable Clicks')
  		end

  		it "should have the right title" do
  			visit '/static_pages/home'
  			expect(page).to have_title('Sustainable Clicks | Home')
  		end
  	end

	describe "Instructions Page" do
  		it "should have content 'Instructions'" do
  			visit '/static_pages/instructions'
  			expect(page).to have_content('Instructions')
  		end

  		it "should have the right title" do
  			visit '/static_pages/instructions'
  			expect(page).to have_title('Sustainable Clicks | Instructions')
  		end
 	end
end
