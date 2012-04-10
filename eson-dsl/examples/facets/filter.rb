Eson::Search::BaseQuery.new do
  facets do
    filter :wow_facet do
      term :tag => "wow"
    end
  end
end
