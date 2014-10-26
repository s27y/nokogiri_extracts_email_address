require_relative 'webpage_parser'

class Main

  def initialize
    #
    @@web_parse = WebpageParser.new("websites.txt")
  end

  def run_app
    #
    @@web_parse.process_website_content
    menu
  end

  def add_non_tracked_word
    puts "Enter a word"
    word = gets
    word = word.chomp

    @@web_parse.add_to_non_tracked_list(word)
  end



  def menu
    welcomeText = "\nWelcome to The Website Parser System\n"
    puts welcomeText  #=> this will be displayed at the beginning of the app

    @@web_parse.list_of_hash.each_with_index do |h,index|
          @@web_parse.website_keyword(10,h)
    end

    num = 0
    begin
      puts "\n\n1 Show the list of websites
2 Show Top 10 keywords in the websites
3 Add keyword you don't want to track
4 Check if there is any email in the websites and save to file
5  
6 Exit\n"
      puts "Enter a number"
      num = gets
      num = num.chomp
      case
      when num == "1"
        @@web_parse.list_of_websites.each do |ws|
          puts ws
        end
      when num == "2"
        @@web_parse.list_of_hash.each_with_index do |h,index|
          @@web_parse.website_keyword(10,h)
        end
      when num == "3"
        self.add_non_tracked_word
      when num == "4"
        @@web_parse.list_of_hash.each do |h|
        if(@@web_parse.get_email_address_from_hash_table(h).length>0)
          save_to_file(@@web_parse.get_email_address_from_hash_table(h),"email.txt")
        end

        end
      when num == "5"
        
      when num == "6"
    abort("See you!")
      end
    end until num == "6"
  end
end


main = Main.new
main.run_app


menu