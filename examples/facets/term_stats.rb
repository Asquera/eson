Eson::Search::BaseQuery.new do
  query do
    match_all
  end
  facets do
    terms_stats :tag_price_stats, {:key_field => :tag,
                                   :value_field => :price }
  end
end
