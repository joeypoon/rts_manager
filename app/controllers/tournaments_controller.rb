class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.upcoming
  end

  def show
    @tournament = tournament
    @current_user = current_user
    @teams = Team.where(id: @tournament.teams)
  end

  def join
    @tournament = tournament
    @tournament.teams << current_user.team.id
    if @tournament.save
      flash.now[:notice] = "#{current_user.team.name} has joined #{@tournament.name}"
      redirect_to :back
    else
      flash.now[:alert] = "Error"
      render :show
    end
  end

  private

    def tournament
      Tournament.find params[:id]
    end
end
