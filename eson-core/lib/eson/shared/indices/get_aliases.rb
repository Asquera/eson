module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:GetAliases#parameters}
    # {include:GetAliases#source_param}
    # {include:GetAliases#multi_index}
    # {include:GetAliases#multi_types}
    module GetAliases
      extend API
      
      # @!macro multi_index
      multi_index true
    end
  end
end
