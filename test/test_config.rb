begin
  # Require the preresolved locked set of gems.
  require File.expand_path('../../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end

Bundler.require(:test, :default)

require 'echolon-http'
require 'echolon-search'

require 'elasticsearch-node/external'

module Node
  module External
    def self.instance
      @node ||= begin 
        node = ElasticSearch::Node::External.new
        at_exit do
          node.close
        end
        node
      end
    end
  end
end

Node::External.instance
require 'riot'
require './test/seeds/seeds'