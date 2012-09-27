module Eson
  module Search
    class CustomFiltersScore
      include Queries
      include Query
      
      # @!macro eson.query
      short_name :custom_filters_score

      attr_accessor :options, :filters

      def initialize(options = {})
        self.options = options
        self.filters = []
      end

      def filters(&block)
        instance_exec(self, &block)
      end

      def filter(options, &block)
        sub = SubQuery.new(args)
        
        @filters << [options, sub]
        
        sub.send(context, &block)
      end

      def to_query_hash
        result = {}

        result[:query] = queries.to_query_hash
        result[:filters] = @filters.map do |options, filter|
          {:filter => filter.to_query_hash}.merge!(options)
        end

        {name => result.merge(options)}
      end

    end
  end
end