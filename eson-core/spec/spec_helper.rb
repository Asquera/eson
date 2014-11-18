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
