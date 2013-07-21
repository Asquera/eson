module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # {include:Get#parameters}
      # {include:Get#source_param}
      # {include:Get#multi_index}
      # {include:Get#multi_types}
      module Get
        extend API

        # @!macro no_multi_index
        multi_index false

        # @!macro parameters
        parameters(
          :id,
          :type,
          :fields,
          :routing,
          :preference,
          :refresh
        )
      end
    end
  end
end
