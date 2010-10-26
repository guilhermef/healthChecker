require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)


# Spec::Rake::SpecTask.new do |task|
#     task.spec_opts = ['--colour --format specdoc --loadby mtime --reverse']
#     task.libs << 'lib'
#     task.spec_files = FileList['spec/*_spec.rb']
#     task.rcov = true
#     task.rcov_opts = %w{--exclude spec,lib/uuid.rb,gems\/ --text-summary --failure-threshold 100}
# end

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "features --format pretty"
end


task :default => [:spec, :cucumber]
