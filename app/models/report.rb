class Report < ApplicationRecord
	# 通報者を示す関連付け
	belongs_to :reporter, class_name: "User", foreign_key: "reporter_id"

	# 通報対象を示す関連付け
	belongs_to :reported, class_name: "User", foreign_key: "reported_id"

	# 通報対象のコンテンツを示す多様性（Polymorphic）関連付け
	belongs_to :content, polymorphic: true

	# 通報理由
	enum reason: {
		malicious_expression: 0,      # 悪意のある表現
		inappropriate_content: 1,     # 不適切なコンテンツ
		misinformation: 2,            # 誤った情報
		commercial_purposes: 3,       # 商業目的
		spam: 4,                      # スパム
		other: 5                      # その他
	}

	def link_to_reported_user(report)
	  if report.reported.is_a?(User)
	    link_to report.reported.nickname, user_path(report.reported), target: "_blank"
	  elsif report.reported.is_a?(Review)
	    link_to "View Review", review_path(report.reported), target: "_blank"
	  elsif report.reported.is_a?(Comment)
	    link_to "View Comment", comment_path(report.reported), target: "_blank"
	  else
	    "Unknown Type"
	  end
	end

end
