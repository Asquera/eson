module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Search#parameters}
    # {include:Search#source_param}
    # {include:Search#multi_index}
    # {include:Search#multi_types}
    module Search
      extend API

      attr_accessor :type

      # @!macro multi_index
      multi_index true

      # @!macro multi_types
      multi_types true

      # @!macro source_param
      source_param :query,
                   :timeout,
                   :from,
                   :size,
                   :sort,
                   :track_scores,
                   :highlight,
                   :fields,
                   :script_fields,
                   :facets,
                   :filter,
                   :indices_boost,
                   :explain,
                   :version,
                   :min_score,
                   :suggest

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
                 :lowercase_expanded_terms,
                 :suggest

      def types
        if @types
          Array(@types)
        elsif type
          Array(type)
        else
          []
        end
      end
    end
  end
end
