require 'rails_helper'

class Validatable
  include ActiveModel::Validations
  validates_with ReservationValidator
  attr_accessor :table_number, :start_time, :end_time
end

RSpec.describe ReservationValidator do
  
  let(:reservation) do 
    validatable = Validatable.new
    validatable.table_number = 1
    validatable.start_time = DateTime.now
    validatable.end_time = DateTime.now.in(3600)
    return validatable
  end

  let(:validator) { ReservationValidator.new }
  let(:all_private_methods) { [:end_time_inside?, :start_time_inside?, :new_record_inside?] }

  describe "#validate" do

    context 'does not call private validation methods' do

      it 'if start_time is nil' do
        reservation.start_time = nil
        all_private_methods.each do |mtd|
          expect(validator).not_to receive(mtd).with(reservation)
        end
        expect(reservation.errors[:base]).not_to include("Reservations can't overlap in time")
      end

      it 'if end_time is nil' do
        reservation.end_time = nil
        all_private_methods.each do |mtd|
          expect(validator).not_to receive(mtd).with(reservation)
        end
        expect(reservation.errors[:base]).not_to include("Reservations can't overlap in time")
      end

      it 'if table_number is nil' do
        reservation.table_number = nil
        all_private_methods.each do |mtd|
          expect(validator).not_to receive(mtd).with(reservation)
        end
        expect(reservation.errors[:base]).not_to include("Reservations can't overlap in time")
      end

    end

    it 'calls all private validation methods if none of them returns true' do
      all_private_methods.each do |mtd|
        expect(validator).to receive(mtd).with(reservation)
      end

      validator.validate(reservation)

      expect(reservation.errors[:base]).not_to include("Reservations can't overlap in time")
    end

    context 'short-circuits validation methods' do

      it 'when first returns true' do
        # stub first method to return true
        allow(validator).to receive(:end_time_inside?) { true }

        expect(validator).to receive(:end_time_inside?).with(reservation)
        expect(validator).not_to receive(:start_time_inside?).with(reservation)
        expect(validator).not_to receive(:new_record_inside?).with(reservation)

        validator.validate(reservation)

        expect(reservation.errors[:base]).to include("Reservations can't overlap in time")
      end

      it 'when second returns true' do
        # stub second method to return true
        allow(validator).to receive(:end_time_inside?) { false }
        allow(validator).to receive(:start_time_inside?) { true }

        expect(validator).to receive(:end_time_inside?).with(reservation)
        expect(validator).to receive(:start_time_inside?).with(reservation)
        expect(validator).not_to receive(:new_record_inside?).with(reservation)

        validator.validate(reservation)

        expect(reservation.errors[:base]).to include("Reservations can't overlap in time")
      end

    end

  end

end
