module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:MultiGet#parameters}
    # {include:MultiGet#source_param}
    # {include:MultiGet#multi_index}
    # {include:MultiGet#multi_types}
    module MultiGet
      extend API

      # @!macro no_multi_index
      multi_index false

      # @!macro source_param
      source_param :docs,
                   :ids
                    
      # @!macro parameters
      parameters :type,
                 :docs,
                 :ids
    end
  end
end
