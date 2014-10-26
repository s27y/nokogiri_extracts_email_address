def save_to_file(str,file_name)
  File.open(file_name, "w") do |f|
    f <<str
  end
  puts "Saved #{file_name}"
end

def read_from_file(file_name)
  arr = Array.new
  File.open(file_name, "r") do |aFile|
    aFile.each_line do |line|
      arr << line
    puts line
  end
  end
  puts arr.length.to_s
  arr
end