50.times do
  Player.create_player
end

tournament = Tournament.create!(name: 'GSL', prize_pool: 1000000)
