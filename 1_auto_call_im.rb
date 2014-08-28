require 'pathname'

def select_word(num,type)
  if num == 0
    return ""
  elsif num>=1
    str = ""
    (1..num).each do |n| 
      str += "-e 'keystroke (ASCII character #{type})' " #31 down 29 right
    end
    return str
  end
end

def test_file(target_file, out_file,type,from,to)
  File.new(out_file,'w')

  # 打开测试文档
  realdirpath = Pathname.new(__FILE__).realpath.to_s.split("/")[0..-2].join(":")
  drivename = "Macintosh HD" # OS X
  `osascript -e 'tell application "Finder"' -e 'open "#{drivename}#{realdirpath}:#{out_file.split("/").join(":")}"' -e 'end tell'`

  cmd_start = "-e 'tell application \"System Events\"'"
  cmd_delay = "-e 'delay 0.2'"
  cmd_space = "-e 'keystroke space'"
  cmd_enter = "-e 'keystroke return'"
  cmd_stop = "-e 'keystroke \",\"'"
  cmd_save = "-e 'keystroke \"s\" using command down'"
  cmd_end = "-e 'end tell'"

  f = File.open(target_file)
  f.each_with_index do |l,index|

    if !from.nil? and index<from.to_i
      next
    end

    if !to.nil? and index>to.to_i
      break
    end

    pinyin = l.split(" ")[0]
    simple_ch = l.split(" ")[1]
    puts "#{index} #{pinyin} #{simple_ch}"

    (0..9).each do |n|
      select_candidate = select_word(n,type)
      print_number = ""
      if n==0
        print_number = "-e 'keystroke \"#{index}: \"'"
      end
      #执行，选择前10个词
      `osascript #{cmd_start} #{print_number} -e 'keystroke "#{pinyin}"' #{cmd_delay} #{select_candidate} #{cmd_space} #{cmd_delay} #{cmd_space} #{cmd_space} #{cmd_space} #{cmd_space} #{cmd_stop} #{cmd_save} #{cmd_end}`
    end

    `osascript #{cmd_start} #{cmd_enter} #{cmd_end}`

    puts "#{pinyin} #{simple_ch} Done."

    sleep(5)
  end
end

###################################

imtype = ARGV[1] # local / qq / sogou

input_file = ARGV[0].split("/")[-1]
output_file = "output/#{Time.now.to_i.to_s}_#{imtype}_#{input_file}"
from = ARGV[2] rescue ""
to = ARGV[3] rescue ""

puts "input: #{ARGV[0]}"
puts "output: #{output_file}"
puts "im type: #{imtype}"
puts "[from,to]: [#{from},#{to}]"

i=7
while i>0
  puts "#{i}s left."
  i-=1
  sleep(1)
end

if imtype == "local"
  test_file(ARGV[0],output_file,29,from,to)
elsif imtype == "qq"
  test_file(ARGV[0],output_file,31,from,to)
elsif imtype == "sogou"
  test_file(ARGV[0],output_file,31,from,to)
else
  puts "You Got Nothing."
end

## EXPERIMENT 6
# test_file("dict/short_integrate_raw.txt","output/local_integrate_short_out.txt",29)
# test_file("dict/short_integrate_raw.txt","output/qq_integrate_short_out.txt",31)
# test_file("dict/short_integrate_raw.txt","output/sogou_integrate_short_out.txt",31)

# test_file("dict/full_integrate_raw.txt","output/local_integrate_full_out.txt",29)
# test_file("dict/full_integrate_raw.txt","output/qq_integrate_full_out.txt",31)
# test_file("dict/full_integrate_raw.txt","output/sogou_integrate_full_out.txt",31)
