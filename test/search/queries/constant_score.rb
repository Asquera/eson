{:query =>
  {
    :constant_score => {
      :query => {
        :term => {"user" => {:value => "kimchy"}}
      },
      :boost => 2.0
    }
  }
}