module ElasticSearch
  module Search
    module Filters
      module FilterMethods
        
      end
      
      FILTERS = Class.new(Array) do
        include FilterMethods
        
        def filters
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
      
      attr_accessor :filters
      
      def filters(&block)
        @filters ||= FILTERS.new(&block)
      end
      alias :filter :filters
      
      def filters?
        @filters && !(@filters.empty?)
      end
      
      def self.register(name, klass)
        FilterMethods.__send__(:define_method, name) do |*args, &block|
          o = klass.new(*args)
          o.context = :filter
          block[o] if block
          filters << o
        end
      end
      
      def to_query_hash
        others = super if defined?(super)
        
        if filters? 
          { :filter => filters.to_query_hash }.tap do |h|
            h.merge!(others) if others
          end
        else
          others
        end
      end
    end
  end
end