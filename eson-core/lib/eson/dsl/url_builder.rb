require 'eson/dsl/param_builder'
require 'eson/dsl/part_builder'

module Eson
  module API
    module DSL
      class UrlBuilder
        attr_reader :base_path
        attr_reader :paths
        attr_reader :parts
        attr_reader :params

        def initialize(base_path = nil, &block)
          @params = ParamBuilder.new
          @parts  = PartBuilder.new
          @base_path = base_path
          instance_eval(&block) if block_given?
        end

        def path(path)
          @paths ||= []
          @paths << path
        end

        def part(path, args = {})
          # parse to its own object, add validation?
          @parts.add_part(path, args)
          @parts
        end

        def params(&block)
          @params.instance_eval(&block) if block_given?
          @params
        end
      end
    end
  end
end
