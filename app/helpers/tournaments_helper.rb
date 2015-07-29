module TournamentsHelper
  def already_entered?(tournament, team)
    result = (tournament.players - team.players.map { |p| p.id }) != tournament.players
  end
end
