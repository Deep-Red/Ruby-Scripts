# End the program if not supplied with exactly one file to work on
if ARGV.length != 1
  abort("Usage: shine_text_script.rb filename.ext")
end

# Extract filename and path
shinefile = ARGV[0]

# Open file
#afile = File.open(shinefile, "r+")
# Read file in as string
contents = File.read(shinefile)

contents.scan(/<div class="form-group"(.*?)type="text"(.*?)<\/div>/m) do |m|
  m = m.to_s
  bo    = contents.match(/(?<=ngModel=\")(.*)(?=\.)/).to_s
  fn    = contents.match(/(?<=ngModel=\")(.*)(?=\")/).to_s.split(".")[1]
  l     = fn.split("_").map(&:capitalize)*' '
  if bo == "customer"
    fn    = fn.split("-")*'_'
  end
  contents = contents.sub(/<div class="form-group"(.*?)type="text"(.*?)<\/div>/m, "<shine-text-field bind-object=\"#{bo}\" field_name=\"#{fn}\" label=\"#{l}\"></shine-text-field>")
  # Gives some idea of progress by printing out filesize
  puts contents.size
end

File.open(shinefile, "w"){|file| file.puts contents}
# Close file
#afile.close
