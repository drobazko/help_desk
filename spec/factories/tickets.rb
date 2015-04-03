FactoryGirl.define do
  factory :ticket do
    customer_name { Faker::Name.name }
    customer_email { Faker::Internet.email }
    subject { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence }

    association :department

    permalink "/tickets/token/AAA-AAA-AAA-AAA-AAA" 
    remote_ip "127.0.0.1"
    user_agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:34.0) Gecko/20100101 Firefox/34.0"
    referrer "http://127.0.0.1:3000/"    
  end

  factory :spam_ticket, parent: :ticket do
    body "viagra-123"
  end

  factory :invalid_ticket, parent: :ticket do
    customer_name nil
    customer_email nil
  end
end