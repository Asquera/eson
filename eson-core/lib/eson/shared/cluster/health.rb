module Eson
  module Shared
    module Cluster
      # Requests using this API have the following properties:
      #
      # {include:Health#parameters}
      # {include:Health#source_param}
      # {include:Health#multi_index}
      # {include:Health#multi_types}
      module Health
        extend API

        # @!macro multi_index
        multi_index true

        # @!macro parameters
        parameters :wait_for_status,
                   :level,
                   :wait_for_relocating_shards,
                   :wait_for_nodes,
                   :timeout
      end
    end
  end
end