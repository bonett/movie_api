class ChangeColumDateReservation < ActiveRecord::Migration[6.0]
  def change
    change_column :reservations, :date, :datetime
  end
end
