module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # @note {include:MoreLikeThis#parameters}
      # @note {include:MoreLikeThis#source_param}
      # @note {include:MoreLikeThis#multi_index}
      # @note {include:MoreLikeThis#multi_types}
      module MoreLikeThis
        extend API

        # @!macro no_multi_index
        multi_index false

        # @!macro parameters
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

        # @!macro source_param
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
end
