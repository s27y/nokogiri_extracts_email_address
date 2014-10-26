require 'open-uri'
require 'nokogiri'
require 'pp'
require_relative 'io'

class WebpageParser
  attr_accessor :websites, :file_name, :list_of_hash, :non_tracked_word_list, :emails, :list_of_email_hash

  def initialize(fn)
    @file_name = fn
    @websites = load_websites_from_file
    @list_of_hash = Array.new  #=> store hashtable
    @list_of_email_hash = Array.new
    @non_tracked_word_list = read_non_tracked_words_to_list
    @emails = load_email_from_file
  end

  def load_websites_from_file
    p read_from_file(@file_name)
    read_from_file(@file_name)
  end

  def list_of_websites
    websites
  end

 def process_website_content
    @websites.each_with_index do |website,index|
      doc = Nokogiri::HTML(open(website.to_s))
      elements = doc.xpath("/html/body//*[not(self::script)]")
      #save_to_file(elements,"web.html")
      text_a = Array.new
      elements.each do |e|
        text_a <<  e.inner_text.gsub(/[\s]+/, " ").split(" ")
      end
      #save_to_file(text_a,"web.txt")
      text_a.flatten!
      # remove symbol at the beginning and end of the word
      text_a.each do |t|
        t.gsub!(/^\W|\W$/,"")
      end
      save_to_file(text_a.map(&:downcase),"#{index}_array.txt")
      h = array_to_sorted_hash_word_count(text_a)
      @list_of_hash << h
      save_to_file(h,"#{index}_hash.txt")
    end

  end
  def load_email_from_file
    arr = read_from_file("email_filenames.txt")
    arr.each do |e|
      e.chomp!
    end
    arr
  end

  def process_email_content
    @emails.each_with_index do |email_fn,index|
      arr = read_from_file(email_fn)
      puts arr.length

      text_a = Array.new
      arr.each do |e|

         text_a << e.gsub!(/[\s]+/, " ").split(" ")
        
      end     
      text_a.flatten!  

      # remove symbol at the beginning and end of the word
      text_a.each do |t|
        t.gsub!(/^\W|\W$/,"")
      end
      
      h = array_to_sorted_hash_word_count(text_a)
      @list_of_email_hash << h
    end
  end

  def get_email_address_from_hash_table(h)
    arr = Array.new
    h.each do |k,v|
      if(email_address?(k.to_s))
        arr << k.to_s
        puts "Email " +k.to_s 
      end
    end
    if(arr.length==0)
      #
      puts "No email address found in this website"
    end
    arr
  end

  def email_address?(str)
  #
  str =~ /\b(?!\.)*[\w]*[@|#][\w]*(\.com|\.ie|\.net)\b/
  end

  def top_occurred_word_in_percentage(numb,h)
    #
    top_number = 0
    arr = Array.new
    if(h.length!=0)
      #
      top_number = h.length * numb / 100
      arr = h.to_a
      arr.each_with_index.select {|x,index| (index>arr.length-top_number) && x[0].length >3}
    end
  end

  def top_occurred_word_in_number(numb,h)
    arr = Array.new
    if(h.length!=0)
      #
      arr = h.to_a

      new_arr = Array.new
      arr_count=-1
      while new_arr.length <= 10 do
        if(!(@non_tracked_word_list.include?arr[arr_count][0].downcase))
          new_arr << arr[arr_count]
        end
        arr_count-=1
      end
      new_arr
      #arr.each_with_index.select {|x,index| (index>arr.length-numb) && x[0].length >3}
    end
  end

  def website_keyword(numb,h)
    #
    arr = top_occurred_word_in_number(numb,h)
    puts "\nThis website's top #{numb} keywords are:\n"
    arr.each do |ele|
      puts "#{ele[0]}\voccurred #{ele[1]} times"
    end
  end

  def add_to_non_tracked_list(str)
    #
    add_line_to_file(str,"non_tracked_word.txt")
    @non_tracked_word_list = read_non_tracked_words_to_list
  end

  def read_non_tracked_words_to_list
    arr = read_from_file("non_tracked_word.txt")
    arr.each do |e|
      e.chomp!
    end
    arr
  end


  def array_to_sorted_hash_word_count(arr)
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



end
