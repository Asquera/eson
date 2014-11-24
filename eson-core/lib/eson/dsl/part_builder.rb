require 'virtus'

module Eson
  module API
    module DSL
      class PartBuilder
        def add_part(path, args = {})
          name = path.to_sym
          type = args.fetch(:type)

          @mod ||= Module.new do
            include Virtus.module
          end
          @mod.instance_eval do
            attribute name, type
          end
          extend @mod
        end
      end
    end
  end
end
