require 'eson-core'

file = File.open('cluster.state.json', 'r') { |f| f.read }
hash = JSON.parse(file)
STDOUT.puts "HASH: #{hash}"

name, root = hash.first
ARGS = {
  name:          name,
  url:           root.fetch('url'),
  methods:       root.fetch('methods'),
  body:          root.fetch('body'),
  documentation: root.fetch('documentation')
}

STDOUT.puts Converter.new(ARGS).ruby_content
