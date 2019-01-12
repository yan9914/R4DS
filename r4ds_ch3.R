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




