module Eson
  module Shared
      module Indices
      # Requests using this API have the following properties:
      #
      # {include:DeleteMapping#parameters}
      # {include:DeleteMapping#source_param}
      # {include:DeleteMapping#multi_index}
      # {include:DeleteMapping#multi_types}
      module DeleteMapping
        extend API

        # @!macro parameters
        parameters :type

        # @!macro multi_index
        multi_index true
      end
    end
  end
end