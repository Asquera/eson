module ElasticSearch
  class Response < Hash
    attr_accessor :raw
    attr_accessor :map
    
    def initialize(raw, map)
      self.raw = raw
      self.merge!(map)
    end
    
    def error
      map[:error]
    end
    
    def status
      raw.status
    end
  end
end