{
  :filtered => {
    :query => {
       :term => {:tag => "something"}
    },
    :filter => {
      :not => {
        :filter => {
          :term => { "name.first" => "Florian"} 
        }
      }
    }
  }
}