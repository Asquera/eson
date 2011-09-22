{
  :query => {
    :boosting => {
      :positive => {
        :term => {
          :field1 => 1 # TODO: check if elasticsearch is correct here
        }
      },
      :negative => {
        :term => {
          :field1 => 2
        }
      },
      :negative_boost => 0.2
    }
  }
}