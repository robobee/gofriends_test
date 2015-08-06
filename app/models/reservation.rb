class Reservation < ActiveRecord::Base

  validates :table_number, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validates_with ReservationValidator

end
