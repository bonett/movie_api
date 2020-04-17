class ReservationsController < ApplicationController
    before_action :get_reservations, :get_movie

    # GET /reservations
    def index
        reservations = @reservations.where(date: Date.parse(params[:start])..Date.parse(params[:end]))
        render json: { reservations: reservations, status: :ok }
    end
    
    # POST /movies/:movie_id/reservation
    def create
        # byebug
        capacity_exists = @reservations.where(movie_id: reservation_params[:movie_id], date: reservation_params[:date]).sum(:capacity)
        day_reservation = Date.parse(reservation_params[:date]).strftime("%A")
        if @movie.day.include?(day_reservation.downcase)
            if capacity_exists + reservation_params[:capacity] <= 10
                @reservation = Reservation.new(reservation_params)
                if @reservation.save
                    render json: { message: "Resevation has been created", status: :ok}
                end
            else
                available = 10 - capacity_exists
                render json: { message: "Ops, We have only #{available} available", status: :ok }
            end
        else
            render json: { message: "Ops, wrong day for reservation", status: :ok}
        end
    end

    def reservation_params
        params.permit(:movie_id, :date, :capacity)
    end

    def get_reservations
        @reservations = Reservation.all
    end

    def get_movie
        @movie = Movie.find_by(id: reservation_params[:movie_id])
    end
end