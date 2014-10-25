require 'open-uri'
require 'nokogiri'
require 'pp'
require_relative 'io'

class WebpageParser
  attr_accessor :list_of_webpage

  def initialize(webpage_array)
    @list_of_webpage = webpage_array
    #
  end

  def search_email_address
    #
    @list_of_webpage.each do |webpage|
      #
    end
  end

  def email_address?(str)
    str =~ //
    # \b[a-zA-Z0-9]*[@|#][a-zA-Z0-9]*[.][com|ie|net]*\b
  end

  def remove_whitespace
    #

  end

end
# Return a hash map which using element of arr as key 
# and number of occurrences as value, and ascending sort by value of hash
#
def array_to_hash_word_count(arr)
  #
  h= Hash.new
  arr.each do |ele|
    if(ele.length > 1)
      if(h.has_key?(ele))
        h[ele]+=1
      else
        h[ele]=0
      end
    end

  end
  h=h.sort_by &:last
end

def remove_not_word_at_begin_and_end(str)
  str.gsub(/^\W|\W$/,"")
end

def email_address?(str)
  #
  str =~ /\b(?!\.)*[\w]*[@|#][\w]*(\.com|\.ie|\.net)\b/
end



# Get a Nokogiri::HTML::Document for the page we’re interested in...

doc = Nokogiri::HTML(open('https://www.csi.ucd.ie/users/mark-keane'))
  #http://en.wikipedia.org/wiki/Mark_Keane'))
#https://www.csi.ucd.ie/users/mark-keane
# Do funky things with it using Nokogiri::XML::Node methods...



elements = doc.xpath("/html/body//*[not(self::script)]")
save_to_file(elements,"web.html")
text_a = Array.new

elements.each do |e|
  text_a <<  e.inner_text.gsub(/[\s]+/, " ").split(" ")
end
save_to_file(text_a,"web.txt")

text_a.flatten!


text_a.each do |t|
  #
  t.gsub!(/^\W|\W$/,"")
end
save_to_file(text_a.map(&:downcase),"a.txt")

h = array_to_hash_word_count(text_a)

save_to_file(h,"h.txt")

h.each do |k,v|
  if(email_address?(k.to_s))
    puts "Email " +k.to_s 
  end
end



