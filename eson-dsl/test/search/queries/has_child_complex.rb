{
  :query => {
    :has_child => {
      :type => :blog_tag,
      :query => {
        :filtered => {
          :query => {
            :term => { :tag => "something" }
          },
          :filter => {
            :term => { :tag => "other" }
          }
        }
      }
    }
  }
}