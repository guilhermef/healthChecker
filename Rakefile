require 'rspec/core/rake_task'
# require 'jasmine-headless-webkit'
# require 'jasmine/headless/task'
require 'jasmine'
load 'jasmine/tasks/jasmine.rake'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["--color"]
  t.pattern = 'spec/**/*_spec.rb'
end

# Jasmine::Headless::Task.new

task :travis do
  ["rspec spec", "rake jasmine:ci"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end

task :default => [:spec]