# scrape
Download images from [wallhaven.cc](http://alpha.wallhaven.cc)

Command line app that downloads random wallpapers in a specified size from wallhaven. App scrapes the site for the link, deletes old files and downloads new ones in the images folder. That folder can be used as a source for desktop backgrounds on OSX.

## installation
App uses Bundler to handle dependancies.

If Bundler is not installed:
```bash
 gem install bundler
```

Run in the app folder
```bash
 bundle install
```

## configuration
In `scrape.rb`
```ruby
START_LINK = "http://alpha.wallhaven.cc/search?categories=111&purity=100&resolutions=2560x1440&sorting=random&order=desc"
IMAGE_FOLDER = "./images/"
```
Starting link contains params for the wallpaper filter like categories, purity, resolutions, sorting and order. Image folder where images are store can be changed here.

## run
Enter
```bash
 ./scrape.rb
```

## gems
[nokogiri](https://github.com/skorks/escort) gem is used to scrape image URLs from wallhaven.
[mechanize](https://github.com/JEG2/highline) gem is to download images from URLs.
