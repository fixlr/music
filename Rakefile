task :default => ["server"]

desc "Run all tests"
task :test do
  sh 'ruby test/*_test.rb'
end

desc "Run the music server"
task :server do 
  sh 'ruby server.rb'
end
