require 'logger'

module ElasticSearch
  module HTTP
    def self.logger=(logger)
      if String === logger
        @logger = Logger.new(logger)
      else
        @logger = logger
      end
    end
    
    def self.logger
      @logger
    end
  end
end