require_relative 'webpage_parser'

web_parse = WebpageParser.new("websites.txt")


web_parse.process_website_content

web_parse.list_of_hash.each do |h|
  web_parse.get_email_address_from_hash_table(h)
end

web_parse.list_of_hash.each_with_index do |h,index|
  web_parse.website_keyword(10,h)
end
