module Eson
  module Shared
    module State
      extend API
      #TODO implement filter_indices correctly
      
      multi_index true
      
      parameters :filter_nodes,
                 :filter_routing_table,
                 :filter_metadata,
                 :filter_blocks,
                 :filter_indices
            
    end
  end
end