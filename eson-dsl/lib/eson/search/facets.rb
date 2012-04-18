module Eson
  module Search
    module Facets
      class FacetArray < Array
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

      def self.register(name, klass)
        FacetArray.__send__(:define_method, name) do |facet_name, *args, &block|
          o = klass.new(*args)
          o.instance_exec(o, &block) if block
          self << [facet_name, o]
          o
        end
      end

      def facets(&block)
        @facets ||= FacetArray.new(&block)
      end
      alias :facet :facets
    end
  end
end