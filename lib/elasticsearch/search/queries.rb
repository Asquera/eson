module ElasticSearch
  module Search
    module Queries
      module QueryMethods
        
      end
      
      QUERIES = Class.new(Array) do
        include QueryMethods
        
        def queries
          self
        end
        
        def initialize
          yield self if block_given?
        end
        
        def to_query_hash
          if length == 1
            first.to_query_hash
          else
            map(&:to_query_hash)
          end
        end
      end
      
      attr_accessor :queries
      
      def self.register(name, klass)
        QueryMethods.__send__(:define_method, name) do |*args, &block|
          o = klass.new(*args)
          o.context = :query
          block[o] if block
          queries << o
        end
      end
      
      def queries(&block)
        @queries ||= QUERIES.new(&block)
      end
      alias :query :queries
      
      def queries?
        @queries && !(@queries.empty?)
      end
      
      def to_query_hash
        others = super if defined?(super)
        
        if queries?
          { :query => queries.to_query_hash }.tap do |h|
            h.merge!(others) if others
          end
        else
          others
        end
      end
    end
  end
end