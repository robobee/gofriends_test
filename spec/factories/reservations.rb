FactoryGirl.define do
  
  factory :reservation do
    table_number 1
    start_time Faker::Time.between(DateTime.now - 1, DateTime.now)
    end_time Faker::Time.between(DateTime.now - 1, DateTime.now)

    factory :invalid_reservation do
      table_number nil
    end
  end

end
