{
  :query => {
    :match_all => {  }
  },
  :facets => {
    :range1 => {
      :range => {
        :age => [
          { :to => 50 }, 
          { :from => 20, :to => 70 },
          { :from => 70, :to => 120 },
          { :from => 150 }
        ]
      }
    }
  }
}
