class NotificationsController < ApplicationController
  before_action :user_or_admin?

  def index
    # 通知を新しい順に
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(20)
    # pageを開いたらcheckedに変更
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    # 通知は全件削除
    @notifications = current_user.notifications.destroy_all
    redirect_to request.referer
  end

end
