50.times do
  Player.create_player
end

user = User.create email: 'poonjf@gmail.com', password: 'password', password_confirmation: 'password'
user.create_team name: 'Fluffy Bunnies'
user.team.players << Player.first
user.team.players << Player.second
user.team.players << Player.third

tournament = Tournament.create!(name: 'GSL', prize_pool: 1000000, players: [1,2,3])
