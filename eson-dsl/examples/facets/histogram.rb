Eson::Search::BaseQuery.new do
  facets do
    histogram :hist1, :field => :age, :interval => 100
  end
end
