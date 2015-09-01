#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://alpha.wallhaven.cc/random"))

image_links = page.css("a").select{|link| link['class'] == "preview"}
image_links.each{|link| puts link['href'] }