Eson::Search::BaseQuery.new do
  filter do
    geo_distance "location" do
      distance "200km"
      lat(40)
      lon(-70)
    end
  end
end
