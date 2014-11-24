require 'eson/dsl/url_builder'

module Eson
  module API
    module DSL
      module ClassMethods
        def url(url_path = nil, &block)
          define_method :url do
            @builder ||= UrlBuilder.new(url_path, &block)
          end
        end

        def methods(*list)
          define_method :methods do
            list.map { |e| e.to_sym }
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end
    end
  end
end
