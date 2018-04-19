input = IO.readlines("./SampleSonglist.txt")
alphaartist = File.open("AlphaArtist.txt", "w")
alphasong = File.open("AlphaSong.txt", "w")

origarr = input
alphasong.puts(origarr.sort)

aaarray = origarr.map do |line|
  splits = line.split(" - ")
  splits[1].strip + " - " + splits[0]
end

alphaartist.puts(aaarray.sort)
