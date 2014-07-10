
def parsing(filename)
  arr = []

  File.open(filename).each do |l|
    puts l
    
    if l[0..3] == "2014"
      next
    end

    if l[0..1] == "10"
      arr.push(l[2..-1].strip)
      next
    end

    arr.push(l[1..-1].strip)
  end

  return arr 
end


# download not work
# (1..3).each do |i|
#   `curl -o 'temphtml/#{i}.html' 'http://top.sogou.com/hotword#{i}.html'`
# end

# parsing
arr = []

(1..3).each do |i|
  arr += parsing("temphtml/#{i}")
end

f = File.open("dict/hot_raw_list.txt",'w')
arr.uniq.each do |i|
  f.write(i+"\n")
end
f.close()

puts arr.uniq.to_s