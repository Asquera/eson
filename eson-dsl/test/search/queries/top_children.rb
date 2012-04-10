{
  :query => {
    :top_children => {
      :type => :blog_tag,
      :query => {
        :term => { :tag => "something" }
      },
      :score => "max"
    }
  }
}