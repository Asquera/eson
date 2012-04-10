Eson::Search::BaseQuery.new do
  query do
    span_or do
      clauses do
        span_term :field => "value1"
        span_term :field => "value2"
        span_term :field => "value3"
      end
    end
  end
end
