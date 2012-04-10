Eson::Search::BaseQuery.new do
  filter do
    geo_polygon :location do
      points [{:lat => 40, :lon => -70},
              {:lat => 30, :lon => -80}]

      point :lat => 20, :lon => -90
    end
  end
end