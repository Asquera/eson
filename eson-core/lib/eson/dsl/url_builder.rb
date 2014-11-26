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
        attr_reader :source_params

        def initialize(&block)
          @params = ParamBuilder.new
          @parts  = PartBuilder.new
          instance_eval(&block) if block_given?
        end

        def set_base_path(path)
          @base_path = path
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

        def source_param(*params)
          @source_params ||= []
          params.each do |param|
            @source_params << param
          end
        end
      end
    end
  end
end
