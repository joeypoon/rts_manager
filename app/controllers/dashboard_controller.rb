class DashboardController < ApplicationController
  before_action :authenticate_user

  def home
    @current_user = current_user
    @team = current_user.team
  end
end
