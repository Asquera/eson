module Eson
  class Error < StandardError
    attr_accessor :response
    
    def initialize(msg, response)
      super(response.body)
      
      self.response = response
    end
  end
  
  NotFoundError = Class.new(Error)
  IndexNotFoundError = Class.new(NotFoundError)
end
