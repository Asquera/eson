module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # @note {include:Percolate#parameters}
      # @note {include:Percolate#source_param}
      # @note {include:Percolate#multi_index}
      # @note {include:Percolate#multi_types}
      module Percolate
        extend API

        # @!macro no_multi_index
        multi_index false

        # @!macro parameters
        parameters :query,
                   :doc,
                   :prefer_local,
                   :type,
                   :index

        # @!macro source_param
        source_param :doc, :query

      end
    end
  end
end
