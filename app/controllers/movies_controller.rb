class MoviesController < ApplicationController

    # GET /movie
    def index
        movies = Movie.all
        movies = movies.where(['day LIKE ?', "%#{params[:query]}%"]) if params[:query]
        movies = movies.map{ |m| 
            m[:day] =  m[:day].split("|") 
            m
            }
        render json: { movies: movies, status: :ok }
    end

    # POST /movie
    def create
        @movie = Movie.new(movie_params)
        if @movie.save
        render json: { message: "Movie has been saved successfully", status: :ok}
        else
        render json: @movie.errors, status: :unprocessable_entity
        end
    end

    def movie_params
        params.permit(:title, :description, :url_movie, :day)
    end
end