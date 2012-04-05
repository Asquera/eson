Eson::Search::BaseQuery.new do
  query do
    term :tag => "something"
  end
  filter do |f|
    range :post_date, {:from => "2010-03-01", :to => "2010-04-01"}
    prefix "name.second" => "ba"
  end
end
