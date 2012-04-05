module Eson
  module Search
    module Facet
      module ClassMethods
        def short_name(name)
          define_method :name do
            name
          end
          Facets.register name, self

          if defined? super
            super
          end
        end
      end

      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end

      def scope(query, name)
        raise "Cannot scope unless Query is a NestedQuery" unless Nested === query
        query.options[:_scope] = name
        self.options[:scope] = name
      end
      
      def method_missing(name, arg)
        warn("#{name} called as a facet option")
        self.options[name] = arg
      end
    end
  end
end