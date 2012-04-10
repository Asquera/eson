require './test/test_config'

context "Filter" do
  setup do
    create_index :index => "default"
  end

  context "#exists" do
    query_name "test/search/filters/exists"

    setup do
      example("filters/exists")
    end
  end

  context "#missing" do
    query_name "test/search/filters/missing"

    setup do
      example("filters/missing")
    end

  end

  context "#numeric_range" do
    query_name "test/search/filters/numeric_range"
    set :index, "foo"

    setup do
      example("filters/numeric_range")
    end

  end

  context "#type" do
    query_name "test/search/filters/type"

    setup do
      example("filters/type")
    end
  end

  context '#range filter' do
    query_name "test/search/filters/range"

    setup do
      example("filters/range")
    end
  end

  context '#match_all with #ids filter' do
    query_name "test/search/filters/ids"

    setup do
      example("filters/ids")
    end

  end

  context "#bool filter" do
    query_name "test/search/filters/bool"

    setup do
      example("filters/bool")
    end
  end

  context "#has_child filter" do
    query_name "test/search/filters/has_child"
    set :type, "blog"

    setup do
      example("filters/has_child")
    end
  end

  context "#and filter" do
    query_name "test/search/queries/and_filter"

    setup do
      example("filters/and")
    end
  end

  context "#and filter using default" do
     query_name "test/search/queries/and_filter"

     setup do
       example("filters/and_without_keyword")
     end
   end

  context "#or filter" do
    query_name "test/search/filter/or"

    setup do
      example("filters/or")
    end
  end

  context "#not filter" do
    query_name "test/search/filters/not"

    setup do
      example("filters/not")
    end
  end

  context "#filter_query" do
    query_name "test/search/queries/filter_query"

    setup do
      example("filters/fquery")
    end
  end

  context "#geo_bounding_box filter" do
    query_name "test/search/filters/geo_bounding_box_hash"
    set :index, "geo"
    set :type, "pin"

    setup do
      example("filters/geo_bounding_box")
    end
  end

  context "#geo_distance filter" do
    query_name "test/search/filters/geo_distance_hash"
    set :index, "geo"
    set :type, "pin"

    setup do
      example("filters/geo_distance")
    end
  end

  context "#geo_distance filter with block options" do
    query_name "test/search/filters/geo_distance_hash"
    set :index, "geo"
    set :type, "pin"

    setup do
      example("filters/geo_distance_alternate")
    end
  end

  context "#geo_distance_range filter" do
    query_name "test/search/filters/geo_distance_range_hash"
    set :index, "geo"
    set :type, "pin"

    setup do
      example("filters/geo_distance_range")
    end
  end

  context "#geo_polygon filter" do
    query_name "test/search/filters/geo_polygon_hash"
    set :index, "geo"
    set :type, "pin"

    setup do
      example("filters/geo_polygon")
    end
  end
end