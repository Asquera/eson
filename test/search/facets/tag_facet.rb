{
  :query => {
    :match_all => {  }
  },
  :facets => {
    :wow_facet => {
      :filter => {
        :term => {
          :tag => "wow"
        }
      }
    }
  }
}