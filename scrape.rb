#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require 'rubygems'
require 'nokogiri'
require 'open-uri'

START_LINK = "http://alpha.wallhaven.cc/random"

thumbnail_page = Nokogiri::HTML(open(START_LINK))
page_links = thumbnail_page.css("a").select{|link| link['class'] == "preview"}
page_links.each do |link|

  href_page_link = link["href"]
  # p "PAGE_LINK:" +  href_page_link

  image_page = Nokogiri::HTML(open(href_page_link))
  # p "PAGE DOC: " + image_page


  image_link = image_page.css("img#wallpaper").attribute("src").value
  p image_link

end
