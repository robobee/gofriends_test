class ReservationsController < ApplicationController

  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.order(:table_number)
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:message] = 'Reservation created'
      redirect_to reservation_url(@reservation)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reservation.update_attributes(reservation_params)
      flash[:message] = 'Reservation updated'
      redirect_to reservation_url(@reservation)
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    flash[:message] = 'Reservation destroyed'
    redirect_to reservations_url
  end

  private

    def set_reservation
      @reservation = Reservation.find(params[:id]) if params[:id]
    rescue ActiveRecord::RecordNotFound
      redirect_to reservations_url
    end

    def reservation_params
      params.require(:reservation).permit(:table_number, :start_time, :end_time)
    end

end
