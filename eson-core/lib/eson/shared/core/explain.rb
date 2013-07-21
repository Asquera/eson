module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # {include:Explain#parameters}
      # {include:Explain#source_param}
      # {include:Explain#multi_index}
      # {include:Explain#multi_types}
      module Explain
        extend API

        # @!macro multi_index
        multi_index false

        # @!macro multi_types
        multi_types false


        # @!macro source_param
        source_param :query,
                     :fields,
                     :facets,
                     :filter

        # @!macro parameters
        parameters :id,
                   :type,
                   :query,
                   :routing,
                   :parent,
                   :preference,
                   :q,
                   :df,
                   :analyzer,
                   :analyze_wildcard,
                   :lowercase_expanded_terms,
                   :lenient,
                   :default_operator,
                   :fields,
                   :facets,
                   :filter
      end
    end
  end
end
