module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # {include:Delete#parameters}
      # {include:Delete#source_param}
      # {include:Delete#multi_index}
      # {include:Delete#multi_types}
      module Delete
        extend API

        # @!macro no_multi_index
        multi_index false

        # @!macro source_param
        source_param :item

        # @!macro parameters
        parameters(
          :type,
          :id,
          :item,
          :version,
          :op_type,
          :routing,
          :parent,
          :percolate,
          :replication,
          :consistency,
          :refresh,
          :timeout
        )
      end
    end
  end
end
