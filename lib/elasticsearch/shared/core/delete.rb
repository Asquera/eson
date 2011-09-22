module ElasticSearch
  module Shared
    module Delete
      extend API
      
      multi_index false
      
      source_param :item
      
      parameters(
        :type, 
        :id,
        :item,
        :version,
        :op_type,
        :routing,
        :parent,
        :percolate,
        :replication,
        :consistency,
        :refresh,
        :timeout
      )  
    end
  end
end