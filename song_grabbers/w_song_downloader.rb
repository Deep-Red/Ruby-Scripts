require 'nokogiri'
require 'open-uri'
require 'titleize'

pageurl = ARGV[0]
page = Nokogiri::HTML(open(pageurl))

topic = pageurl.sub pageurl[/(https:\/\/en\.wikipedia\.org\/wiki\/)(List_of_s)?S?(ongs_about_)(or_referencing_)?/], ''

topic.gsub! "_", "-"

@output = File.open("../downloads/w-#{topic}.csv", "w")

@tag = topic.gsub "-", " "
@tag.titleize!

def is_song?(line)
  return false if line[0..3] != "<li>"
  return false unless line[/\s[Bb]y\s/]
  return true
end

def extract_line(line)
  line.gsub( %r{</?[^>]+?>}, '' )
end

def song_title(line)
  title = line[/"(.+?)"/]
  return nil unless title
  title.gsub! '"', ''
end

def song_artist(line)
  artist = line[/"\s[Bb]y\s(.*\s)[(\s\()($)(\n)]/]
  return nil unless artist
  artist.sub! '" By ', ''
  artist.sub! '" by ', ''
  artist.sub! /\s\($/, ''
end

page.css('li').each do |line|
  line = line.to_s
  if is_song?(line)
    line = extract_line(line)
    title = song_title(line)
    artist = song_artist(line)
    puts artist
    @output.puts"#{@tag},#{title},#{artist}" if artist && title
  end
end
