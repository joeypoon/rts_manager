class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      login_user(@user)
      redirect_to new_team_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :token)
    end
end
