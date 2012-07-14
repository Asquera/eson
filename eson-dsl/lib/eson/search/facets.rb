module Eson
  module Search
    module Facets
      class FacetArray < Array
        include Parametrized
        
        def initialize(args)
          self.args = args
          instance_exec(self, &Proc.new) if block_given?
        end

        def to_query_hash
          h = {}
          self.each do |k,v|
            h[k] = v.to_query_hash
            h[k][:scope] = v.scope_name if v.scope_name
          end
          h
        end
      end

      def self.register(name, klass)
        FacetArray.__send__(:define_method, name) do |facet_name, *args, &block|
          o = klass.new(*args)
          o.args = self.args
          o.instance_exec(o, &block) if block
          self << [facet_name, o]
          o
        end
      end

      def facets(&block)
        @facets ||= FacetArray.new(args, &block)
      end
      alias :facet :facets
    end
  end
end
