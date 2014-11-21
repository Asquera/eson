module Eson
  module API
    module DSL
      class UrlBuilder
        attr_reader :base_path
        attr_reader :paths
        attr_reader :parts

        def initialize(&block)
          instance_eval(&block) if block_given?
        end

        def path(path)
          paths << path
        end

        def part(path, args = {})
          # parse to its own object, add validation?
          parts[path.to_s] = args
        end

        def paths
          @paths ||= []
        end

        def parts
          @parts ||= {}
        end

        def set_base_path(base_path)
          @base_path = base_path
        end
      end
    end
  end
end