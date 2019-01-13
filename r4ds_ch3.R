library(nycflights13)
library(tidyverse)

flights

## 以filter()過濾列資料 ##

filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))

sqrt(2)^2 == 2
1/49*49 == 1

near(sqrt(2)^2, 2)
near(1/49*49, 1)

filter(flights, month == 11 | month == 12)
filter(flights, month == 11|12)   # wrong
nov_dec <- filter(flights, month %in% c(11, 12))

# De Morgan's Law
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# exercise

# 1
filter(flights, arr_delay > 120)
filter(flights, dest == 'IAH' | dest == 'HOU')
filter(flights, carrier %in% c('AA', 'UA', 'DL'))
filter(flights, month %in% c(7, 8, 9))
filter(flights, arr_delay > 120, dep_delay <= 0)
filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)
filter(flights, dep_time == 2400, dep_time <= 600)

# 2
?between
filter(flights, between(month, 7, 9))

# 3
filter(flights, is.na(dep_time))  
# dep_delay, arr_time也是NA
# 應該是班機取消

# 4
NA^0        # for all numeric x, x^0 == 1
NA | TRUE   # for all logical or numeric x, (x | TRUE) == TRUE
FALSE & NA  # for all logical or numeric x, (FASLE & x) == FALSE 
NA*0        # 不等於0, 因為 Inf*0 在R裡無定義


## 以arrange()安排資料列 ##

arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

# NA永遠排最後
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

# exercise

# 1
arrange(flights, desc(is.na(dep_time)), dep_time)
# 2
arrange(flights, desc(arr_delay))
arrange(flights, dep_delay)
# 3
arrange(flights, desc(distance / air_time))
# 4
arrange(flights, desc(distance))
arrange(flights, distance)


## 以select()挑選資料欄 ##

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))

# 改名
select(flights, tail_num = tailnum)   # 不保留其他變數
rename(flights, tail_num = tailnum)   # 會保留其他變數

# 將變數移到最前面
select(flights, time_hour, air_time, everything())
# 將變數移到最後面
select(flights, everything(), time_hour, air_time)  # 這樣做是無效的
select(flights, -c(time_hour, air_time), time_hour, air_time)

select(flights, starts_with('dep'))   # 變數名稱以dep開頭
select(flights, ends_with('delay'))   # 變數名稱以delay結尾
select(flights, contains('time'))     # 變數名稱包含time

# 其他輔助函數
# matches('正規表達式')   選擇符合該正規表達式的變數
# num_range('x', 1:3)     挑選x1, x2, x3

# exercise

# 1
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with('dep'), starts_with('arr'))

# 2 呼叫過的不會重複呼叫
select(flights, starts_with('dep'), ends_with('delay'))

# 3
?one_of
vars <- c('year', 'month', 'day', 'dep_delay', 'arr_delay')
select(flights, one_of(vars))

# 4
select(flights, contains('TIME')) # 預設不分大小寫
?contains
select(flights, contains('TIME', ignore.case = FALSE))


## 以mutate()新增變數 ##
flights_sml <- select(flights,
                      year:day,
                      ends_with('delay'),
                      distance,
                      air_time)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time *60)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)  # 可以使用前面新建立的變數
# 只保留新變數
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)
# 常用於建立新變數的函數
# 加減乘除,邏輯比較
# %/%, %%
# log() ,log2(), log10()
(x <- 1:10)
lag(x)
lead(x)
cumsum(x)
cummean(x)

?ranking
(y <- c(1, 2, 2, NA, 3, 4))
rank(y)
min_rank(y) # 與rank()有何不同?
min_rank(desc(y))
dense_rank(y)
row_number(y)
percent_rank(y)
cume_dist(y)
ntile(y, 2)

# exercise

# 1
mutate(flights, 
       dep_time_mins = dep_time%/%100 * 60 + dep_time%%100,
       sched_dep_time_mins = sched_dep_time%/%100 * 60 + sched_dep_time%%100)
time2mins <- function(x) x%/%100 * 60 +x%%100
mutate(flights,
       dep_time_mins = time2mins(dep_time),
       sched_dep_time_mins = time2mins(sched_dep_time))
# 2
transmute(flights, air_time, arr_time - dep_time)
transmute(flights, 
          air_time, 
          time2mins(arr_time) - time2mins(dep_time))
# 跨越時區, 造成抵達時間減起飛時間不等於飛行時間
# 時間跨過午夜12點

# 3
select(flights, dep_time, sched_dep_time, dep_delay)
select(flights, dep_time, sched_dep_time, dep_delay) %>%
  mutate(time_diff = (time2mins(dep_time) - time2mins(sched_dep_time)),
         time_diff - dep_delay) %>%
  filter(time_diff - dep_delay != 0)
# 因為有過午夜

# 4
?min_rank
mutate(flights, delay_rank = min_rank(desc(dep_delay))) %>%
  filter(delay_rank <= 10) %>%
  arrange(delay_rank) %>%
  select(delay_rank, everything())

# 5
1:3 + 1:10 

# 6
?Trig
