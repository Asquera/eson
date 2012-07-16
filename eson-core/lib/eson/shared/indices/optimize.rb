module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # @note {include:Optimize#parameters}
    # @note {include:Optimize#source_param}
    # @note {include:Optimize#multi_index}
    # @note {include:Optimize#multi_types}
    module Optimize
      extend API
          
      # @!macro multi_index
      multi_index true
      
      # @!macro parameters
      parameters :max_num_segments,
                 :only_expunge_deletes,
                 :refresh,
                 :flush,
                 :wait_for_merge
    end
  end
end
