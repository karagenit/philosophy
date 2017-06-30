#!/usr/bin/env ruby

require 'net/http'
require 'uri'

def get_page(url) 
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        return http.get(uri.path).body
    end
end

def get_link(page)
    return "https://en.wikipedia.org/wiki/Molecule"
end

def get_title(page)
    return "Molecule"
end

puts "Enter the starting page name:"
start_title = gets.chomp
end_title = "Philosophy"

page = nil
url = "https://en.wikipedia.org/wiki/#{start_title}"
title = nil

begin
    page = get_page(url)
    url = get_link(page)
    title = get_title(page)
    puts title
end until title == end_title
