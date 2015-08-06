class ReservationValidator < ActiveModel::Validator

  OVERLAP_MESSAGE = "Reservations can't overlap in time"

  def validate(record)

    return if (record.start_time.nil? || record.end_time.nil? || record.table_number.nil?)

    if end_time_inside?(record)
      record.errors[:base] = OVERLAP_MESSAGE
      return
    end
    if start_time_inside?(record)
      record.errors[:base] = OVERLAP_MESSAGE
      return
    end
    if new_record_inside?(record)
      record.errors[:base] = OVERLAP_MESSAGE
      return
    end
  end

  private

    def end_time_inside?(record)
      Reservation.where("table_number = ? and end_time > ? and end_time < ?", record.table_number, record.start_time, record.end_time).exists?
    end

    def start_time_inside?(record)
      Reservation.where("table_number = ? and start_time > ? and start_time < ?", record.table_number, record.start_time, record.end_time).exists?
    end

    def new_record_inside?(record)
      Reservation.where("table_number = ? and start_time < ? and end_time > ?", record.table_number, record.start_time, record.end_time).exists?
    end
end
