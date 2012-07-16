module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:IndexExists#parameters}
    # {include:IndexExists#source_param}
    # {include:IndexExists#multi_index}
    # {include:IndexExists#multi_types}
    module IndexExists
      extend API
      
      # @!macro multi_index
      multi_index true
    end
  end
end
