module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:State#parameters}
    # {include:State#source_param}
    # {include:State#multi_index}
    # {include:State#multi_types}
    module State
      extend API
      #TODO implement filter_indices correctly
      
      # @!macro multi_index
      multi_index true
      
      # @!macro parameters
      parameters :filter_nodes,
                 :filter_routing_table,
                 :filter_metadata,
                 :filter_blocks,
                 :filter_indices
            
    end
  end
end
