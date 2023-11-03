class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :genre_id,  null: false
      t.string :name,       null: false
      t.date :release_date, null: false

      t.timestamps
    end
  end
end
