class PlayersController < ApplicationController
  before_action :authenticate_user, except: :rankings

  def index
    @players = players
  end

  def show
    @current_user = current_user
    @player = player
  end

  def draft
    @player = player
    @player.team = current_user.team
    if @player.save
      redirect_to root_path, notice: "#{@player.username} joined #{current_user.team.name}"
    else
      redirect_to players_path, alert: 'Recruitment failed'
    end
  end

  def rankings
    @players = Player.where("wins > ?", 0).sort_by_wins.limit(50)
  end

  private

    def players
      Player.active.teamless.sort_by_wins.page(params[:page])
    end

    def player
      Player.find params[:id]
    end
end
