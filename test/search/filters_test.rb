require './test/test_config'

context "Filter" do
  helper(:node) { Node::External.instance }

  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}",
                              :protocol => ElasticSearch::HTTP,
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::StatusHandler, ElasticSearch::ResponseParser],
                              :logger => 'test/test.log')
  end

  context "#exists" do
    query_name "test/search/filters/exists"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        constant_score do
          filter do
            exists :field => "user"
          end
        end
      end
      q
    end
  end

  #context "multiple filters" do
  #  query_name "test/search/filters/multiple"
  #  
  #end

  context "#missing" do
    query_name "test/search/filters/missing"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        constant_score do
          filter do
            missing :field => "user"
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
      q.query do
        constant_score do
          filter do
            numeric_range :age, :from => 10, :to => 20
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
      q.filter do
        type :my_type
      end
      q
    end
  end

  context '#range filter' do
    query_name "test/search/filters/range"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.filter do
        range :age, :from => 10, :to => 20
      end
      q
    end
  end

  context '#match_all with #ids filter' do
    query_name "test/search/filters/ids"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.filter do
        ids "user", [1,2,3,4,5,6,7]
      end
      q
    end

  end

  context "#bool filter" do
    query_name "test/search/filters/bool"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        match_all
      end

      q.filter do
        options = {:minimum_number_should_match => 1,
                   :boost => 1.0}

        bool do
          must do
            term "user", :value => "kimchy"
          end
          must_not do
            range :age, :from => 10, :to => 20
          end
          should do
            term "tag", :value => "wow"
            term "tag", :value => "elasticsearch"
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
      q.filter do
        has_child :blog_tag do
          query do
            term :tag => "something"
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
      q.query do
        term :tag => "something"
      end
      q.filter do |f|
        f.and do #and is a keyword, so it needs a receiver
          range :post_date, {:from => "2010-03-01", :to => "2010-04-01"}
          prefix "name.second" => "ba"
        end
      end
      q
    end
    
  end
  
  context "#or filter" do
    query_name "test/search/queries/or_filter"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        term :tag => "something"
      end
      q.filter do |f|
        f.or do
          term "name.first" => "Felix"
          term "name.first" => "Florian"
        end
      end
      q
    end
  end
  
  context "#not filter" do
    query_name "test/search/queries/not_filter"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        term :tag => "something"
      end
      q.filter do |f|
        f.not do
          term "name.first" => "Florian"
        end
      end
      q
    end
  end
  
  context "#filter_query" do
    query_name "test/search/queries/filter_query"
    
    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        constant_score do
          filter do
            fquery :_cache => true do
              query_string "this AND that OR thus"
            end
          end
        end
      end
      q
    end
  end
end
  