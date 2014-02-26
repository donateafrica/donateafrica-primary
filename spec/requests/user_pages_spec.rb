require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.first_name) }
  end

  describe "Register Page" do
    it "should have the content 'Users#new'" do
      visit '/users/new'
      expect(page).to have_content('Users#new')
    end
  end
end

