require 'eson/dsl/url_builder'

module Eson
  module API
    module DSL
      module ClassMethods
        def url(&block)
          builder.instance_eval(&block)
        end

        def builder
          @builder
        end

        def request_methods(*list)
          define_method :request_methods do
            list.map { |e| e.to_sym }
          end
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
        builder = UrlBuilder.new
        base.instance_variable_set(:@builder, builder)
        base.send(:define_method, :url) do
          builder
        end
      end
    end
  end
end
