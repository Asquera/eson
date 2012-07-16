module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:CloseIndex#parameters}
    # {include:CloseIndex#source_param}
    # {include:CloseIndex#multi_index}
    # {include:CloseIndex#multi_types}
    module CloseIndex
      extend API
      
      # @!macro multi_index
      multi_index true
    end
  end
end
