require './test/test_config'

context "Queries" do
  helper(:node) { Node::External.instance }

  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}",
                              :protocol => ElasticSearch::HTTP,
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::StatusHandler, ElasticSearch::ResponseParser],
                              :logger => 'test/test.log')
  end

  setup do
    client.create_index :index => "default" rescue nil
    client.refresh
  end

  context "#term" do
    query_name "test/search/queries/term"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        term "user", :value => "kimchy", :boost => 2.0
      end
      q
    end
  end

  context "#wildcard" do
    query_name "test/search/queries/wildcard"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        wildcard "user", :value => "kim*y", :boost => 2.0
      end
      q
    end
  end

  context "#wildcard short style" do
    query_name "test/search/queries/wildcard_short"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        wildcard "user" => "kim*y"
      end
      q
    end
  end

  context "#prefix" do
    query_name "test/search/queries/prefix"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.prefix "user", :value => "sh", :boost => 2.0
      end
      q
    end
  end

  context "#prefix short style" do
    query_name "test/search/queries/prefix_short"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.prefix "user" => "sh"
      end
      q
    end
  end

  context "#match_all" do
    query_name "test/search/queries/match_all"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.match_all :boost => 2.0
      end
      q
    end
  end

  context "#terms" do
    query_name "test/search/queries/terms"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.terms({:tags => ['blue', 'pill'], :minimum_match => 2})
      end
      q
    end
  end

  context "#ids" do
    query_name "test/search/queries/ids"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.ids("user", [1,2,3,4,5,6,7])
      end
      q
    end
  end

  context '#range query' do
    query_name "test/search/queries/range"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.range(:age, :from => 10, :to => 20)
      end
      q
    end
  end

  context "#constant_score query" do
    query_name "test/search/queries/constant_score"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.constant_score :boost => 2.0 do |c|
          c.query do |que|
            que.term "user", :value => "kimchy"
          end
        end
      end
      q
    end
  end

  context "#constant_store query with filter" do
    query_name "test/search/queries/constant_score_filter"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.constant_score :boost => 2.0 do |c|
          c.filter do |f|
            f.term "user", :value => "kimchy"
          end
        end
      end
      q
    end
  end

  #TODO: please use elasticsearch 16.2 for this

  context "#text query" do
    query_name "test/search/queries/text"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.text :type => :phrase_prefix, :message => "this is a text"
      end
      q
    end
  end

  context "#bool query" do
    query_name "test/search/queries/bool"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        options = {:minimum_number_should_match => 1,
                   :boost => 1.0}

        query.bool do |b|
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


  context "#boosting query" do
    query_name "test/search/queries/boosting"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.boosting(:negative_boost => 0.2) do |b|
          b.positive do |p|
            p.term :field1 => 1
          end
          b.negative do |n|
            n.term :field1 => 2
          end
        end
      end
      q
    end
  end

  context "#custom_score query" do
    query_name "test/search/queries/custom_score"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.custom_score do |cq|
          cq.query { |qu| qu.match_all }
          cq.options = {
            :script => "_score * doc['my_numeric_field'].value / pow(param1, param2)",
            :params => {
              :param1 => 2,
              :param2 => 3.1
            }
          }
        end
      end
      q
    end
  end

  context "#dis_max query" do
    query_name "test/search/queries/dis_max"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.dis_max(:tie_breaker => 0.7) do |dm|
          dm.query do |qu|
            qu.term :age => 34
            qu.term :age => 35
          end
        end
      end
      q
    end
  end

  context "#field query" do
    query_name "test/search/queries/field"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        field "name.first" => "+something -else"
      end
      q
    end
  end

  context "#flt query" do
    query_name "test/search/queries/flt"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        flt :fields => ["name.first", "name.last"],
            :like_text => "text like this one",
            :max_query_terms => 12
      end
      q
    end

  end

  context "#flt_field query" do
    query_name "test/search/queries/flt_field"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        flt_field "name.first",
                  :like_text => "text like this one",
                  :max_query_terms => 12
      end
      q
    end
  end

  context "#fuzzy simple query" do
    query_name "test/search/queries/fuzzy_simple"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        fuzzy :user => "ki"
      end
      q
    end
  end

  context "#fuzzy complex query" do
    query_name "test/search/queries/fuzzy_complex"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        fuzzy :user, :value => "ki", :boost => 1.0
      end
      q
    end

  end

  #context "#has_child query" do
  #  query_name "test/search/queries/has_child"
  #  set :type, "blog_tag"
  #  set :index, "has_child_query"

  #  setup do
  #    q = ElasticSearch::Search::BaseQuery.new
  #    q.query do |query|
  #      query.has_child :blog_tag do |c|
  #        c.query do |qu|
  #          qu.term :tag => "something"
  #        end
  #      end
  #    end
  #    q
  #  end
  #end

  #context "complex #has_child query" do
  #  query_name "test/search/queries/has_child"
  #  set :type, "blog_tag"
  #  set :index, "has_child_query"

  #  setup do
  #    q = ElasticSearch::Search::BaseQuery.new
  #    q.query do |query|
  #      query.has_child :blog_tag do |c|
  #        c.query do |qu|
  #          qu.term :tag => "something"
  #        end
  #        c.filter do |qu|
  #          qu.term :tag => "other"
  #        end
  #      end
  #    end
  #    q
  #  end
  #end

  context "#mlt query" do
    query_name "test/search/queries/mlt"
    set :type, "bar"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do |query|
        query.mlt :fields => ["name.first", "name.last"],
                  :like_text => "text like this one",
                  :max_query_terms => 12
      end
      q
    end
  end

  context "#mlt_field query" do
    query_name "test/search/queries/mlt_field"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        mlt_field "name.first",
                  :like_text => "text like this one",
                  :max_query_terms => 12
      end
      q
    end
  end

  context "#query_string" do
    query_name "test/search/queries/query_string"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        query_string :default_field => "content",
                     :query => "this AND that OR thus"
      end
      q
    end
  end

  context "#query_string" do
    query_name "test/search/queries/query_string_without_default_field"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        query_string "this AND that OR thus"
      end
      q
    end
  end

  context "#query_string with multiple fields" do
    query_name "test/search/queries/query_string_with_multiple_fields"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        query_string :fields => ["content", "name^5"],
                     :query => "this AND that OR thus",
                     :use_dis_max => true
      end
      q
    end
  end

  context "#top_children query" do
    query_name "test/search/queries/top_children"

    setup do
      q = ElasticSearch::Search::BaseQuery.new
      q.query do
        top_children :blog_tag, :score => "max" do
          query { term :tag => "something" }
        end
      end
      q
    end
  end

  context "query with filter and facets" do
    query_name "test/search/queries/filters_and_facets"

    setup do
      ElasticSearch::Search::BaseQuery.new do
        query do
          match_all
        end
        filters do
          range :age, :from => 10, :to => 20
        end
        facets do
          histogram :hist1, :field => :age, :interval => 2
        end
      end
    end
  end

  context "nested queries" do
    query_name "test/search/queries/nested"

    setup do
      ElasticSearch::Search::BaseQuery.new do
        query do
          nested :path => :obj1, :score_mode => "avg" do
            query do
              match_all
            end
            filters do
              exists :field => "user"
            end
          end
        end
      end
    end
  end

  context "span_or query" do
    query_name "test/search/queries/span_or"

    setup do
      ElasticSearch::Search::BaseQuery.new do
        query do
          span_or do
            clauses do
              span_term :field => "value1"
              span_term :field => "value2"
              span_term :field => "value3"
            end
          end
        end
      end
    end
  end

  context "span_first query" do
    query_name "test/search/queries/span_first"

    setup do
      ElasticSearch::Search::BaseQuery.new do
        query do
          span_first :end => 3 do
            span_term :field => "value1"
          end
        end
      end
    end
  end
end
