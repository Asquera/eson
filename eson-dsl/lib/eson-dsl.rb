require 'multi_json'

require 'eson/modules/query_plugin'

require 'eson/search/parametrized'
require 'eson/search/node'
require 'eson/search/query'
require 'eson/search/queries'
require 'eson/search/filter'
require 'eson/search/filters'
require 'eson/search/facet'
require 'eson/search/facets'
require 'eson/search/query_group'
require 'eson/search/field_based'

require 'eson/search/base_query'
require 'eson/search/sub_query'
require 'eson/search/bool'
require 'eson/search/query_field'
require 'eson/search/term'
require 'eson/search/wildcard'
require 'eson/search/terms'
require 'eson/search/ids'
require 'eson/search/match_all'
require 'eson/search/range'
require 'eson/search/constant_score'
require 'eson/search/custom_score'
require 'eson/search/text'
require 'eson/search/boosting'
require 'eson/search/dis_max'
require 'eson/search/field'
require 'eson/search/fuzzy_like_this'
require 'eson/search/fuzzy_like_this_field'
require 'eson/search/more_like_this'
require 'eson/search/more_like_this_field'
require 'eson/search/fuzzy'
require 'eson/search/has_child'
require 'eson/search/top_children'
require 'eson/search/prefix'
require 'eson/search/query_string'
require 'eson/search/and'
require 'eson/search/or'
require 'eson/search/not'
require 'eson/search/numeric_range'
require 'eson/search/missing'
require 'eson/search/exists'
require 'eson/search/type'
require 'eson/search/fquery'
require 'eson/search/histogram'
require 'eson/search/date_histogram'
require 'eson/search/query_facet'
require 'eson/search/filter_facet'
require 'eson/search/statistical'
require 'eson/search/terms_stats'
require 'eson/search/nested'
require 'eson/search/span_term'
require 'eson/search/span_or'
require 'eson/search/span_near'
require 'eson/search/span_not'
require 'eson/search/span_first'
require 'eson/search/geo_bounding_box'
require 'eson/search/geo_distance'
require 'eson/search/geo_distance_range'
require 'eson/search/geo_polygon'
require 'eson/search/multi_match'
require 'eson/search/indices'

require 'compat'

##
# @!macro [new] eson.filter
#   @method $1
#   @overload $1
#     @yield the block containing further options and subfilters
#     @return [self] the generated facet
#     Generates a `$1` filter in a filter context.
#     {include:file:eson-dsl/examples/filters/$1.rb}

##
# @!macro [new] eson.query
#   @method $1
#   @overload $1
#     @yield the block containing further options and subqueries
#     @return [self] the generated facet
#     Generates a `$1` query in a query context.
#     {include:file:eson-dsl/examples/queries/$1.rb}

##
# @!macro [new] eson.facet
#   @method $1
#   @overload $1
#     @yield the block describing further options
#     @return [self] the generated facet
#     Generates a `$1` facet in a facets context.
#     {include:file:eson-dsl/examples/facets/$1.rb}
