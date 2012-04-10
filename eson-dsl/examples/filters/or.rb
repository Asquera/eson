Eson::Search::BaseQuery.new do
  query do
    term :tag => "something"
  end
  filter do |f|
    f.or do
      term "name.first" => "Felix"
      term "name.first" => "Florian"
    end
  end
end