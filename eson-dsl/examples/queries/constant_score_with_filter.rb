Eson::Search::BaseQuery.new do
  query do
    constant_score :boost => 2.0 do
      filter do
        term "user", :value => "kimchy"
      end
    end
  end
end
