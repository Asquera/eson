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

ElasticSearch::Node.default_config(:testing)

module Node
  module External
    def self.instance
      @node ||= begin 
        node = ElasticSearch::Node::External.new("gateway.type" => "none")
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
#require './test/seeds/seeds'

#Riot.dots

class ElasticSearchQueries < Riot::ContextMiddleware
  register
  
  def call(context) 
    middleware.call(context)
        
    return unless context.option(:query_name) 
    
    type = context.option(:type) || "bar"
    index = context.option(:index) || "default"
    file = context.option(:query_name)
    
    Dir["#{file}*.documents"].each do |f|
      
      f.match(/\A[^.]+(?:\.([^.]*))?.documents\Z/)
      type = $1 if $1
      
      context.setup(true) do
        client.create_index :index => index rescue nil
        File.open(f) do |p|
          begin
            p.each_line do |l|
              client.index :index => index,
                           :source => l,
                           :type => type
            end
          rescue Exception => e
            puts e.inspect
            raise e
          end
        end
      end
      
    end
    
    Dir["#{file}*.mapping"].each do |f|
      context.setup(true) do
        f.match(/\A[^.]+(?:\.([^.]*))?.mapping\Z/)
        type = $1 if $1
        
        if (client.get_mapping(:index => index, :type => type) rescue nil)
          client.delete_mapping :index => index, :type => type
        end
        
        client.create_index :index => index rescue nil
        client.put_mapping :index => index,
                           :type => type,
                           :source => File.read(f)
      end
    end
    
    if File.exists?("#{file}.rb") 
      context.asserts(:to_query_hash).equals(eval(File.read("#{file}.rb")))
    end
    
    if File.exists?("#{file}.json")
      context.asserts("json format") do
        MultiJson.encode(topic.to_query_hash).strip
      end.equals(File.read("#{file}.json").strip)
    end
    
    context.asserts("is understood by elasticsearch") do
      begin
        q = client.search :index => index, :type => type, :query => topic
      rescue Exception => e
        puts e.inspect
        raise e
      end
    end
    
  end
end

class Riot::Context
  def query_name(name)
    set :query_name, name 
  end
end

class Riot::Situation
 
end
