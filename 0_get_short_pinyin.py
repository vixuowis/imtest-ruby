#!/usr/bin/env python
# -*- coding:utf-8 -*-
from pinyin import PinYin

if __name__ == "__main__":
  test = PinYin()
  test.load_word()
  # string = "钓鱼岛是中国的"
  f = open("dict/hot_raw_list.txt",'r')
  f2 = open("dict/short_hot_pinyin.txt",'w')
  for i in f:
    # ch_str = i.split(" ")[1].strip()
    ch_str = i.strip()
    print "\""+ch_str+"\""
    short_arr = test.hanzi2pinyin(string=ch_str)
    short_str = ""
    for x in short_arr:
      try:
        print x
        short_str += x[0]
      except:
        continue

    print short_str
    f2.write(short_str+" "+ch_str+"\n")

  f2.close()
  # print "in: %s" % string
  # print "out: %s" % str(test.hanzi2pinyin(string=string))
  # print "out: %s" % test.hanzi2pinyin_split(string=string, split="-")

