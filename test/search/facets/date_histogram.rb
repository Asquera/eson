{
  :query => {
    :match_all => {  }
  },
  :facets => {
    :hist1 => {
      :date_histogram => {
        :field => :time,
        :interval => "day"
      }
    }
  }
}
