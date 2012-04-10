Eson::Search::BaseQuery.new do
  query do
    span_term :user => "kimchy"
  end
end
