{
  :query => {
    :match_all => {  }
  },
  :facets => {
    :hist1 => {
      :histogram => {
        :field => :age,
        :interval => 100
      }
    }
  }
}
