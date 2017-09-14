require 'open-uri'
require 'json'

SUBREDDIT = "musicthemetime"
SORT = "new"
TIME = "week"

@count = 0
@after = nil

if SORT == "top"
  @url = "http://www.reddit.com/r/#{SUBREDDIT}/#{SORT}/.json?sort=#{SORT}&t=#{TIME}"
  @output = File.open("../downloads/#{SUBREDDIT}-#{SORT}-#{TIME}.csv", "w")
else
  @url = "http://www.reddit.com/r/#{SUBREDDIT}/#{SORT}/.json?sort=#{SORT}"
  @output = File.open("../downloads/#{SUBREDDIT}-#{SORT}.csv", "w")
end


39.times do
  page = JSON.load(open(@url, {'User-Agent' => 'qazwsxedcujmik'}))

  page["data"]["children"].each do |child|
    if child["data"]["link_flair_text"] && child["data"]["title"]
      post_flair = child["data"]["link_flair_text"]
      post_title = child["data"]["title"]

      if post_title.match(/^[A-Za-z\s]+\s-\s[A-Za-z\s]+$/) && post_flair.match(/^[A-Za-z\s]+$/)
        separated = post_title.split(" - ")
        title = separated[1]
        artist = separated[0]
        @output.puts post_flair + "," + title + "," + artist
      end

    end
  end
  @count += 25
  @after = page["data"]["after"]

  if SORT == "top"
    @url = "http://www.reddit.com/r/#{SUBREDDIT}/#{SORT}/.json?sort=#{SORT}&t=#{TIME}&count=#{@count}&after=#{@after}"
  else
    @url = "http://www.reddit.com/r/#{SUBREDDIT}/#{SORT}/.json?sort=#{SORT}&count=#{@count}&after=#{@after}"
  end

end
