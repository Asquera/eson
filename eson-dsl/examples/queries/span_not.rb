Eson::Search::BaseQuery.new do
  query do
    span_not do
      include { span_term :field => "value1" }
      exclude { span_term :field => "value2" }
    end
  end
end
