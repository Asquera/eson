require './test/test_config'
context "Facets" do
  context '#match_all with #terms facet' do
    set :query_name, "test/search/facets/terms"

    setup do
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        terms :tags, :field => :tags, :size => 10, :order => :term
      end
      q
    end

  end

  context '#match_all with #range facet' do
    set :query_name, "test/search/facets/range"

    setup do
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        range :range1, :age, { :to => 50 }, 
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
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        histogram :hist1, :field => :age, :interval => 100
      end
      q
    end
  end
  
  context '#match_all with #date_histogram facet' do
    set :query_name, "test/search/facets/date_histogram"
    set :type, "date_hist"
    set :index, "date_hist"
    
    setup do
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        date_histogram :hist1, :field => :time, :interval => "day"
      end
      q
    end
  end
  
  context '#match_all with #query facet' do
    set :query_name, "test/search/facets/query"
    
    setup do
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        query :wow_facet do
          term :tag => "wow"
        end
      end
      q
    end
  end
  
  context '#match_all with #filter facet' do
    set :query_name, "test/search/facets/tag_facet"
    
    setup do
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        filter :wow_facet do
          term :tag => "wow"
        end
      end
      q
    end
  end
  
  context '#match_all with #statistical facet' do
    set :index, "statistical"
    set :query_name, "test/search/facets/statistical"
  
    setup do
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        statistical :stat1, {:field => :field1}
      end
      q
    end
  end
  
  context '#nested scoped facet' do
    set :query_name, "test/search/facets/scoped"
    
    setup do
      Eson::Search::BaseQuery.new do
        q = nil
        query do
          q = nested :path => :obj1, :score_mode => "avg" do
            query do
              match_all
            end
            filters do
              range :age, :from => 10, :to => 20
            end
          end
        end

        facets do
          (histogram :hist1, :field => :age, :interval => 2).scope(q, 'my_scope')
        end
      end
    end
  end

  context '#match_all with #terms_stats facet' do
    set :query_name, "test/search/facets/terms_stats"
    
    setup do
      q = Eson::Search::BaseQuery.new
      q.query do
        match_all
      end
      q.facets do
        terms_stats :tag_price_stats, {:key_field => :tag,
                                       :value_field => :price }
      end
      q
    end

  end

  context '#match_all with #geo_distance facet' do
    set :query_name, "test/search/facets/geo_distance"
    
    setup do
      q = Eson::Search::BaseQuery.new
      q.facets do
        geo_distance :geo1, :location do
          lat(40)
          lon(-70)
          ranges [
              { :to => 10 },
              { :from => 10, :to => 20 },
              { :from => 20, :to => 100 },
              { :from => 100 }
          ]
        end
      end
      q
    end

  end


end
