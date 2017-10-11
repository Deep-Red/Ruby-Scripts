require 'nokogiri'

sourcefile = ARGV[0]
outfile = ARGV[1]

@output_file = File.open(outfile, "w")

puts "reading in file #{sourcefile}; this could take a while..."
input = Nokogiri::XML::Reader(File.open(sourcefile))

@element_paths = ["//tracklist/track/title", "//artists/artist/name", "//genres/genre", "//styles/style", "//released"]
i = 0

def extract_info(doc, element_path)
  doc.xpath(element_path)[0..-1].each_with_index do |element, index|
    @output_file.print("|") unless index == 0
    @output_file.print("#{element.inner_text.strip}")
  end
  @output_file.puts
end

input.each do |node|
  if(node.name == "release" && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT)
    doc = Nokogiri::XML(node.outer_xml)


    @element_paths.each do |element_path|
      extract_info(doc, element_path)
    end

    i += 1
    puts i
  end
end
