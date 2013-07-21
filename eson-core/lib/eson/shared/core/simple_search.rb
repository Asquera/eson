module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # {include:SimpleSearch#parameters}
      # {include:SimpleSearch#source_param}
      # {include:SimpleSearch#multi_index}
      # {include:SimpleSearch#multi_types}
      module SimpleSearch
        extend API

        # @!macro multi_index
        multi_index true

        attr_accessor :type

        # @!macro parameters
        parameters :timeout,
                   :types,
                   :q,
                   :routing,
                   :df,
                   :analyzer,
                   :fields,
                   :sort,
                   :track_scores,
                   :timeout,
                   :from,
                   :size,
                   :search_type

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
end
