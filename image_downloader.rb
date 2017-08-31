# Downloads images linked in list at a
# specified url (first command line argument)
# to the current location
# Developed for AWDR5 - Very restricted in application,
# but should be easy to adapt / extend later.

require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Constant array of file extensions
EXTENSIONS = ["svg", "png", "jpg", "jpeg"]

# The webpage from which images should be downloaded
pageurl = ARGV[0]
page = Nokogiri::HTML(open(pageurl))


def download_image(url, dest)
  open(url) do |u|
    File.open(dest, 'wb') { |f| f.write(u.read) }
  end
end

page.css('li').each do |li|
  liext = li.to_s.split(".")[-1][0..-10]
  if EXTENSIONS.include? liext
    relative_target = li.child.attributes['href']
    absolute_target = URI.join( pageurl, relative_target ).to_s
    download_image( absolute_target, relative_target )
  end
end
