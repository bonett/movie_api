class CreateTableMovie < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.belongs_to :reservation
      t.string :title
      t.text :description
      t.string :url_movie
      t.string :day
      t.timestamps
    end
  end
end
