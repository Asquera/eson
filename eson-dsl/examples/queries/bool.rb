Eson::Search::BaseQuery.new do
  query do
    bool do
      must do
        term "user", :value => "kimchy"
      end
      must_not do
        range :age, :from => 10, :to => 20
      end
      should do
        term "tag", :value => "wow"
        term "tag", :value => "elasticsearch"
      end
    end
  end
end