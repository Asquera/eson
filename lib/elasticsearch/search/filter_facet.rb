module ElasticSearch
  module Search
    class FilterFacet
      include Facet
      include Filters
      include FilterMethods
      
      short_name :filter
      
    end
  end
end