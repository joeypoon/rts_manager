class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    @team.cash = 10000
    @team.user_id = current_user.id
    if @team.save
      redirect_to players_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
    @team = Team.find params[:id]
  end

  def index
    @teams = Team.order('cash desc').page(params[:page])
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end
end
