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

require 'eson-dsl'
require 'faraday'
require 'elasticsearch-node/external'

module Node
  module External
    def self.instance
      @node ||= begin 
        node = ElasticSearch::Node::External.new("gateway.type" => "none") do
          def client
            conn = Faraday.new(:url => "http://#{self.ip}:#{self.port}") do |builder|
              #builder.response :raise_error
              builder.request :json
              builder.adapter :net_http
            end
          end
        end
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

#Riot.dots

class EsonQueries < Riot::ContextMiddleware
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
        create_index :index => index

        File.open(f) do |p|
          begin
            p.each_line do |l|
              index_doc :index => index,
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

        delete_mapping :index => index, :type => type

        create_index :index => index
        put_mapping :index => index,
                    :type => type,
                    :source => File.read(f)
      end
    end

    if File.exists?("#{file}.rb") 
      context.asserts(:to_query_hash).equals(eval(File.read("#{file}.rb")))
    end

    if File.exists?("#{file}.json")
      context.asserts("json format") do
        MultiJson.decode(MultiJson.encode(topic.to_query_hash))
      end.equals(MultiJson.decode(File.read("#{file}.json").strip))
    end

    context.asserts("search status") do
      begin
        result = search :index => index, :type => type, :query => topic
        result.status
      rescue Exception => e
        puts e.inspect
        raise e
      end
    end.equals(200)

  end
end

class Riot::Context
  def query_name(name)
    set :query_name, name 
  end
end

class Riot::Situation
  def node
    Node::External.instance
  end

  def create_index(opts)
    node.client.post "/#{opts[:index]}"
  end

  def index_doc(opts)
    node.client.post "/#{opts[:index]}/#{opts[:type]}", opts[:source]
  end

  def delete_mapping(opts)
    node.client.delete "/#{opts[:index]}/#{opts[:type]}"
  end

  def put_mapping(opts)
    node.client.put "/#{opts[:index]}/#{opts[:type]}/_mapping", opts[:source]
  end

  def search(opts)
    source = opts[:query].to_query_hash
    if opts[:type]
      node.client.post "/#{opts[:index]}/#{opts[:type]}/_search", source
    else
      node.client.post "/#{opts[:index]}/_search", source
    end
  end
  
  def example(file)
    eval(File.read(File.expand_path(File.join('examples', "#{file}.rb"))))
  end
end
