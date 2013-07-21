module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # {include:GetTemplate#parameters}
      # {include:GetTemplate#source_param}
      # {include:GetTemplate#multi_index}
      # {include:GetTemplate#multi_types}
      module GetTemplate
        extend API

        # @!macro parameters
        parameters :name
      end
    end
  end
end
