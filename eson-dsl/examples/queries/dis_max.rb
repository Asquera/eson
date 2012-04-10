Eson::Search::BaseQuery.new do
  query do
    dis_max(:tie_breaker => 0.7) do
      query do
        term :age => 34
        term :age => 35
      end
    end
  end
end
