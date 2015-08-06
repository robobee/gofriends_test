# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

r = Random.new

5.times do |t|
  start = DateTime.now
  5.times do |offset|
    Reservation.create(
      table_number: t + 1,
      start_time: start.in(offset * 3600),
      end_time: start.in(3600 + offset * 3600)
    )
  end
end
