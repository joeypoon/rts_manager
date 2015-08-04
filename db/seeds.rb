50.times do
  Player.create_player
end

tournament = Tournament.create!(name: 'Global Open', prize_pool: 1000000)
tournament = Tournament.create!(name: 'KR Open', prize_pool: 1000000)
tournament = Tournament.create!(name: 'Euro Open', prize_pool: 1000000)
