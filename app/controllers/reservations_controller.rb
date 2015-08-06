class ReservationsController < ApplicationController
  # before_filter :find_model, only: [:show]

  def index
    @reservations = Reservation.order(:table_number)
    @reservation = Reservation.new
  end

  # private
  # def find_model
  #   @model = Reservation.find(params[:id]) if params[:id]
  # end
end