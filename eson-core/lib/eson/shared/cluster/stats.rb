module Eson
  module Shared
    module Cluster
      # Requests using this API have the following properties:
      #
      # {include:Stats#parameters}
      # {include:Stats#source_param}
      # {include:Stats#multi_index}
      # {include:Stats#multi_types}
      module Stats
        extend API

        # @!macro no_multi_index
        multi_index false

        # @!macro parameters
        parameters :nodes

        def nodes
          Array(@nodes)
        end
      end
    end
  end
end
