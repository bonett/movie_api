class AddMovieToReservation < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservations, :movie, index: true
  end
end
