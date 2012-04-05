Eson::Search::BaseQuery.new do
  query do
    boosting(:negative_boost => 0.2) do
      positive do
        term :field1 => 1
      end
      negative do
        term :field1 => 2
      end
    end
  end
end
