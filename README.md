Input Method Auto Test Doc
---

Input method auto evaluation, using ruby, python, and Apple script

## Getting Started

### STEP 1

First preparing phrases list like: 
> 古剑奇谭
> 世界杯
> 火影忍者
> 淘宝
> 优酷
> ...

And save it as `dict/xxx.txt`

Phrase has no more than 5 characters would be great. (Or local IM sometimes would crash)

### STEP 2

Run `0_phrase_to_pinyin.py` to get full and short pinyin attached by phrases:

> python 0_phrase_to_pinyin.py xxx.txt

`xxx.txt` must be under `dict/`

Then we got `full_xxx.txt` and `short_xxx.txt`, like:
> gujianqitan 古剑奇谭
> shijiebei 世界杯
> huoyingrenzhe 火影忍者
> taobao 淘宝
> youku 优酷
> kuaibo 快播
> ...

and
> gjqt 古剑奇谭
> sjb 世界杯
> hyrz 火影忍者
> tb 淘宝
> yk 优酷
> kb 快播
> ...

### STEP 3

Run `1_auto_call_im.rb` to open a blank document > call current input method > run until finished:

> ruby 1_auto_call_im.rb xxx.txt local short 0 1000

Parameters:

imput method: local/qq/sogou

pinyin type: short/full

[from,to]: optional

After that, we will get `output/timestamp_local_short_xxx.txt`

### STEP 4

Run `2_calcuate_accuracy.rb` to get evaluation result, by providing original list and its output file:

> ruby 2_calcuate_accuracy.rb xxx.txt timestamp_local_short_xxx.txt

We have 3 different standards: 

1. First word hit ratio
2. First 5 words hit ratio
3. First 10 words hit ratio
