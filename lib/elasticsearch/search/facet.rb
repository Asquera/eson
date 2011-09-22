module ElasticSearch
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
      
    end
  end
end