FactoryBot.define do
    factory :task do
        description { Faker::Lorem.word }
        date { Faker::Date.in_date_period }
        status { Faker::Number.between(0,3) }
    end
end