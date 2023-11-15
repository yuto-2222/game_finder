class UsersController < ApplicationController
  before_action :user_or_admin?
  before_action :ensure_correct_user, only: [:edit, :update]


  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: @user.id).page(params[:page]).per(8)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def cancel
    @user = current_user
    if @user.update(is_active: false)
      flash[:success] = "退会処理が完了しました。"
      reset_session
      redirect_to root_path
    else
      flash.now[:danger] = "退会処理に失敗しました。"
      render :show
    end
  end

  # def guest_not_edit
  #   if current_user.email == 'guest@guest.com'
  #     redirect_to root_path, alert: 'ゲストは情報編集できません。'
  #   else
  #   end
  # end


  private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user or admin_signed_in?
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :introduction, :is_active)
  end

end
