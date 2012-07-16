module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:CreateIndex#parameters}
    # {include:CreateIndex#source_param}
    # {include:CreateIndex#multi_index}
    # {include:CreateIndex#multi_types}
    module CreateIndex
      extend API
      
      # @!macro no_multi_index
      multi_index false
      
      # @!macro parameters
      parameters :settings, :mappings
      
      # @!macro source_param
      source_param :settings, :mappings
    end
  end
end
