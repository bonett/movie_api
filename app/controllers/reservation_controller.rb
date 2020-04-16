class ReservationController < ApplicationController

    # GET /movies/:movie_id/reservations
    def index
        reservations = Reservation.all
        reservations = reservations.find_by(movie_id: params[:movie_id])
        render json: { reservations: reservations, status: :ok }
    end
    
    # POST /movies/:movie_id/reservation
    def create
        # byebug
        reservations = Reservation.all
        reservations = reservations.find_by(movie_id: params[:movie_id])
        if reservations
            reservationDate = Date.parse(reservations['date'])
            render json: { message: "Resevation has been created,for #{reservationDate} places", status: :ok}
        else
            @reservation = Reservation.new(reservation_params)
            if @reservation.save
                render json: { message: "Resevation has been created", status: :ok}
            else
                render json: { message: "Resevation does not exist", status: :ok }
            end
        end
    end

    def reservation_params
        params.permit(:movie_id, :date, :capacity)
    end
end