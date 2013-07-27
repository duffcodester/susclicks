require 'spec_helper'

describe "Static Pages" do

	let(:base_title) { "Sustainable Clicks" }

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_content('Sustainable Clicks') }
		it { should have_title(full_title('')) }
		it { should_not have_title('| Home') }
	end

	describe "Instructions Page" do
  		it "should have content 'Instructions'" do
  			visit instructions_path
  			expect(page).to have_content('Instructions')
  		end

  		it "should have the right title" do
  			visit instructions_path
  			expect(page).to have_title("#{base_title} | Instructions")
  		end
 	end
end
