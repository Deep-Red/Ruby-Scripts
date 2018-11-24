arguments = ARGV

list = Dir.pwd + "/" + arguments[0]

File.readlines(list).each do |line|
  song = line.split(' | ')
  system("youtube-dl", "-o", song[0] + ".(ext)s", "-x", song[1])
end
