require './test/test_config'
context "Facets" do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => ElasticSearch::HTTP, 
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::ResponseParser], 
                              :logger => 'test/test.log')
  end
  
  context '#match_all with #terms facet' do
    set :query_name, "test/search/facets/terms"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.terms :tags, :field => :tags, :size => 10, :order => :term
      end
      q
    end
  
  end
  
  context '#match_all with #range facet' do
    set :query_name, "test/search/facets/range"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.range :range1, :age, { :to => 50 }, 
                               { :from => 20, :to => 70 },
                               { :from => 70, :to => 120 },
                               { :from => 150 }
      end
      q
    end
  end
  
  context '#match_all with #histogram facet' do
    set :query_name, "test/search/facets/histogram"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.histogram :hist1, :field => :age, :interval => 100
      end
      q
    end
  end
  
  
  context '#match_all with #date_histogram facet' do
    set :query_name, "test/search/facets/date_histogram"
    set :type, "date_hist"
    set :index, "date_hist"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.date_histogram :hist1, :field => :time, :interval => "day"
      end
      q
    end
  end
  
  context '#match_all with #query facet' do
    set :query_name, "test/search/facets/query"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.query :wow_facet do |w|
          w.term :tag => "wow"
        end
      end
      q
    end
  end
  
  context '#match_all with #filter facet' do
    set :query_name, "test/search/facets/tag_facet"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.filter :wow_facet do |fi|
          fi.term :tag => "wow"
        end
      end
      q
    end
  end
  
  context '#match_all with #statistical facet' do
    set :index, "statistical"
    set :query_name, "test/search/facets/statistical"
  
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.statistical :stat1, {:field => :field1}
      end
      q
    end
  end
  
  context '#match_all with #terms_stats facet' do
    set :query_name, "test/search/facets/terms_stats"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.facets do |f|
        f.terms_stats :tag_price_stats, {:key_field => :tag,
                                         :value_field => :price }
      end
      q
    end
    
  end
end
