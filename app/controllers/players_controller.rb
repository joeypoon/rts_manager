class PlayersController < ApplicationController
  def index
    @players = Player.active.teamless.order('created_at desc')
  end

  def show
    @player = player
  end

  def draft
    @player = player
    @player.team = current_user.team
  end

  private

    def player
      Player.find params[:id]
    end
end
