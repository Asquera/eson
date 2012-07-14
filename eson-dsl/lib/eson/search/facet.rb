module Eson
  module Search
    module Facet
      module ClassMethods
        def short_name(name)
          define_method :name do
            name
          end
          Facets.register name, self

          super if defined? super
        end
      end
      
      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end
      
      attr_accessor :args, :scope_name
      
      def param(name)
        args[name] || (raise "Parameter #{name} not given")
      end
      
      def scope(query, name)
        case query
        when Nested, HasChild
          query.options[:_scope] = name
          self.scope_name = name
        else
          raise "Cannot scope unless Query is a Nested or HasChild Query"
        end
      end

      def method_missing(name, arg)
        warn("#{name} called as a facet option")
        self.options[name] = arg
      end
    end
  end
end
