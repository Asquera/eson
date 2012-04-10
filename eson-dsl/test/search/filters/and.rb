{
  :query => {
    :filtered => {
      :query => {
         :term => {:tag => "something"}
      },
      :filter => {
        :and => [
          { :range => { :post_date => {:from => "2010-03-01", :to => "2010-04-01"} } },
          { :prefix => { "name.second" => "ba"} }
        ]
      }
    }
  }
}
