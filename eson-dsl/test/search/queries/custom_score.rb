{
  :query => {
    :custom_score => {
      :query => {
        :match_all => { }
      },
      :params => {
        :param1 => 2,
        :param2 => 3.1
      },
      :script => "_score * doc['my_numeric_field'].value / pow(param1, param2)"
    }
  }
}