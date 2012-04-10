Eson::Search::BaseQuery.new do
  facets do
    date_histogram :hist1, :field => :time, :interval => "day"
  end
end