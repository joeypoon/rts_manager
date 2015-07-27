50.times do
  Player.create!(username: Faker::Lorem.word, age: (12..20).to_a.sample, race: [:z, :t, :p].sample, salary: (700..1500).to_a.sample)
end
