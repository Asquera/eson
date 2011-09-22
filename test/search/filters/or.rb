{
  :query => {
    :filtered => {
      :query => {
         :term => {:tag => "something"}
      },
      :filter => {
        :or => [
          { :term => { "name.first" => "Felix"  } },
          { :term => { "name.first" => "Florian"} }
        ]
      }
    }
  }
}