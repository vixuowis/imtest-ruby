require 'hpricot'

def parsing_file(filename)
  html = open('temphtml/'+filename).read
  html.force_encoding("gbk")
  html.encode!("utf-8")

  doc = Hpricot(html)
  arr = []
  (doc/'a .list-title').each do |word|
    puts word.inner_text
    arr.push(word.inner_text)
  end

  return arr
end

def download_url(url,name)
  `curl '#{url}' -o 'temphtml/#{name}'`
end

def main
  arr = []

  # download_url("http://top.baidu.com/buzz?b=2&c=12","4")
  arr += parsing_file("4")

  # download_url("http://top.baidu.com/buzz?b=42&c=12","5")
  arr += parsing_file("5")

  # download_url("http://top.baidu.com/buzz?b=1&c=12","6")
  arr += parsing_file("6")

  # download_url("http://top.baidu.com/buzz?b=396&c=12","7")
  arr += parsing_file("7")

  puts arr.uniq.to_s

  f = File.open("dict/baidu_hot_raw_list.txt",'w')
  arr.uniq.each do |i|
    f.write(i+"\n")
  end
  f.close()
end

main()