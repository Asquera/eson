require 'virtus'

module Eson
  # Objects including API act as API descriptions. They mostly act as a
  # description of parameter names and roles to use in protocol implementations. 
  # Parameters are split in 2 sets: all parameters (params) and parameters
  # that are transmitted in the body of a request (if the protocol has a
  # notion of "body"). These descriptions are intended to be refined by
  # protocol implementations.
  #
  # For examples of this strategy, see {Eson::Shared::Index} and 
  # {Eson::HTTP::Index}.
  module API
    include Chainable

    # Designates the names of all parameters supported by this request, including
    # those used in the source later on.
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

    def parameter_string(name)
      extend(Virtus.model)

      attribute name.to_sym, String
    end

    def parameter_bool(name)
      extend(Virtus.model)

      attribute name.to_sym, Boolean, default: true
    end

    def parameter_enum(name, enum_values = [], default = nil)
      name = name.to_s
      extend(Virtus.model)

      # create specific attribute and set to default
      attribute name.to_sym, String
      self.send("#{name}=", default)

      # overload virtus setter method
      self.define_singleton_method("#{name}=") do |value|
        unless enum_values.include?(value)
          raise ArgumentError, "#{value} not a valid enum value"
        end
        super value
      end
    end

    # Designates the name of the parameter that will be used as the
    # body of the request. Use only if the API has such a parameter (e.g. Search).
    # You still have to list the parameter.
    #
    # If multiple parameters are given, they will act as the keys in the sent
    # JSON object.
    #
    # If the transport has no concept of a "source", this should be ignored.
    #
    # @example source_param call
    #   parameters :settings, :mappings
    #   source_param :settings, :mappings
    # @example result
    #   {
    #     "settings" : {...},
    #     "mappings" : {...}
    #   }
    # 
    def source_param(*params)
      if params.length == 1
        params = params.first
      end
      
      define_method :source_param do
        params
      end
    end

    # Indicates whether the api accepts multiple indices like `["index1", "index2"]
    def multi_index(bool)
      define_method :multi_index do
        bool
      end
    end

    # Indicates whether the api accepts multiple types like `["type1", "type2"]
    def multi_types(bool)
      define_method :multi_types do
        bool
      end
    end

    # Indicates whether the api does not operate on an index at all.
    def no_indices(bool)
      define_method :no_indices do
        bool
      end
    end
  end
end

# @!macro parameters
#   The request supports the following parameters: ${1--1}
#
#   @method parameters
#   @return [Array<String>] The parameters

# @!macro source_param
#   The request declares the following parameters as source parameters: ${1--1}
#
#   @method source_param
#   @return [Array<String>] The source parameters

# @!macro multi_index
#   The request can operate on multiple indices.
# 
#   @method multi_index
#   @return [true]

# @!macro no_multi_index
#   The request does not operate on multiple indices.
#
#   @method multi_index
#   @return [false]

# @!macro multi_types
#   The request can operate on multiple types.
#
#   @method multi_types
#   @return [true]

# @!macro no_multi_types
#   The request cannot operate on multiple types.
#   @method multi_types
#   @return [false]