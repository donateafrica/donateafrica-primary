require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "First Name", last_name: "Last Name", email: "test@example.com", password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when first_name is not present" do
  	before { @user.first_name = " " }
  	it { should_not be_valid }
  end

  describe "when first_name is too long" do
    before { @user.first_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when last_name is not present" do
  	before { @user.last_name = " " }
  	it { should_not be_valid }
  end

  describe "when last_name is too long" do
    before { @user.last_name = "a" * 51 }
    it { should_not be_valid }
  end

   describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[name@example,com first_last.com first.last@example. name@exa_mple.com name@exa+mple.com name@example..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[name@example.COM first_LAST@exa.mple.com first.last@example.io first+last@example.io]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:email_mixed_case) { "TesT@EXaMPLe.COm" }

    it "should be saved as all lower-case" do
      @user.email = email_mixed_case
      @user.save
      expect(@user.reload.email).to eq email_mixed_case.downcase
    end
  end

  describe "when password is not present" do
    before do
      @user = User.new(first_name: "First Name", last_name: "Last Name", email: "test@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:retrieved_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq retrieved_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:invalid_user) { retrieved_user.authenticate("invalid") }

      it { should_not eq invalid_user }
      specify { expect(invalid_user).to be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
end