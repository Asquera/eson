Eson::Search::BaseQuery.new do
  filter do
    geo_distance_range "location" do
      from "200km"
      to "400km"
      lat(40)
      lon(-70)
    end
  end
end