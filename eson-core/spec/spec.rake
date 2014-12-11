require 'rake'
require 'rspec/core/rake_task'

spec_tasks = []
folders = Dir['spec/*/'].map { |d| File.basename(d) }
folders.each do |folder|
  test_files = Dir["spec/#{folder}/**/*_spec.rb"]
  unless test_files.empty?
    desc "Run RSpec suite for #{folder}"
    RSpec::Core::RakeTask.new("spec:#{folder}") do |t|
      t.pattern = "./spec/#{folder}/**/*_spec.rb"
      # JRuby needs to have the --tty option to show color
      t.rspec_opts = %w(--tty -f documentation --color)
    end
    spec_tasks << "spec:#{folder}"
  end
end

desc "Run complete application spec suite"
task :spec => spec_tasks
