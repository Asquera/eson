{
  :query => {
    :match_all => { }
  },
  :filter => {
    :ids => {
      :type => "user", :values => [1,2,3,4,5,6,7]
    }
  }
}