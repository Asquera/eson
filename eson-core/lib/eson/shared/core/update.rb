module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Update#parameters}
    # {include:Update#source_param}
    # {include:Update#multi_index}
    # {include:Update#multi_types}
    module Update
      extend API
      
      # @!macro no_multi_index
      multi_index false
      
      # @!macro parameters
      parameters :timeout, 
                 :type, 
                 :routing,
                 :parent,
                 :id,
                 :consistency,
                 :percolate,
                 :refresh,
                 :script,
                 :params,
                 :retry_on_conflict
      
      # @!macro source_param
      source_param :script,
                   :params
    end
  end
end
