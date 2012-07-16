module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:UpdateSettings#parameters}
    # {include:UpdateSettings#source_param}
    # {include:UpdateSettings#multi_index}
    # {include:UpdateSettings#multi_types}
    module UpdateSettings
      extend API
      
      # @!macro parameters
      parameters :settings
      # @!macro source_param
      source_param :settings
      
      # @!macro multi_index
      multi_index true
    end
  end
end
