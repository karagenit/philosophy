#!/usr/bin/env ruby

require 'net/http'
require 'uri'

uri = URI.parse("https://en.wikipedia.org")

Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
    puts http.get("/wiki/Molecule").body
end
