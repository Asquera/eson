Eson::Search::BaseQuery.new do
  query do
    constant_score do
      filter do
        numeric_range :age, :from => 10, :to => 20
      end
    end
  end
end
