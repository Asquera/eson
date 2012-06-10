module Eson
  module Search
    module Parametrized
      attr_accessor :args
      
      def initialize(args)
        self.args = args
      end
      
      def param(name)
        args[name] || (raise "Parameter #{name} not given")
      end
    end
  end
end