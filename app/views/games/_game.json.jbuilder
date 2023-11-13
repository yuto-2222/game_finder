json.extract! game, :id, :genre_id, :name, :release_date, :created_at, :updated_at
json.url game_url(game, format: :json)
