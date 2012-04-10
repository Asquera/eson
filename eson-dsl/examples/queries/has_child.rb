Eson::Search::BaseQuery.new do
  query do
    has_child :blog_tag do
      query do
        term :tag => "something"
      end
    end
  end
end
