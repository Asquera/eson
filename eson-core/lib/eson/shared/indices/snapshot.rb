module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # {include:Snapshot#parameters}
      # {include:Snapshot#source_param}
      # {include:Snapshot#multi_index}
      # {include:Snapshot#multi_types}
      module Snapshot
        extend API

        # @!macro multi_index
        multi_index true
      end
    end
  end
end
