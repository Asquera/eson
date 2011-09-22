module ElasticSearch
  module Shared
    module Flush
      extend API
            
      parameters :refresh
      
      multi_index true
    end
  end
end