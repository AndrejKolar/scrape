#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'uri'

START_LINK = "http://alpha.wallhaven.cc/search?categories=111&purity=100&resolutions=2560x1440&sorting=random&order=desc"

def percentage(index, total)
  rez = (index.to_f / total.to_f * 100).round(0).to_s + "%"
  rez
end

def download_images_from_array(images)
    index = 1
    images.each do |image|
        print "\rDownloading #{percentage(index, images.count)}"
        download_image(image)
        index = index.next
    end
    print "\rDownloading  - DONE\n"
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
    print "Deleting"
    Dir.foreach("./images/") do |file|
        next if file.start_with?('.')
        filePath = File.join("./images/", file)
        File.delete(filePath)
    end
    print " - DONE\n"
end

def get_link_array
    links = Array.new

    main_page = Nokogiri::HTML(open(START_LINK))
    page_links = main_page.css("a").select{|link| link['class'] == "preview"}

    index = 1
    page_links.each do |thumb_link|
        href_page_link = thumb_link["href"]
        image_page = Nokogiri::HTML(open(href_page_link))
        image_link = image_page.css("img#wallpaper").attribute("src").value
        image_link = create_full_link(image_link)
        links.push(image_link)
        print "\rScraping #{percentage(index, page_links.count)}"
        index = index.next
    end
    print "\rScraping - DONE\n"
    links
end

# Main
clear_images_folder
download_images_from_array(get_link_array)
