{
  :query => {
    :constant_score => {
      :filter => {
        :term => {"user" => {:value => "kimchy"}}
      },
      :boost => 2.0
    }
  }
}