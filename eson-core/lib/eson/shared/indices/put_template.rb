module Eson
  module Shared
      module Indices
      # Requests using this API have the following properties:
      #
      # @note {include:PutTemplate#parameters}
      # @note {include:PutTemplate#source_param}
      # @note {include:PutTemplate#multi_index}
      # @note {include:PutTemplate#multi_types}
      module PutTemplate
        extend API

        # @!macro parameters
        parameters :template, :settings, :mappings, :name
        # @!macro source_param
        source_param :template, :settings, :mappings
      end
    end
  end
end
