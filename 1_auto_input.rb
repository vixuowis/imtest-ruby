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

def test_file(target_file, out_file,type)
  File.new(out_file,'w')

  # 打开测试文档
  `osascript -e 'tell application "Finder"' -e 'open "Macintosh HD:Users:Simon:Playground:imtest-ruby:#{out_file.split("/").join(":")}"' -e 'end tell'`
#  `osascript -e 'tell application "Finder"' -e 'open "OS X:Users:appletest:Playground:imtest-ruby:#{out_file.split("/").join(":")}"' -e 'end tell'`

  sleep(1)

  cmd_start = "-e 'tell application \"System Events\"'"
  cmd_delay = "-e 'delay 0.1'"
  cmd_space = "-e 'keystroke space'"
  cmd_enter = "-e 'keystroke return'"
  cmd_stop = "-e 'keystroke \",\"'"
  cmd_save = "-e 'keystroke \"s\" using command down'"
  cmd_end = "-e 'end tell'"

  f = File.open(target_file)
  f.each_with_index do |l,index|
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

    # if index%50==0
    #   sleep(10)
    # end
    # break
    # if index==30
    #   break
    # end
  end
end

# EXPERIMENT 5
# test_file("dict/full_baiduhot_pinyin.txt","output/local_baidushort_out.txt",29)
# test_file("dict/full_baiduhot_pinyin.txt","output/qq_baidushort_out.txt",31)
# test_file("dict/full_baiduhot_pinyin.txt","output/sogou_baidushort_out.txt",31)

# test_file("dict/short_baiduhot_pinyin.txt","output/local_baidufull_out.txt",29)
# test_file("dict/short_baiduhot_pinyin.txt","output/qq_baidufull_out.txt",31)
# test_file("dict/short_baiduhot_pinyin.txt","output/sogou_baidufull_out.txt",31)

# test_file("dict/short_hot_pinyin.txt","output/local_hot_out.txt",29)
# test_file("dict/short_pinyin.txt","output/qq_short_out.txt",31)
# test_file("dict/short_hot_pinyin.txt","output/sogou_hot_out.txt",31)
# test_file("dict/sc_pinyin.txt","output/local_out.txt",29)