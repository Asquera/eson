{
  :query => {
    :mlt => { 
      :fields => ["name.first", "name.last"],
      :like_text => "text like this one",
      :max_query_terms => 12
    }
  }
}