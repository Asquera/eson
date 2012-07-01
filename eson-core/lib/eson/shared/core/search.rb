module Eson
  module Shared
    module Search
      extend API

      attr_accessor :type

      multi_index true

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
                   :min_score

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