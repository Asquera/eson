require './test/test_config'

context "Filter" do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => ElasticSearch::HTTP, 
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::ResponseParser], 
                              :logger => 'test/test.log')
  end
  
  context "#exists" do
    query_name "test/search/filters/exists"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.constant_score do |c|
          c.filter do |f|
            f.exists :field => "user"
          end
        end
      end
      q
    end  
  end
  
  context "#missing" do
    query_name "test/search/filters/missing"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.constant_score do |c|
          c.filter do |f|
            f.missing :field => "user"
          end
        end
      end
      q
    end
    
  end
  
  context "#numeric_range" do
    query_name "test/search/filters/numeric_range"
    set :index, "foo"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.constant_score do |c|
          c.filter do |f|
            f.numeric_range :age, :from => 10, :to => 20
          end
        end
      end
      q
    end
    
  end
  
  context "#type" do
    query_name "test/search/filters/type"
  
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.filter do |f|
        f.type :my_type
      end
      q
    end
  end
  
  
  context '#range filter' do
    query_name "test/search/filters/range"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.filter do |f|
        f.range(:age, :from => 10, :to => 20)
      end
      q
    end
  
  end
  
  context '#match_all with #ids filter' do
    query_name "test/search/filters/ids"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all
      end
      q.filter do |f|
        f.ids("user", [1,2,3,4,5,6,7])
      end
      q
    end
  
  end
  
  
  context "#bool filter" do
    query_name "test/search/filters/bool"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all {}
      end
      
      q.filter do |f|
        options = {:minimum_number_should_match => 1,
                   :boost => 1.0}
      
        f.bool do |b|
          b.must do |m|
            m.term "user", :value => "kimchy"
          end
          b.must_not do |m|
            m.range :age, :from => 10, :to => 20
          end
          b.should do |s|
            s.term "tag", :value => "wow"
            s.term "tag", :value => "elasticsearch"
          end
        end
      end
      
      q
    end
  end
  
  context "#has_child filter" do
    query_name "test/search/filters/has_child"
    set :type, "blog"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.filter do |f|
        f.has_child :blog_tag do |c|
          c.query do |query|
            query.term :tag => "something"
          end
        end
      end
      q
    end
  end
  
  
  context "#and filter" do
    query_name "test/search/queries/and_filter"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.term :tag => "something"
      end
      q.filter do |fil|
        fil.and do |f|
          f.range :post_date, {:from => "2010-03-01", :to => "2010-04-01"}
          f.prefix "name.second" => "ba"
        end
      end
      q
    end
    
  end
  
  
  context "#or filter" do
    query_name "test/search/queries/or_filter"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.term :tag => "something"
      end
      q.filter do |fil|
        fil.or do |f|
          f.term "name.first" => "Felix"
          f.term "name.first" => "Florian"
        end
      end
      q
    end
  end
  
  context "#not filter" do
    query_name "test/search/queries/not_filter"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.term :tag => "something"
      end
      q.filter do |fil|
        fil.not do |f|
          f.term "name.first" => "Florian"
        end
      end
      q
    end
  end
  
  context "#filter_query" do
    query_name "test/search/queries/filter_query"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.constant_score do |c|
          c.filter do |fil|
            fil.fquery :_cache => true do |f|
              f.query_string "this AND that OR thus"
            end
          end
        end
      end
      q
    end
  
  end
end
  