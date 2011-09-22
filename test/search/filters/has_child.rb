{ 
  :query => {
    :filtered => {
      :query => {:match_all => { }},
      :filter => {
        :has_child => {
          :type => :blog_tag,
          :query => {
            :term => { :tag => "something" }
          }
        }
      }
    }
  }
}