# CHANGELOG

## 0.7.0 -> 0.8.0

* enhancement: eson-http can now use the 'update'-API
* api: the name of the 'params' method in Eson::Request collided with the 'params' parameter of the update API. Due to this problem, Eson::Request#params is renamed to Eson::Request#parameters. 