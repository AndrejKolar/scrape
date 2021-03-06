#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'mechanize'
require 'uri'


START_LINK = "https://wallhaven.cc/search?categories=111&purity=100&resolutions=2560x1440%2C3840x2160&topRange=1M&sorting=toplist&order=desc"
IMAGE_FOLDER = "./images/"

# Print

def print_progres (proces_name, index, total)
    if index == total
        print "\r#{proces_name} #{arrow(1, 1)} DONE \n"
    else
        print "\r#{proces_name} #{arrow(index, total)} #{percentage(index, total) }"
    end
end

def percentage(index, total)
    rez = (index.to_f / total.to_f * 100).round(0).to_s + "%"
    rez
end

def arrow(index, total)
    lines = (index.to_f / total.to_f * 50).round(0)
    arrow = ("=" * lines) + "=>"
end

# Download

def download_images_from_array(images)
    index = 1
    images.each do |image|
        download_image(image)
        print_progres("Downloading", index, images.count)
        index = index.next
    end
end

def download_image(image_link)
    name = URI(image_link).path.split('/').last
    agent = Mechanize.new
    agent.get(image_link).save IMAGE_FOLDER + name
end

def clear_images_folder
    print "Deleting"
    Dir.foreach(IMAGE_FOLDER) do |file|
        next if file.start_with?('.')
        filePath = File.join(IMAGE_FOLDER, file)
        File.delete(filePath)
    end
    print " - DONE\n"
end


# Scrape

def get_link_array
    links = Array.new

    main_page = Nokogiri::HTML(open(START_LINK, :allow_redirections => :safe))
    page_links = main_page.css("a").select{|link| link['class'] == "preview"}

    index = 1
    page_links.each do |thumb_link|
        href_page_link = thumb_link["href"]
        image_page = Nokogiri::HTML(open(href_page_link, :allow_redirections => :safe))
        image_link = image_page.css("img#wallpaper").attribute("src").value
        links.push(image_link)
        print_progres("Scraping", index, page_links.count)
        index = index.next
        sleep(1)
    end
    links
end

# Main
clear_images_folder
download_images_from_array(get_link_array)
