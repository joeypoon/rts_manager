class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: login_params[:email]
    if @user && @user.authenticate(login_params[:password])
      login_user(@user)
      redirect_to root_path
    else
      render :login
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

  private

    def login_params
      params.require(:session).permit(:email, :password)
    end
end
