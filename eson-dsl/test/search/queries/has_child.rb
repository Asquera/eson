{
  :query => {
    :has_child => {
      :type => :blog_tag,
      :query => {
        :term => { :tag => "something" }
      }
    }
  }
}