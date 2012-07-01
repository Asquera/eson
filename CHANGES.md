# CHANGELOG

## 0.7.0 -> 0.8.0

* enhancement: eson-http can now use the 'update'-API
* api: the name of the 'params' method in Eson::Request collided with the 'params' parameter of the update API. Due to this problem, Eson::Request#params is renamed to Eson::Request#parameters.
* api: #scroll now has its own client method instead of piggy-backing on the #search request. It accepts `search_id` and `scroll` as parameters.
* api: deprecated `:default_index` setting. Use `:default_parameters => { :index => "...."}` instead
* api: added `:default_parameters` client option. Allows setting any number of parameters by default
* enhancement: added Client#with, which allows to temporarily set default parameters
* new subproject: eson-more, a collection if usage patterns for elasticsearch.