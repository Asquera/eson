{
  :query =>
  {
    :filtered => {
      :query => {:match_all => {}},
      :filter => {
        :bool => {
          :must => {
            :term => { "user" => {:value => "kimchy"} }
          },
          :must_not => {
            :range => {
              :age => {
                :from => 10,
                :to => 20
              }
            }
          },
          :should => [
            { :term => { "tag" => {:value => "wow"} } },
            { :term => { "tag" => {:value => "elasticsearch"} } }
          ]
        }
      }
    }
  }
}