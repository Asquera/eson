require 'json'
require 'simplecov'
require 'simplecov-console'

$LOAD_PATH << '.'
SPEC_ROOT = File.dirname(__FILE__)

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter,
]
SimpleCov.start do
  load_profile 'test_frameworks'
  add_group "Library", "lib"
  use_merging true
end

require 'eson/transform'

def load_api_sample(file_name)
  root = File.dirname(__FILE__)
  hash = JSON.parse(File.read(File.join(root, 'samples', "#{file_name}.json")))
  name, root = hash.first
  args = {
    name:          name,
    url:           root.fetch('url'),
    methods:       root.fetch('methods'),
    body:          root.fetch('body'),
    documentation: root.fetch('documentation')
  }
end
