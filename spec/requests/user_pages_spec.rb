require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.first_name) }
  end

  describe "Register Page" do
    it "should have the content 'Register'" do
      visit new_user_path
      expect(page).to have_content('Register')
    end
  end

  describe "registration" do

    before { visit new_user_path }

    let(:submit) { "Register" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",   with: "First Name"
        fill_in "Last name",	with: "Last Name"
        fill_in "Email",        with: "first.last@example.com"
        fill_in "Password",     with: "test123"
        fill_in "Confirmation", with: "test123"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end

