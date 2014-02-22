require 'spec_helper'

describe "User Pages" do
  describe "Register Page" do
    it "should have the content 'Users#new'" do
      visit '/users/new'
      expect(page).to have_content('Users#new')
    end
  end
end

