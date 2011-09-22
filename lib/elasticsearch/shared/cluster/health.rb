module ElasticSearch
  module Shared
    module Health
      extend API
      
      multi_index true
      
      parameters :wait_for_status,
                 :level,
                 :wait_for_relocating_shards,
                 :wait_for_nodes,
                 :timeout
      
    end
  end
end