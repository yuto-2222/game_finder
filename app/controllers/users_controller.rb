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
      reset_session
      redirect_to root_path
    else
      render :show
    end
  end


  private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user or admin_signed_in?
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :introduction, :is_active, :profile_image)
  end

end
