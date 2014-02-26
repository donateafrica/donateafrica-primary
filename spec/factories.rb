FactoryGirl.define do
  factory :user do
    first_name	"First Name"
    last_name	"Last Name"
    email    "test@example.com"
    password "password"
    password_confirmation "password"
  end
end