Eson::Search::BaseQuery.new do
  query do
    options = {
      :script => "_score * doc['my_numeric_field'].value / pow(param1, param2)",
      :params => {
        :param1 => 2,
        :param2 => 3.1
      }
    }

    custom_score options do
      query { match_all }
    end
  end
end