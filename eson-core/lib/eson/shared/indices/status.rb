module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # @note {include:Status#parameters}
    # @note {include:Status#source_param}
    # @note {include:Status#multi_index}
    # @note {include:Status#multi_types}
    module Status
      extend API
      
      # @!macro multi_index
      multi_index true
    end
  end
end
