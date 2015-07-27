class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.upcoming
  end

  def show
    @tournament = Tournament.find params[:id]
  end
end
