module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # {include:IndexStats#parameters}
      # {include:IndexStats#source_param}
      # {include:IndexStats#multi_index}
      # {include:IndexStats#multi_types}
      module IndexStats
        extend API
        # @!macro multi_index
        multi_index true

        # @!macro parameters
        parameters :docs,
                   :store,
                   :indexing,
                   :get,
                   :search,
                   :merge,
                   :flush,
                   :refresh,
                   :clear,
                   :types
      end
    end
  end
end
