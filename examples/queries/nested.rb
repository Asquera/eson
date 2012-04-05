Eson::Search::BaseQuery.new do
  query do
    nested :path => :obj1, :score_mode => "avg" do
      query do
        match_all
      end
      filters do
        exists :field => "user"
      end
    end
  end
end
