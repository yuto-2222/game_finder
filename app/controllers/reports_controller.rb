class ReportsController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :destroy]
	def new
		@report = Report.new
		render :layout => false
	end

	def index
		@reports = Report.all.order(created_at: :desc).page(params[:page]).per(10)

		@reports.where(is_checked: false).each do |report|
      report.update(is_checked: true)
    end
	end

	def create
		# ユーザーが報告する対象の種類とIDを取得
		content_type = params[:report][:content_type]
		content_id = params[:report][:content_id]

		# 対象のコンテンツをデータベースから取得
		@content = content_type.constantize.find(content_id)

		# 対象のコンテンツが存在する場合
		if @content
			# 新しい報告オブジェクトを作成
			@report = Report.new(report_params)

			# 報告者と報告対象を設定
			@report.reporter = current_user
			if @content.is_a?(User)
			  @report.reported = @content
			else
				@report.reported = @content.user
			end

			# 報告をデータベースに保存
			if @report.save
				respond_to do |format|
					format.js { render "create_success" } # 成功時のレスポンス
				end
			else
				respond_to do |format|
					format.js { render "create_failure" } # 失敗時のレスポンス
				end
			end
		end

	rescue ActiveRecord::NotNullViolation => e
		# NOT NULL 制約違反が発生した場合もエラー処理
		respond_to do |format|
			format.js { render "create_failure", status: :unprocessable_entity } # エラーレスポンスを返す
		end
	end

	def destroy
		@report = Report.find(params[:id]).destroy
		redirect_to request.referer
	end

	private

	# コンテンツをデータベースから取得するメソッド
	def find_content(content_type, content_id)
		content_class = content_type.classify.constantize
		content_class.find_by(id: content_id)
	end

	def report_params
		params.require(:report).permit(:content_type, :content_id, :reason)
	end
end
