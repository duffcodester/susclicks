FactoryGirl.define do
  factory :user do
    name     "Josh Duffy"
    email    "jduffy@example.com"
    password "foobar&"
    password_confirmation "foobar&"
  end
end