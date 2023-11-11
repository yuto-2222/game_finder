class AddPlayedCountToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :played_count, :integer, default: 0
  end
end
