module TournamentsHelper
  def already_entered?(tournament, team)
    result = (tournament.players - team.players.map { |p| p.id }) != tournament.players
  end

  def round_of(round)
    if round.players.count.even?
      round.players.count
    else
      round.players.count + 1
    end
  end
end
