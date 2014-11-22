require 'eson/dsl/url_builder'

module Eson
  module API
    module DSL
      module ClassMethods
        def url(&block)
          define_method :url do
            @builder ||= UrlBuilder.new(&block)
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end
    end
  end
end
