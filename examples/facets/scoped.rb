Eson::Search::BaseQuery.new do
  q = nil
  query do
    q = nested :path => :obj1, :score_mode => "avg" do
      query do
        match_all
      end
      filters do
        range :age, :from => 10, :to => 20
      end
    end
  end

  facets do
    (histogram :hist1, :field => :age, :interval => 2).scope(q, 'my_scope')
  end
end
