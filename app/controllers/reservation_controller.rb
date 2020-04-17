class ReservationController < ApplicationController
    before_action :get_reservations, :get_movie

    # GET /movies/:movie_id/reservations
    def index
        render json: { reservations: @reservations, status: :ok }
    end
    
    # POST /movies/:movie_id/reservation
    def create
        # byebug
        capacity_exists = @reservations.where(movie_id: reservation_params[:movie_id]).sum(:capacity)
        movie = @movie.exists?(['day LIKE ?', "%#{Date.strptime(reservation_params[:date], "%A")}%"])
        if movie
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
            render json: { message: "Resevation doesn't exist", status: :ok}
        end
    end

    def reservation_params
        params.permit(:movie_id, :date, :capacity)
    end

    def get_reservations
        @reservations = Reservation.all
    end

    def get_movie
        @movie = Movie.where(id: reservation_params[:movie_id])
    end
end