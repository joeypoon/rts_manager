50.times do
  Player.create_player
  # name = [Faker::App.name, Faker::Team.creature, Faker::Lorem.word].sample + [Faker::App.name, Faker::Team.creature, Faker::Lorem.word].sample
  # Player.create!(username: name, age: (12..20).to_a.sample, race: [:Z, :T, :P].sample, salary: (700..1500).to_a.sample)
end
