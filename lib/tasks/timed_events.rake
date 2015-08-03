namespace :timed do

  desc "run tournament timed events"
  task :tournament => :environment do
    while true
      sleep 1.hour
      Tournament.upcoming.first.start
    end
  end

  desc "run tournament timed events"
  task :tournament => :environment do
    while true
      sleep 4.hours
      Team.each do |t|
        t.cash -= t.operating_costs
        t.save
      end
    end
  end

  desc "run all timed events"
  task :all => [:tournament]

end
