#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'mechanize'

START_LINK = "http://alpha.wallhaven.cc/random"

def download_image(image_link, index)
  agent = Mechanize.new
  agent.get(image_link).save "images/pic" + index.to_s + ".jpg"
end

def create_full_link(image_link)
  image_link.slice!(0..1)
  image_link = "http://" + image_link

  p image_link

  image_link
end

def clear_images_folder
  Dir.foreach("images/") do |file|
          next if file.start_with?('.')
          next unless file.end_with?(".jpg")

          # Delete
          filePath = File.join("images/", file)
          File.delete(filePath)
   end
end

def get_link_array

  links = Array.new

  main_page = Nokogiri::HTML(open(START_LINK))
  page_links = main_page.css("a").select{|link| link['class'] == "preview"}

  index = 0
  page_links.each do |thumb_link|
    href_page_link = thumb_link["href"]
    image_page = Nokogiri::HTML(open(href_page_link))
    image_link = image_page.css("img#wallpaper").attribute("src").value

    image_link = create_full_link(image_link)
    links.push(image_link)

    index = index.next
  end
end


#main

clear_images_folder
links = get_link_array

