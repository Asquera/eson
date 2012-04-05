require './test/test_config'
context "Facets" do
  context '#match_all with #terms facet' do
    set :query_name, "test/search/facets/terms"

    setup do
      example("facets/terms")
    end

  end

  context '#match_all with #range facet' do
    set :query_name, "test/search/facets/range"

    setup do
      example("facets/range")
    end
  end

  context '#match_all with #histogram facet' do
    set :query_name, "test/search/facets/histogram"

    setup do
      example("facets/histogram")
    end
  end

  context '#match_all with #date_histogram facet' do
    set :query_name, "test/search/facets/date_histogram"
    set :type, "date_hist"
    set :index, "date_hist"

    setup do
      example("facets/date_histogram")
    end
  end

  context '#match_all with #query facet' do
    set :query_name, "test/search/facets/query"

    setup do
      example("facets/query")
    end
  end

  context '#match_all with #filter facet' do
    set :query_name, "test/search/facets/tag_facet"

    setup do
      example("facets/filter")
    end
  end

  context '#match_all with #statistical facet' do
    set :index, "statistical"
    set :query_name, "test/search/facets/statistical"

    setup do
      example("facets/statistical")
    end
  end

  context '#nested scoped facet' do
    set :query_name, "test/search/facets/scoped"

    setup do
      example("facets/scoped")
    end
  end

  context '#match_all with #terms_stats facet' do
    set :query_name, "test/search/facets/terms_stats"

    setup do
      example("facets/term_stats")
    end

  end

  context '#match_all with #geo_distance facet' do
    set :query_name, "test/search/facets/geo_distance"

    setup do
      example("facets/geo_distance")
    end

  end
end
