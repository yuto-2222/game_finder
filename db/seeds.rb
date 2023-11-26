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

puts "seed finish"