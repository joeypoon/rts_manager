50.times do
  Player.create_player
end

tournament = Tournament.create!(name: 'Proleague', prize_pool: 1000000)
