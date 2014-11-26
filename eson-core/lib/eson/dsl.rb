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

        def request_methods(*list)
          define_method :request_methods do
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