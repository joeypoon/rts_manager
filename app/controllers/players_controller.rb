class PlayersController < ApplicationController
  before_action :authenticate_user

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
      if current_user.team.players.count < 5
        redirect_to players_path, notice: "#{@player.username} joined #{current_user.team.name}"
      else
        redirect_to root_path, notice: "#{@player.username} joined #{current_user.team.name}"
      end
    else
      redirect_to players_path, alert: 'Recruitment failed'
    end
  end

  private

    def players
      Player.active.teamless.order('created_at desc').page(params[:page])
    end

    def player
      Player.find params[:id]
    end
end
