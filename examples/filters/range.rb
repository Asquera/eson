Eson::Search::BaseQuery.new do
  filter do
    range :age, :from => 10, :to => 20
  end
end
