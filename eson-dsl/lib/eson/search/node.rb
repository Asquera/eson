module Eson
  module Search
    module Node
      attr_accessor :context
      attr_accessor :args
      attr_accessor :options
      
      def param(name)
        args[name] || (raise "Parameter #{name} not given")
      end
      
      def options
        @options ||= {}
      end
      
      def to_query_hash
        values = options

        if defined?(super)
          values = values.merge(super)
        end

        { name => values }
      end

    end
  end
end