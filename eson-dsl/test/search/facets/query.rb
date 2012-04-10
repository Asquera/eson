{
  :query => {
    :match_all => {  }
  },
  :facets => {
    :wow_facet => {
      :query => {
        :term => {
          :tag => "wow"
        }
      }
    }
  }
}