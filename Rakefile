require 'rubygems' unless defined?(Gem)
require 'rubygems/specification'
require 'rake/gempackagetask'
require 'rake/testtask'

def gemspec
  @gemspec ||= begin
    file = File.expand_path("eson-dsl.gemspec")
    ::Gem::Specification.load(file)
  end
end

desc "Validates the gemspec"
task :gemspec do
  gemspec.validate
end

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

task :package => :gemspec

Rake::TestTask.new(:test) do |test|
  test.pattern = 'test/**/*_test.rb'

  test.verbose = true
end
