module ElasticSearch
  module Shared
    module Percolate
      extend API
      
      multi_index false
      
      parameters :query,
                 :doc,
                 :prefer_local,
                 :type
      
      source_param :doc, :query
      
    end
  end
end