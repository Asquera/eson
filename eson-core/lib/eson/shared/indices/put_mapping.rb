module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # {include:PutMapping#parameters}
      # {include:PutMapping#source_param}
      # {include:PutMapping#multi_index}
      # {include:PutMapping#multi_types}
      module PutMapping
        extend API

        # @!macro multi_index
        multi_index true

        # @!macro parameters
        parameters :type,
                   :ignore_conflicts,
                   :mapping

        # @!macro source_param
        source_param :mapping
      end
    end
  end
end
