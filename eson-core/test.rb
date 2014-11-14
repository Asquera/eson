require './lib/eson/transform/generator'

file = File.open('cluster.state.json', 'r') { |f| f.read }
hash = JSON.parse(file)
STDOUT.puts "HASH: #{hash}"

STDOUT.puts Converter.new(hash).ruby_content
