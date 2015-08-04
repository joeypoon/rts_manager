namespace :timed do

  desc "run tournament timed event"
  task :tournament => :environment do
    tournament = Tournament.upcoming.first
    puts "Starting #{tournament.name}..."
    tournament.start
  end

  desc "run team costs timed event"
  task :team_costs => :environment do
    Team.subtract_costs
  end

  # desc "run player age advance timed event"
  # task :advance_age => :environment do
  #   Player.advance_age
  # end
end
