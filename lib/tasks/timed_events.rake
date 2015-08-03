namespace :timed do

  desc "run tournament timed events"
  task :tournament => :environment do
    while true
      sleep 1.hour
      tournament = Tournament.upcoming.first
      puts "Starting #{tournament.name}..."
      tournament.start
    end
  end

  desc "run tournament timed events"
  task :tournament => :environment do
    while true
      sleep 4.hours
      Team.subtract_costs
    end
  end

  desc "run all timed events"
  task :all => [:tournament, ]

end
