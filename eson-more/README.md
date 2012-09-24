# eson-more. Handy functions for ElasticSearch

eson-more implements things you don't necessarily need, but which come in handy from time to time.

eson-more is in an experimental stage, so please don't rely on details.

## Usage

    require 'eson-more/all'

    c = Eson::HTTP::Client.new

    # print the whole index in chunks
    c.all(:index => "default") do |results|
      puts results
    end