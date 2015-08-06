require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) { FactoryGirl.build(:reservation) }

  it 'has a valid factory' do
    expect(reservation).to be_valid
  end

  it 'is not valid without table_number' do
    new_reservation = FactoryGirl.build(:reservation, table_number: nil)
    new_reservation.valid?
    expect(new_reservation.errors[:table_number]).to include("can't be blank")
  end

end
