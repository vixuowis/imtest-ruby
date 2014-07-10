#!/usr/bin/env python
# -*- coding:utf-8 -*-
from pinyin import PinYin

if __name__ == "__main__":
  test = PinYin()
  test.load_word()
  # string = "钓鱼岛是中国的"
  f = open("dict/sc_pinyin.txt",'r')
  f2 = open("dict/short_pinyin.txt",'w')
  for i in f:
    ch_str = i.split(" ")[1].strip()
    print "\""+ch_str+"\""
    short_arr = test.hanzi2pinyin(string=ch_str)
    short_str = ""
    for x in short_arr:
      # print x
      short_str += x[0]
    print short_str
    f2.write(short_str+" "+ch_str+"\n")
  # print "in: %s" % string
  # print "out: %s" % str(test.hanzi2pinyin(string=string))
  # print "out: %s" % test.hanzi2pinyin_split(string=string, split="-")
