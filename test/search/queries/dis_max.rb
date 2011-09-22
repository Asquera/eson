{
  :query => {
    :dis_max => {
      :tie_breaker => 0.7,
      :queries => [
        {
          :term => { :age => 34 }
        },
        {
          :term => { :age => 35 }
        }
      ]
    }
  }
}