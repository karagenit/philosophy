#!/usr/bin/env ruby

require 'net/http'
require 'uri'

def get_page(url) 
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        return http.get(uri.path).body
    end
end

puts "Enter the starting page name:"
startpage = gets.chomp
endpage = "Philosophy"

puts get_page("https://en.wikipedia.org/wiki/#{startpage}")
