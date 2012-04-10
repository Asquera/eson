{
  :query => {
    :constant_score => {
      :filter => {
        :fquery => {
          :query => {
            :query_string => {:query => "this AND that OR thus"}
          },
          :_cache => true
        }
      }
    }
  }
}