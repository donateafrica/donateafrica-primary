require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do
    it "should have the content 'StaticPages#home'" do
      visit '/'
      expect(page).to have_content('StaticPages#home')
    end
  end
end
