gems = %w[eson-http eson-dsl eson-more]
ROOT = File.expand_path(File.dirname(__FILE__))

desc "Run tests for all gems"
task :test do
  gems.each do |g|
    sh "cd #{File.join(ROOT, g)} && #{Gem.ruby} -S rake test"
  end
end

task :default => :test