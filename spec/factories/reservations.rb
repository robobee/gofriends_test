FactoryGirl.define do
  
  factory :reservation do
    table_number Random.new.rand(3) + 1
    start_time Faker::Time.between(DateTime.now - 1, DateTime.now)
    end_time Faker::Time.between(DateTime.now - 1, DateTime.now)
  end

end
