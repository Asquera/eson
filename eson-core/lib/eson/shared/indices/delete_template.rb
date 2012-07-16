module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:DeleteTemplate#parameters}
    # {include:DeleteTemplate#source_param}
    # {include:DeleteTemplate#multi_index}
    # {include:DeleteTemplate#multi_types}
    module DeleteTemplate
      extend API
      
      # @!macro parameters
      parameters :name
    end
  end
end
