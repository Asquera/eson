{
  :query => {
    :match_all => {  }
  },
  :facets => {
    :stat1 => {
      :statistical => {
        :field => :field1
      }
    }
  }
}