module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Validate#parameters}
    # {include:Validate#source_param}
    # {include:Validate#multi_index}
    # {include:Validate#multi_types}
    module Validate
      extend API

      attr_accessor :type

      # @!macro multi_index
      multi_index false

      # @!macro multi_types
      multi_types false

      # @!macro source_param
      source_param :query

      # @!macro parameters
      parameters :timeout,
                 :types,
                 :routing,
                 :query,
                 :from,
                 :size,
                 :search_type,
                 :sort,
                 :track_scores,
                 :highlight,
                 :fields,
                 :script_fields,
                 :preference,
                 :facets,
                 :filter,
                 :scroll,
                 :indices_boost,
                 :explain,
                 :version,
                 :min_score,
                 :q,
                 :df,
                 :analyzer,
                 :lowercase_expanded_terms
    end
  end
end
