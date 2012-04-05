Eson::Search::BaseQuery.new do
  query do
    span_first :end => 3 do
      span_term :field => "value1"
    end
  end
end
