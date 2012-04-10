Eson::Search::BaseQuery.new do
  facets do
    query :wow_facet do
      term :tag => "wow"
    end
  end
end
