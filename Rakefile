require "spec/rake/spectask"
require 'cucumber/rake/task'

Spec::Rake::SpecTask.new do |task|
    task.spec_opts = ['--colour --format specdoc --loadby mtime --reverse']
    task.libs << 'lib'
    task.spec_files = FileList['spec/*_spec.rb']
    task.rcov = true
    task.rcov_opts = %w{--exclude spec,lib/uuid.rb,gems\/ --text-summary --failure-threshold 100}
end

Cucumber::Rake::Task.new do |t|
  t.libs << 'lib'
  t.cucumber_opts = %w{--format pretty  --language pt}
end

task :default => [:spec, :cucumber]
