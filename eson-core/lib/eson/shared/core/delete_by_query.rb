module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # @note {include:DeleteByQuery#parameters}
    # @note {include:DeleteByQuery#source_param}
    # @note {include:DeleteByQuery#multi_index}
    # @note {include:DeleteByQuery#multi_types}
    module DeleteByQuery
      extend API

      attr_accessor :type

      # @!macro multi_index
      multi_index true

      # @!macro source_param
      source_param :query
      
      # TODO: check the parameter list
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
                 :scroll_id,
                 :indices_boost,
                 :explain,
                 :version,
                 :min_score,
                 :q,
                 :df,
                 :analyzer
                 
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
