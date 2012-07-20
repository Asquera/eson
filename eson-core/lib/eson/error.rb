module Eson
  # Special error class for errors happening in the Eson context. In contrast
  # to StandardErrors, this error also holds the response associated with this
  # Error.
  class Error < StandardError
    attr_accessor :response
    
    #
    # @param [String] msg The error message
    # @param [Object] response The raw response object.
    def initialize(msg, response)
      super(response.body)
      
      self.response = response
    end
  end

  # Error class that indicates a missing document.
  NotFoundError = Class.new(Error)
  # Error class that indicates a missing index.
  IndexNotFoundError = Class.new(NotFoundError)
end
