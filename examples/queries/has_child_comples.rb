Eson::Search::BaseQuery.new do
  query do
    has_child :blog_tag do
      query do
        term :tag => "something"
      end
      filter do
        term :tag => "other"
      end
    end
  end
end