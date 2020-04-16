class CreateTableReservation < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
    t.string :date
    t.integer :capacity
    end
  end
end
