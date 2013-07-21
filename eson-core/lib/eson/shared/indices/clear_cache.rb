module Eson
  module Shared
      module Indices
      # Requests using this API have the following properties:
      #
      # {include:ClearCache#parameters}
      # {include:ClearCache#source_param}
      # {include:ClearCache#multi_index}
      # {include:ClearCache#multi_types}
      module ClearCache
        extend API

        # @!macro multi_index
        multi_index true

        # @!macro parameters
        parameters :filter,
                   :field_data,
                   :bloom
      end
    end
  end
end
