namespace :db do
  desc 'Reset Counter cache!'
  task :reset_counter => :environment do
    Candidate.all.each do |candidate|
      Candidate.reset_counters(candidate.id, :vote_logs)
    end
  end
  puts "done"
end