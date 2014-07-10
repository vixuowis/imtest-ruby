
def read_out_file(filename)
  arr = {}  
  File.open(filename).each do |l|
    puts l.split("：").to_s
    arr[l.split("：")[0].to_i] = l.split("：")[1].split("，").map{|x| x.strip}.delete_if{|a| a==""}
  end
  return arr
end


def count_accuracy(std1,std2,std3,elem_index)
  return std1,std2,std3 if elem_index.nil?

  std1+=1 if elem_index == 0
  
  std2+=1 if elem_index < 5

  std3+=1 if elem_index <10

  return std1,std2,std3
end

ciku_file = "dict/sc_pinyin.txt"
# ciku_file = "dict/short_pinyin.txt"
# local_arr = read_out_file("output/local_out.txt")
# local_arr = read_out_file("output/qq_out.txt")
local_arr = read_out_file("output/sogou_short_out.txt")
puts local_arr.to_s
# read ciku file

std1 =0 #首词 0
std2 =0 #一屏内 <5
std3 =0 #二屏内 <10

File.open(ciku_file).each_with_index do |l,index|
  elem_index = local_arr[index].index(l.split(" ")[1]) rescue next

  puts "elem_index = #{elem_index}" if !elem_index.nil?
  puts "elem_index = nil" if elem_index.nil?
  
  std1,std2,std3 = count_accuracy(std1,std2,std3,elem_index)

  if index==local_arr.length-1
    break
  end
end

t = local_arr.length

puts "std1 = #{std1*1.0/t}"
puts "std2 = #{std2*1.0/t}"
puts "std3 = #{std3*1.0/t}"

### short pinyin
## big data scale: 1925 from tencent data

# sogou
# std1 = 0.6763636363636364
# std2 = 0.8171428571428572
# std3 = 0.8597402597402597

### full pinyin
## big data scale: 1925 from tencent data

# local
# std1 = 0.9215584415584416
# std2 = 0.9807792207792208
# std3 = 0.9880519480519481

# qq
# std1 = 0.8569942797711908
# std2 = 0.8975559022360895
# std3 = 0.9043161726469059

# sogou
# std1 = 0.8114285714285714
# std2 = 0.9179220779220779
# std3 = 0.931948051948052

## small data scale：30
# local_out
# std1 = 0.5806451612903226
# std2 = 0.7096774193548387
# std3 = 0.967741935483871

# sogou_out
# std1 = 0.8709677419354839
# std2 = 0.8709677419354839
# std3 = 0.8709677419354839

# qq_out
# std1 = 0.9032258064516129
# std2 = 0.9354838709677419
# std3 = 0.9354838709677419
