module ElasticSearch
  module Shared
    module Get
      extend API
            
      multi_index false
      
      parameters(
        :id, 
        :type,
        :fields,
        :routing,
        :preference,
        :refresh
      )
      
    end
  end
end