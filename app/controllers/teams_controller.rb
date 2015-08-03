class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    @team.user_id = current_user.id
    if @team.save
      redirect_to players_path
    else
      flash.now[:alert] = @team.errors
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

  def remove_player
    team = current_user.team
    player = Player.find_by id: params[:player_id]
    player.leave_team
    team.players.delete player
    team.save
    redirect_to root_path
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end
end
