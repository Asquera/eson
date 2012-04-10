{
  :query => {
    :match_all => {  }
  },
  :facets => {
    :tags => {
      :terms => {
        :field => :tags,
        :size => 10,
        :order => :term
      }
    }
  }
}
