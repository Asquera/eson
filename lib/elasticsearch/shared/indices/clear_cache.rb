module ElasticSearch
  module Shared
    module ClearCache
      extend API
      
      multi_index true
      
      parameters :filter, 
                 :field_data,
                 :bloom
    end
  end
end