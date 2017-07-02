#!/usr/bin/env ruby

require 'net/http'
require 'uri'

def get_page(url) 
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        return http.get(uri.path).body
    end
end

def get_link(page, links)
    return page[/<p>([^\(\)]*?)(\([^\(\)]{0,}((\([^\(\)]{0,}\)){0,}[^\(\)]{0,}){0,}\)){0,}([^\(\)]*?)<a href="(.*?)"/m, 6]
    # TODO links list
    # TODO no Help:* links
end

def get_title(page)
    return page[/class="firstHeading" lang="en">(.*?)</m, 1]
end

links = {}

print "Enter the starting page name: "
start_title = gets.chomp
puts "---------------------"
end_title = "Philosophy"

page = nil
url = "https://en.wikipedia.org/wiki/#{start_title}"
title = nil
count = 0

begin
    page = get_page(url)
    url = get_link(page, links)
    title = get_title(page)
    puts title
    count += 1
end until title == end_title

puts "Traversed #{count} Pages"
