releaserequire 'nokogiri'

sourcefile = ARGV[0]
outfile = ARGV[1]

@output_file = File.open(outfile, "w")

puts "reading in file #{sourcefile}; this could take a while..."
input = Nokogiri::XML::Reader(File.open(sourcefile))

i = 0
input.each do |node|
  if(node.name == "release" && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT)
    doc = Nokogiri::XML(node.outer_xml)

    doc.xpath("//tracklist/track/title")[0..-1].each_with_index do |title, index|
      @output_file.print("|") unless index == 0
      @output_file.print("#{name.inner_text.strip}")
    end
    @output_file.puts

    doc.xpath("//artists/artist/name")[0..-1].each_with_index do |name, index|
      @output_file.print("|") unless index == 0
      @output_file.print("#{name.inner_text.strip}")

    end
    @output_file.puts


    doc.xpath("//genres/genre")[0..-1].each_with_index do |genre, index|
      @output_file.print("|") unless index == 0
      @output_file.print("#{genre.inner_text.strip}")
    end
    @output_file.puts

    doc.xpath("//styles/style")[0..-1].each_with_index do |style, index|
      @output_file.print("|") unless index == 0
      @output_file.print("#{style.inner_text.strip}")
    end
    @output_file.puts

    @output_file.puts(doc.xpath("//released")[0].inner_text.strip)

    i += 1
    puts i
  end
end
