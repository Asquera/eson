module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Segments#parameters}
    # {include:Segments#source_param}
    # {include:Segments#multi_index}
    # {include:Segments#multi_types}
    module Segments
      extend API
      # @!macro multi_index
      multi_index true
    end
  end
end
