module ElasticSearch
  module Search
    module Filter
      module ClassMethods
        def short_name(name)
          define_method :name do
            name
          end
          Filters.register name, self
          
          if defined? super
            super
          end
        end
      end
      
      def self.included(base)
        base.class_eval do
          extend ClassMethods
          include Node unless base.kind_of? Node
        end
      end
      
    end
  end
end