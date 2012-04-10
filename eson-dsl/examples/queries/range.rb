Eson::Search::BaseQuery.new do
  query do
    range(:age, :from => 10, :to => 20)
  end
end
