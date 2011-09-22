{
  :query => 
  {
    :filtered => {
      :query => {:match_all => {}},
      :filter => {
        :range => {
          :age => {
            :from => 10,
            :to => 20
          }
        }
      }
    }
  }
}