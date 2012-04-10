module Eson
  module API
    include Chainable
    
    def parameters(*params)
      chainable do
        define_method :parameters do
          super() + params
        end
        
        params.each do |p|
          attr_accessor p
        end
      end
    end
    
    # Designates the name of the parameter that will be used as the
    # body of the request. Use only if the API has such a parameter (e.g. Search).
    # You still have to list this parameter.
    # 
    # If multiple parameters are given, they will act as the keys in the sent
    # JSON object.
    #
    # @example source_param call
    #   source_param :settings, :mappings
    # @example result
    #   {
    #     "settings" : {...},
    #     "mappings" : {...}
    #   }
    def source_param(*params)
      if params.length == 1
        params = params.first
      end
      
      define_method :source_param do
        params
      end
    end
    
    def multi_index(bool)
      define_method :multi_index do
        bool
      end
    end
    
    def multi_types(bool)
      define_method :multi_types do
        bool
      end
    end
    
    def no_indices(bool)
      define_method :no_indices do
        bool
      end
    end
    
    def register(mod)
      include(mod)
    end
  end
end