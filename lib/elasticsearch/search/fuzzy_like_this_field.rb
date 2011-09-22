module ElasticSearch
  module Search
    class FuzzyLikeThisField
      include Query
      
      short_name :flt_field
      
      attr_accessor :field
      
      def initialize(field, options = {})
        self.field = QueryField.new(field, options)
      end
      
      def to_query_hash
        {name => field.to_query_hash}
      end
    end
  end
end