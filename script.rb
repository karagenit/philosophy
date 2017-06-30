#!/usr/bin/env ruby

require 'net/http'
require 'uri'

def get_page(name) 
    uri = URI.parse("https://en.wikipedia.org")
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        return http.get("/wiki/#{name}").body
    end
end

puts get_page("Molecule")
