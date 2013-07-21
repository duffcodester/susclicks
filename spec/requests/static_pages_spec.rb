require 'spec_helper'

describe "Static Pages" do

	let(:base_title) { "Sustainable Clicks" }

	describe "Home page" do
  		it "should have content 'Sustainable Clicks'" do
  			visit '/static_pages/home'
  			expect(page).to have_content('Sustainable Clicks')
  		end

  		it "should have the base title" do
  			visit '/static_pages/home'
  			expect(page).to have_title("#{base_title}")
  		end

  		it "should not have a custom title" do
  			visit '/static_pages/home'
  			expect(page).not_to have_title('| Home')
  		end
  	end

	describe "Instructions Page" do
  		it "should have content 'Instructions'" do
  			visit '/static_pages/instructions'
  			expect(page).to have_content('Instructions')
  		end

  		it "should have the right title" do
  			visit '/static_pages/instructions'
  			expect(page).to have_title("#{base_title} | Instructions")
  		end
 	end
end
