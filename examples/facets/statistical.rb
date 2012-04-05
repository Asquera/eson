Eson::Search::BaseQuery.new do
  facets do
    statistical :stat1, {:field => :field1}
  end
end
