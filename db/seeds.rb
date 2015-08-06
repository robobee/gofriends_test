# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

r = Random.new

10.times do
  start_time = Faker::Time.between(DateTime.now - 1, DateTime.now)
  end_time = Faker::Time.between(DateTime.now - 1, DateTime.now)
  
  Reservation.create(
    table_number: r.rand(3) + 1,
    start_time: start_time,
    end_time: end_time
  )
end
