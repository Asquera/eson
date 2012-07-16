module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:GetMapping#parameters}
    # {include:GetMapping#source_param}
    # {include:GetMapping#multi_index}
    # {include:GetMapping#multi_types}
    module GetMapping
      extend API
      
      attr_accessor :type
      # @!macro parameters
      parameters :types
      
      # @!macro multi_index
      multi_index true
      
      def types
        @types || Array(@type)
      end
    end
  end
end
