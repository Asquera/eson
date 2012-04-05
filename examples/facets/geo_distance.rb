Eson::Search::BaseQuery.new do
  facets do
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
end
