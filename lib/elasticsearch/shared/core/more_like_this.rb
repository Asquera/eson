module ElasticSearch
  module Shared
    module MoreLikeThis
      include Search
      extend API
      
      parameters :type, :id
    end
  end
end