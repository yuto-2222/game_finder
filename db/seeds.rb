puts "seed start"

Admin.find_or_create_by!(email: 'admin@admin.com') do |admin|
	unless admin.password.present?
		admin.password = ENV['admin_password']
	end
end

Genre.find_or_create_by!(name: 'ロールプレイング')
Genre.find_or_create_by!(name: 'アクション')
Genre.find_or_create_by!(name: 'アドベンチャー')
Genre.find_or_create_by!(name: 'シミュレーション')
Genre.find_or_create_by!(name: 'シューティング')
Genre.find_or_create_by!(name: 'ホラー')
Genre.find_or_create_by!(name: 'レーシング')
Genre.find_or_create_by!(name: 'パズル')
Genre.find_or_create_by!(name: '音楽')
Genre.find_or_create_by!(name: 'カード')

Game.find_or_create_by!(name: 'ロールプレイング1') do |game|
	game.genre_id = 1
	game.release_date = Date.new(1991, 01, 01)
end

Game.find_or_create_by!(name: 'ロールプレイング2') do |game|
	game.genre_id = 1
	game.release_date = Date.new(1993, 02, 22)
end

Game.find_or_create_by!(name: 'アクション1') do |game|
	game.genre_id = 2
	game.release_date = Date.new(1992, 11, 11)
end

Game.find_or_create_by!(name: 'アクション2') do |game|
	game.genre_id = 2
	game.release_date = Date.new(1994, 07, 22)
end

Game.find_or_create_by!(name: 'アドベンチャー1') do |game|
	game.genre_id = 3
	game.release_date = Date.new(1993, 04, 17)
end

Game.find_or_create_by!(name: 'アドベンチャー2') do |game|
	game.genre_id = 3
	game.release_date = Date.new(1995, 07, 21)
end

Game.find_or_create_by!(name: 'シミュレーション1') do |game|
	game.genre_id = 4
	game.release_date = Date.new(1994, 10, 10)
end

Game.find_or_create_by!(name: 'シミュレーション2') do |game|
	game.genre_id = 4
	game.release_date = Date.new(1994, 03, 14)
end

Game.find_or_create_by!(name: 'シューティング1') do |game|
	game.genre_id = 5
	game.release_date = Date.new(1990, 05, 03)
end

Game.find_or_create_by!(name: 'シューティング2') do |game|
	game.genre_id = 5
	game.release_date = Date.new(1992, 12, 12)
end

Game.find_or_create_by!(name: 'ホラー1') do |game|
	game.genre_id = 6
	game.release_date = Date.new(1995, 07, 07)
end

Game.find_or_create_by!(name: 'ホラー2') do |game|
	game.genre_id = 6
	game.release_date = Date.new(1997, 01, 30)
end

Game.find_or_create_by!(name: 'レーシング1') do |game|
	game.genre_id = 7
	game.release_date = Date.new(1996, 06, 8)
end

Game.find_or_create_by!(name: 'レーシング2') do |game|
	game.genre_id = 7
	game.release_date = Date.new(1997, 04, 19)
end

Game.find_or_create_by!(name: 'パズル1') do |game|
	game.genre_id = 8
	game.release_date = Date.new(1998, 02, 22)
end

Game.find_or_create_by!(name: 'パズル2') do |game|
	game.genre_id = 8
	game.release_date = Date.new(1999, 06, 16)
end

Game.find_or_create_by!(name: '音楽1') do |game|
	game.genre_id = 9
	game.release_date = Date.new(1999, 02, 26)
end

Game.find_or_create_by!(name: '音楽2') do |game|
	game.genre_id = 9
	game.release_date = Date.new(2000, 06, 19)
end

Game.find_or_create_by!(name: 'カード1') do |game|
	game.genre_id = 10
	game.release_date = Date.new(1995, 11, 11)
end

Game.find_or_create_by!(name: 'カード2') do |game|
	game.genre_id = 10
	game.release_date = Date.new(2000, 11, 11)
end

puts "seed finish"