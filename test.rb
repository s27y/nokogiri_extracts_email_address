#!/usr/bin/ruby

phone = "2004-959-559 #This is Phone Number"


IO.foreach("web.txt") do |block| 
  block.gsub!(/\\t|\\n|\\r/, ""); 
  if block
    puts block+"\n"
  end
end




# Delete Ruby-style comments
phone = phone.sub!(/#.*$/, "")   
puts "Phone Num : #{phone}"

# Remove anything other than digits
phone = phone.gsub!(/\D/, "")    
puts "Phone Num : #{phone}"