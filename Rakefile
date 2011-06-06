require 'rspec/core/rake_task'
require 'cucumber/rake/task'



RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["--color"]
  t.pattern = 'spec/**/*_spec.rb'
end


Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "features --format pretty"
end


task :default => [:spec, :cucumber]

require 'jasmine'
load 'jasmine/tasks/jasmine.rake'
