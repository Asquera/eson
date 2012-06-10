module Eson
  module Shared
    module MoreLikeThis
      extend API

      multi_index false

      parameters :id,
                 :type,
                 :mlt_fields,
                 :like_text,
                 :percent_terms_to_match,
                 :min_term_freq,
                 :max_query_terms,
                 :stop_words,
                 :min_doc_freq,
                 :max_doc_freq,
                 :min_word_len,
                 :max_word_len,
                 :boost_terms,
                 :boost,
                 :analyzer,
                 :scroll,
                 :scroll_id,
                 :timeout,
                 :from,
                 :size,
                 :sort,
                 :track_scores,
                 :highlight,
                 :fields,
                 :script_fields,
                 :indices_boost,
                 :explain,
                 :version,
                 :min_score

      source_param :timeout,
                   :from,
                   :size,
                   :sort,
                   :track_scores,
                   :highlight,
                   :fields,
                   :script_fields,
                   :indices_boost,
                   :explain,
                   :version,
                   :min_score
    end
  end
end