#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'uri'

START_LINK = "http://alpha.wallhaven.cc/search?categories=111&purity=100&resolutions=2560x1440&sorting=random&order=desc"

def desktops
  system_events.desktops
end

def set_desktop
  desktops.picture.set(wallpaper_path)
end

def download_images_from_array(images)
    images.each do |image|
        download_image(image)
    end
end

def download_image(image_link)
    name = URI(image_link).path.split('/').last
    agent = Mechanize.new
    agent.get(image_link).save "images/" + name
end

def create_full_link(image_link)
    image_link.slice!(0..1)
    image_link = "http://" + image_link
    image_link
end

def clear_images_folder
    Dir.foreach("images/") do |file|
        next if file.start_with?('.')
        filePath = File.join("images/", file)
        File.delete(filePath)
    end
end

def get_link_array
    links = Array.new

    main_page = Nokogiri::HTML(open(START_LINK))
    page_links = main_page.css("a").select{|link| link['class'] == "preview"}

    page_links.each do |thumb_link|
        href_page_link = thumb_link["href"]
        image_page = Nokogiri::HTML(open(href_page_link))
        image_link = image_page.css("img#wallpaper").attribute("src").value
        image_link = create_full_link(image_link)
        links.push(image_link)
    end
    links
end

# Main
clear_images_folder
download_images_from_array(get_link_array)
