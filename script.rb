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
    body = page[/<p>(.*?)<\/p>/m, 1]
    parens = 0

    for i in 0..(body.length - 1)
        if body[i] == "("
            parens = parens + 1
        end
        
        if body[i] == ")"
            parens = parens - 1
        end

        if parens == 0 && body[i] == "<" && body[i+1] == "a"
            link = body[i..-1][/<a href="\/(.*?)"/m, 1]
            if links[link] != 1
                links[link] = 1
                return "https://en.wikipedia.org/" + link
            end
        end
    end
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
