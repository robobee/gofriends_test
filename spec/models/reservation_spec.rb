require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) { build(:reservation) }
  let(:now) { DateTime.now }

  it 'has a valid factory' do
    expect(reservation).to be_valid
  end

  it 'is not valid without table_number' do
    new_reservation = build(:reservation, table_number: nil)
    new_reservation.valid?
    expect(new_reservation.errors[:table_number]).to include("can't be blank")
  end

  it 'is not valid without start_time' do
    new_reservation = build(:reservation, start_time: nil)
    new_reservation.valid?
    expect(new_reservation.errors[:start_time]).to include("can't be blank")
  end

  it 'is not valid without end_time' do
    new_reservation = build(:reservation, end_time: nil)
    new_reservation.valid?
    expect(new_reservation.errors[:end_time]).to include("can't be blank")
  end

  context 'for the same table' do

    context 'with not overlapping reservation period' do
      it 'is valid' do
        create(:reservation, start_time: now, end_time: now.in(3600))
        create(:reservation, start_time: now.in(7200), end_time: now.in(10800))
        new_res = build(:reservation, start_time: now.in(3601), end_time: now.in(7199))
        expect(new_res).to be_valid
      end
    end

    context 'with overlapping reservation period' do
      it 'is not valid if some reservation ends inside our reservation period' do
        create(:reservation, start_time: now, end_time: now.in(3600))
        new_res = build(:reservation, start_time: now.in(3599), end_time: now.in(7200))
        new_res.valid?
        expect(new_res.errors[:base]).to include("Reservations can't overlap in time")
      end

      it 'is not valid if some reservation starts inside our reservation period' do
        create(:reservation, start_time: now.in(3600), end_time: now.in(7200))
        new_res = build(:reservation, start_time: now, end_time: now.in(3601))
        new_res.valid?
        expect(new_res.errors[:base]).to include("Reservations can't overlap in time")
      end

      it 'is not valid if some reservation is fully inside our reservation period' do
        create(:reservation, start_time: now.in(3600), end_time: now.in(7200))
        new_res = build(:reservation, start_time: now, end_time: now.in(10800))
        new_res.valid?
        expect(new_res.errors[:base]).to include("Reservations can't overlap in time")
      end

      it 'is not valid if some reservation encompasses our reservation period' do
        create(:reservation, start_time: now, end_time: now.in(10800))
        new_res = build(:reservation, start_time: now.in(3600), end_time: now.in(7200))
        new_res.valid?
        expect(new_res.errors[:base]).to include("Reservations can't overlap in time")
      end
    end

  end

  context 'for different tables' do

    it 'is valid regardless of time periods' do
      create(:reservation, start_time: now.in(3601), end_time: now.in(7199))
      create(:reservation, start_time: now, end_time: now.in(3601))
      create(:reservation, start_time: now.in(7199), end_time: now.in(10800))
      create(:reservation, start_time: now, end_time: now.in(3599))
      create(:reservation, start_time: now.in(7201), end_time: now.in(10800))

      new_res = build(:reservation, table_number: 123, start_time: now.in(3600), end_time: now.in(7200))
      expect(new_res).to be_valid
    end

    it 'is valid regardless of time periods for encompassing reservation' do
      create(:reservation, start_time: now, end_time: now.in(10800))

      new_res = build(:reservation, table_number: 123, start_time: now.in(3600), end_time: now.in(7200))
      expect(new_res).to be_valid
    end
  end

end
