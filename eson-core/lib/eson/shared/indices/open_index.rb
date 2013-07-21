module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # {include:OpenIndex#parameters}
      # {include:OpenIndex#source_param}
      # {include:OpenIndex#multi_index}
      # {include:OpenIndex#multi_types}
      module OpenIndex
        extend API

        # @!macro multi_index
        multi_index true
      end
    end
  end
end
