require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'titleize'

pageurl = ARGV[0]
page = Nokogiri::HTML(open(pageurl))

def extract_tag_name(url)
  url = url
  url = url.sub /(http:\/\/www.nme.com\/list\/\d*-?songs-about-)/, ''
  url = url.sub /-\d+/, ''
  url = url.sub /-/, ' '
  return url
end

def song_entry?(line)
  line.match(/(<h2>)\s(<span>)\d*-?(<\/span>)(\s).+(<\/h2>)/) || line.match(/(<h3>)\d*\.?.+(<\/h3>)/)
end

def song_title(line)
  title = line[/‘(.+?)’/]
  if title
#    title.sub /[\‘\’]/, ''
    title[1..-2]
  end
end

def song_artist(line)
  artist = line[/(–\s)[A-Za-z\s]+</]
  if artist
    artist[2..-2]
  end
end

def extract_song(line)
  song = line.to_s
  if song_entry?(song)
    title = song_title(song)
    artist = song_artist(song)
    if title && artist
      @output.puts "#{@tag},#{title},#{artist}"
    end
  end
end


@output = File.open("downloads/nme_songs.txt", "a")

@tag = extract_tag_name(pageurl).titleize

page.css('h2').each do |line|
  extract_song(line)
end

page.css('h3').each do |line|
  extract_song(line)
end
