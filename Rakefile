require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  if 'jruby' == RUBY_ENGINE
    test.pattern = 'test/**/*_test.rb'
  else
    test.pattern = 'test/{http,search}/*_test.rb'
  end 
  
  test.verbose = true
end

task :seed do
  require './test/seeds/seeds'
end