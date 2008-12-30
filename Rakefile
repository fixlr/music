require 'rake/testtask'

desc "Run the music server"
task :default do 
  ruby 'init.rb'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
