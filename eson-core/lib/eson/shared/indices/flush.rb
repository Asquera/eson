module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Flush#parameters}
    # {include:Flush#source_param}
    # {include:Flush#multi_index}
    # {include:Flush#multi_types}
    module Flush
      extend API
            
      # @!macro parameters
      parameters :refresh
      
      # @!macro multi_index
      multi_index true
    end
  end
end
