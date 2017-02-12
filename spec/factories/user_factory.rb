FactoryGirl.define do
  factory :user do
    github_username { Faker::Internet.user_name }

    factory :admin do
      adminified_at { DateTime.current }
    end
  end
end
