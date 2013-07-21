module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # @note {include:Refresh#parameters}
      # @note {include:Refresh#source_param}
      # @note {include:Refresh#multi_index}
      # @note {include:Refresh#multi_types}
      module Refresh
        extend API

        # @!macro multi_index
        multi_index true

        # @!macro parameters
        parameters :max_num_segments,
                   :only_expunge_deletes,
                   :refresh,
                   :flush,
                   :wait_for_merge

      end
    end
  end
end
