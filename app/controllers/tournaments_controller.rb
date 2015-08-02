class TournamentsController < ApplicationController
  before_action :authenticate_user

  def index
    @tournaments = Tournament.upcoming
    @recent = Tournament.recent.limit(10)
  end

  def show
    @tournament = tournament
    @current_user = current_user
    @players = Player.where(id: @tournament.players).order(wins: :desc, losses: :asc)
  end

  def join
    player = Player.find_by id: tournament_params[:players]
    @tournament = tournament
    unless @tournament.max_players? || @tournament.players.include?(player.id)
      @tournament.players << player.id
      if @tournament.save
        flash.now[:notice] = "#{player.username} has joined #{@tournament.name}"
        if @tournament.max_players?
          @tournament.start
          Tournament.generate @tournament.name, @tournament.prize_pool
        end
        redirect_to :back
      end
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
