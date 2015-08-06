class Reservation < ActiveRecord::Base

  validates :table_number, presence: true

end
