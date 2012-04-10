Eson::Search::BaseQuery.new do
  filter do
    geo_bounding_box "location" do
      top_left :lat => 40.73, :lon => -74.1
      bottom_right :lat => 40.717, :lon => -73.99
    end
  end
end