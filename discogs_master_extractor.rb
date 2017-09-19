require 'nokogiri'

sourcefile = ARGV[0]
@output_file = File.open("out.txt", "w")

puts "reading in file #{sourcefile}; this could take a while..."
input = Nokogiri::XML::Reader(File.open(sourcefile))

i = 0
input.each do |node|
  if(node.name == "master" && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT)
    doc = Nokogiri::XML(node.outer_xml)

    artist_counter = 0
    genre_counter = 0
    style_counter = 0

    @output_file.puts(doc.xpath("//title")[0].inner_text.strip)

    doc.xpath("//artists/artist/name")[0..-1].each do |name|
      @output_file.print("|") unless artist_counter == 0
      @output_file.print("#{name.inner_text.strip}")
      artist_counter += 1
    end
    @output_file.puts


    doc.xpath("//genres/genre")[0..-1].each do |genre|
      @output_file.print("|") unless genre_counter == 0
      @output_file.print("#{genre.inner_text.strip}")
      genre_counter += 1
    end
    @output_file.puts

    doc.xpath("//styles/style")[0..-1].each do |style|
      @output_file.print("|") unless style_counter == 0
      @output_file.print("#{style.inner_text.strip}")
      style_counter += 1
    end
    @output_file.puts

    @output_file.puts(doc.xpath("//year")[0].inner_text.strip)

    i += 1
    puts i
  end
end
