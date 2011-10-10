module ElasticSearch
  class Error < StandardError
    attr_accessor :response
    
    def initialize(msg, response)
      super(msg)
      
      self.response = response
    end
  end
end