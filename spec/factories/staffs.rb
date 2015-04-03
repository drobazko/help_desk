FactoryGirl.define do
  factory :staff do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password "12344321q"
    password_confirmation "12344321q"
    role 'customer'
  end

  factory :member_staff, parent: :staff do
    association :department
    role 'member'
  end

  factory :admin_staff, parent: :staff do
    role  'admin'
  end
end