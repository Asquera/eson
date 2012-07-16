module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:DeleteIndex#parameters}
    # {include:DeleteIndex#source_param}
    # {include:DeleteIndex#multi_index}
    # {include:DeleteIndex#multi_types}
    module DeleteIndex
      extend API
      
      # @!macro multi_index
      multi_index true
    end
  end
end
