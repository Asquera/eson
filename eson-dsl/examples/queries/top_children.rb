Eson::Search::BaseQuery.new do
  query do
    top_children :blog_tag, :score => "max" do
      query { term :tag => "something" }
    end
  end
end