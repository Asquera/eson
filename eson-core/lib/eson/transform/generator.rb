require 'erb'
require 'json'

require 'parser/current'
require 'unparser'

class Converter
  attr_reader :documentation, :methods, :url

  def initialize(hash)
    @root          = hash.fetch('cluster.state')
    @documentation = @root.fetch('documentation')
    @methods       = @root.fetch('methods')
    @url           = @root.fetch('url')
  end

  def ruby_content
    root = File.dirname(__FILE__)
    template = File.read(File.join(root, 'templates', 'base.erb'))
    content  = ERB.new(template).result(binding)

    # Check if there are no Ruby errors
    node = Parser::CurrentRuby.parse(content)
    Unparser.unparse(node)

    content
  end

  def top_level_name
    'Cluster'
  end

  def module_name
    'State'
  end
end
