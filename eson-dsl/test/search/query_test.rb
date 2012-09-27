require './test/test_config'

context "Queries" do
  setup do
    create_index :index => "default"
  end
  
  context "#term" do
    query_name "test/search/queries/term"

    setup do
      example("queries/term")
    end
  end
  
  context "#term with parameters" do
    query_name "test/search/queries/term"

    setup do
      example("queries/term_with_parameters")
    end
  end

  context "#wildcard" do
    query_name "test/search/queries/wildcard"

    setup do
      example("queries/wildcard")
    end
  end

  context "#wildcard short style" do
    query_name "test/search/queries/wildcard_short"

    setup do
      example("queries/wildcard_short")
    end
  end

  unless ElasticSearch::Node.version > "0.19.4"
    context "#prefix" do
      query_name "test/search/queries/prefix"

      setup do
        example("queries/prefix")
      end
    end

    context "#prefix short style" do
      query_name "test/search/queries/prefix_short"

      setup do
        example("queries/prefix_short")
      end
    end
  end

  context "#match_all" do
    query_name "test/search/queries/match_all"

    setup do
      example("queries/match_all")
    end
  end

  context "#terms" do
    query_name "test/search/queries/terms"

    setup do
      example("queries/terms")
    end
  end

  context "#ids" do
    query_name "test/search/queries/ids"

    setup do
      example("queries/ids")
    end
  end

  context '#range query' do
    query_name "test/search/queries/range"

    setup do
      example("queries/range")
    end
  end

  context "#constant_score query" do
    query_name "test/search/queries/constant_score"

    setup do
      example("queries/constant_score")
    end
  end

  context "#constant_store query with filter" do
    query_name "test/search/queries/constant_score_filter"

    setup do
      example("queries/constant_score_with_filter")
    end
  end

  context "#text query" do
    query_name "test/search/queries/text"

    setup do
      example("queries/text")
    end
  end

  context "#match query" do
    query_name "test/search/queries/text"

    setup do
      example("queries/match")
    end
  end


  context "#bool query" do
    query_name "test/search/queries/bool"

    setup do
      example("queries/bool")
    end
  end

  context "#boosting query" do
    query_name "test/search/queries/boosting"

    setup do
      example("queries/boosting")
    end
  end

  context "#custom_score query" do
    query_name "test/search/queries/custom_score"

    setup do
      example("queries/custom_score")
    end
  end

  context "#dis_max query" do
    query_name "test/search/queries/dis_max"

    setup do
      example("queries/dis_max")
    end
  end

  context "#field query" do
    query_name "test/search/queries/field"

    setup do
      example("queries/field")
    end
  end

  context "#flt query" do
    query_name "test/search/queries/flt"

    setup do
      example("queries/flt")
    end

  end

  context "#flt_field query" do
    query_name "test/search/queries/flt_field"

    setup do
      example("queries/flt_field")
    end
  end

  context "#fuzzy simple query" do
    query_name "test/search/queries/fuzzy_simple"

    setup do
      example("queries/fuzzy")
    end
  end

  context "#fuzzy complex query" do
    query_name "test/search/queries/fuzzy_complex"

    setup do
      example("queries/fuzzy_complex")
    end

  end

  context "#has_child query" do
    query_name "test/search/queries/has_child"
    set :type, "blog_tag"
    set :index, "has_child_query"

    setup do
      example("queries/has_child")
    end
  end

  context "complex #has_child query" do
    query_name "test/search/queries/has_child_complex"
    set :type, "blog_tag"
    set :index, "has_child_query"

    setup do
      example("queries/has_child_complex")
    end
  end

  context "#mlt query" do
    query_name "test/search/queries/mlt"
    set :type, "bar"

    setup do
      example("queries/mlt")
    end
  end

  context "#mlt_field query" do
    query_name "test/search/queries/mlt_field"

    setup do
      example("queries/mlt_field")
    end
  end

  context "#query_string" do
    query_name "test/search/queries/query_string"

    setup do
      example("queries/query_string")
    end
  end

  context "#query_string" do
    query_name "test/search/queries/query_string_without_default_field"

    setup do
      example("queries/query_string_without_default_field")
    end
  end

  context "#query_string with multiple fields" do
    query_name "test/search/queries/query_string_with_multiple_fields"

    setup do
      example("queries/query_string_with_multiple_fields")
    end
  end

  context "#top_children query" do
    query_name "test/search/queries/top_children"

    setup do
      example("queries/top_children")
    end
  end

  context "query with filter and facets" do
    query_name "test/search/queries/filters_and_facets"

    setup do
      example("queries/filters_and_facets")
    end
  end

  context "nested queries" do
    query_name "test/search/queries/nested"

    setup do
      example("queries/nested")
    end
  end

  context "span_or query" do
    query_name "test/search/queries/span_or"

    setup do
      example("queries/span_or")
    end
  end

  context "span_near query" do
    query_name "test/search/queries/span_near"

    setup do
      example("queries/span_near")
    end
  end

  context "span_first query" do
    query_name "test/search/queries/span_first"

    setup do
      example("queries/span_first")
    end
  end

  context "span_not query" do
    query_name "test/search/queries/span_not"

    setup do
      example("queries/span_not")
    end
  end

  context "span_term query" do
    query_name "test/search/queries/span_term"

    setup do
      example("queries/span_term")
    end
  end

  if ElasticSearch::Node.version > "0.19.0"
    context "multi_match query" do
      query_name "test/search/queries/multi_match"

      setup do
        example("queries/multi_match")
      end
    end

    context "indices query" do
      query_name "test/search/queries/indices"

      setup do
        example("queries/indices")
      end
    end

    context "custom_boost_factor query" do
      query_name "test/search/queries/custom_boost_factor"

      setup do
        example("queries/custom_boost_factor")
      end
    end

    context "custom_filters_score query" do
      query_name "test/search/queries/custom_filters_score"

      setup do
        example("queries/custom_filters_score")
      end
    end
  end
end
