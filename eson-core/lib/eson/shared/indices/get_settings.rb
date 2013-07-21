module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # {include:GetSettings#parameters}
      # {include:GetSettings#source_param}
      # {include:GetSettings#multi_index}
      # {include:GetSettings#multi_types}
      module GetSettings
        extend API

        # @!macro multi_index
        multi_index true
      end
    end
  end
end
