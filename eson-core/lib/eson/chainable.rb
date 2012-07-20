# code from the datamapper project. See http://datamapper.org

module Eson
  # @api internal
  module Chainable
    # @api internal
    def chainable(&block)
      mod = Module.new(&block)
      include mod
      mod
    end

    # @api internal
    def extendable(&block)
      mod = Module.new(&block)
      extend mod
      mod
    end
  end
end