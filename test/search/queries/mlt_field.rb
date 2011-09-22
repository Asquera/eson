{
  :query => {
    :mlt_field => { 
      "name.first" => {
        :like_text => "text like this one",
        :max_query_terms => 12
      }
    }
  }
}
