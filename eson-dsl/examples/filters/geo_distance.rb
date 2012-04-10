Eson::Search::BaseQuery.new do
  filter do
    geo_distance "location", :distance => "200km" do
      lat(40)
      lon(-70)
    end
  end
end
