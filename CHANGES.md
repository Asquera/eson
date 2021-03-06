# CHANGELOG

## 0.7.0 -> 0.8.0

* enhancement: eson-http can now use the 'update'-API
* api: the name of the 'params' method in Eson::Request collided with the 'params' parameter of the update API. Due to this problem, Eson::Request#params is renamed to Eson::Request#parameters.
* api: #scroll now has its own client method instead of piggy-backing on the #search request. It accepts `search_id` and `scroll` as parameters.
* api: deprecated `:default_index` setting. Use `:default_parameters => { :index => "...."}` instead
* api: added `:default_parameters` client option. Allows setting any number of parameters by default
* enhancement: added Client#with, which allows to temporarily set default parameters
* new subproject: eson-more, a collection if usage patterns for elasticsearch.
* fix: scopes for facets were improperly assigned to the facets parameters
* documentation: a lot more
* enhancement: `logger` is now a property of the client option, not of the
protocol in use
* CI: 0.18.7, 0.19.12 and 0.20.1 are now the official testing versions
* CI: activated rbx-19mode for tests, now officially supported
* api: Add `lowercase_expanded_terms` to search API
* api: Add 0.19.9 `explain` API
* api: Add `validate` API
* api: Add custom_boost_factor query
* api: Add custom_filters_score query
* enhancement: eson now uses persistent http
* api: Auto-generation of filtered queries is removed
* api: Introduce a proper "filtered" query method
