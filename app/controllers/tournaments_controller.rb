class TournamentsController < ApplicationController
  before_action :authenticate_user

  def index
    @tournaments = Tournament.upcoming
    @recent = Tournament.recent.limit(10)
  end

  def show
    @tournament = tournament
    @current_user = current_user
    @players = Player.where(id: @tournament.players).sort_by_wins
  end

  def join
    player = Player.find_by id: tournament_params[:players]
    @tournament = tournament
    unless @tournament.max_players? || @tournament.players.include?(player.id)
      @tournament.players << player.id
    end

    if @tournament.save
      flash.now[:notice] = "#{player.username} has joined #{@tournament.name}"
      redirect_to :back
    else
      flash.now[:alert] = "Error"
      @players = @tournament.players
      render :show
    end
  end

  private

    def tournament
      Tournament.find params[:id]
    end

    def tournament_params
      params.require(:tournament).permit(:players)
    end
end
