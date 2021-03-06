# scrape

Download images from [wallhaven.cc](http://alpha.wallhaven.cc)

Command line app that downloads random wallpapers in a specified size from wallhaven. App scrapes the site for the link, deletes old files and downloads new ones in the images folder. That folder can be used as a source for desktop backgrounds on OSX.

![image](https://cloud.githubusercontent.com/assets/1213228/9685496/016060a8-531f-11e5-9a13-3effb5f27d45.png)

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

## automate

An alias can be created to run the app quickly

Add to `.zshrc` or other shell equvalent

```
alias scrape="(cd /Users/andrejkolar/Projects/scrape/; ./scrape.rb)"
```

To run, in any shell

```bash
 scrape
```

## gems

[nokogiri](https://github.com/skorks/escort) gem is used to scrape image URLs from wallhaven.

[mechanize](https://github.com/JEG2/highline) gem is used to download images from URLs.

[open_uri_redirections](https://github.com/open-uri-redirections/open_uri_redirections) gem is to fix http => https redirections.
