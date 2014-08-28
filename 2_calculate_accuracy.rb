
def read_out_file(filename)
  arr = {}
  File.open(filename).each do |l|
    puts l.split(/:|：/).to_s
    arr[l.split(/:|：/)[0].to_i] = l.split(/:|：/)[1].split(/，|,/).map{|x| x.strip}.delete_if{|a| a==""}
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

#############################

input_file = ARGV[0]
output_file = ARGV[1]
out_arr = read_out_file(output_file)
puts out_arr.to_s
# read ciku file

std1 =0 #首词 0
std2 =0 #一屏内 <5
std3 =0 #二屏内 <10

File.open(input_file).each_with_index do |l,index|
  puts "#{out_arr[index+824].to_s} compare with #{l}"
  elem_index = out_arr[index+824].index(l.strip()) rescue next

  puts "elem_index = #{elem_index}" if !elem_index.nil?
  puts "elem_index = nil" if elem_index.nil?
  
  std1,std2,std3 = count_accuracy(std1,std2,std3,elem_index)

  if index==out_arr.length-1
    break
  end
end

t = out_arr.length

puts "std1 = #{std1*1.0/t}"
puts "std2 = #{std2*1.0/t}"
puts "std3 = #{std3*1.0/t}"

#**************************
#       EXPERIMENT 6 - 2014/8/27
### data: 2749 combined hot words from baidu/sogou/tencent
## short: short_integrate_raw.txt
# local
# std1 = 0.7901054929065114
# std2 = 0.8526736995271008
# std3 = 0.85994907238996

# qq
# std1 = 0.1851582393597672
# std2 = 0.28082939250636596
# std3 = 0.3117497271735176

# sogou
# std1 = 0.6304110585667515
# std2 = 0.7926518734085122
# std3 = 0.8250272826482358

## full: full_integrate_raw.txt
# local
# std1 = 0.7901054929065114
# std2 = 0.8526736995271008
# std3 = 0.85994907238996

# qq
# std1 = 0.7238995998544926
# std2 = 0.7861040378319389
# std3 = 0.79483448526737

# sogou
# std1 = 0.7690069116042197
# std2 = 0.8170243724990905
# std3 = 0.8272098945070935

#**************************
#       EXPERIMENT 5
### data: 217 from baidu hot word
## short: short_baiduhot_pinyin.txt
# local
# std1 = 0.09216589861751152
# std2 = 0.15668202764976957
# std3 = 0.17050691244239632

# qq
# std1 = 0.2119815668202765
# std2 = 0.2857142857142857
# std3 = 0.3225806451612903

# sogou
# std1 = 0.2488479262672811
# std2 = 0.3548387096774194
# std3 = 0.41935483870967744

## full: full_baiduhot_pinyin.txt
# local
# std1 = 0.631336405529954
# std2 = 0.7327188940092166
# std3 = 0.7511520737327189

# qq
# std1 = 0.6820276497695853
# std2 = 0.7603686635944701
# std3 = 0.7649769585253456

# sogou
# std1 = 0.6866359447004609
# std2 = 0.7880184331797235
# std3 = 0.8110599078341014

#**************************
#       EXPERIMENT 4
### short pinyin
## hot words: 684 from sogou
# local
# std1 = 0.013157894736842105
# std2 = 0.014619883040935672
# std3 = 0.01608187134502924

# qq
# std1 = 0.0043859649122807015
# std2 = 0.014619883040935672
# std3 = 0.01608187134502924

# sogou
# std1 = 0.059941520467836254
# std2 = 0.0804093567251462
# std3 = 0.08625730994152046


#**************************
#       EXPERIMENT 3
### short pinyin
## big data scale: 1925 from tencent data
# local
# std1 = 0.24012474012474014
# std2 = 0.6902286902286903
# std3 = 0.7188149688149689

# qq
# std1 = 0.24415584415584415
# std2 = 0.3693506493506494
# std3 = 0.4025974025974026

# sogou
# std1 = 0.6763636363636364
# std2 = 0.8171428571428572
# std3 = 0.8597402597402597

#**************************
#       EXPERIMENT 2
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

#**************************
#       EXPERIMENT 1
### full pinyin
## small data scale：30 from tencent data
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
