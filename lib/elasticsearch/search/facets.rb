module ElasticSearch
  module Search
    module Facets
      FACETS = Class.new(Array) do
        def initialize
          instance_exec(self, &Proc.new) if block_given?
        end
        
        def to_query_hash
          h = {}
          self.each do |k,v|
            h[k] = v.to_query_hash
          end
          h
        end
      end
      
      attr_accessor :queries
      
      def self.register(name, klass)
        FACETS.__send__(:define_method, name) do |facet_name, *args, &block|
          o = klass.new(*args)
          o.instance_exec(o, &block) if block
          self << [facet_name, o]
        end
      end
      
      def facets(&block)
        @facets ||= FACETS.new(&block)
      end
      alias :facet :facets
    end
  end
end