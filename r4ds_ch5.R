library(tidyverse)

## 變異程度 ##
ggplot(diamonds) +
  geom_bar(aes(x = cut))
diamonds %>% count(cut)

ggplot(diamonds) +
  geom_histogram(aes(x = carat), binwidth = 0.5)
diamonds %>% count(cut_width(carat, 0.5))

smaller <- diamonds %>% filter(carat < 3)
ggplot(smaller, aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

ggplot(smaller, aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1)

ggplot(smaller, aes(x = carat)) +
  geom_histogram(binwidth = 0.01)

ggplot(faithful, aes(x = eruptions)) +
  geom_histogram(binwidth = 0.25)

ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = 0.5)
ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))
unusual <- diamonds %>%
  filter(y < 3 | y > 20) %>%
  arrange(y)
unusual

# exercise
# 1. x:長 y:寬 z:深
ggplot(diamonds) +
  geom_histogram(aes(x = x), binwidth = 0.5)
ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = 0.5)
ggplot(diamonds) +
  geom_histogram(aes(x = z), binwidth = 0.3)
?diamonds
# 2.
ggplot(diamonds) +
  geom_histogram(aes(x = price))
ggplot(diamonds) +
  geom_histogram(aes(x = price), binwidth = 50)
ggplot(diamonds) +
  geom_histogram(aes(x = price), binwidth = 50) +
  coord_cartesian(xlim = c(0, 2000), ylim = c(0, 1000))
# 3.
diamonds %>% filter(carat %in% c(0.99, 1)) %>% count(carat)
# 4.
ggplot(diamonds) +
  geom_histogram(aes(x = price), binwidth = 50) +
  coord_cartesian(xlim = c(0, 2000), ylim = c(0, 1000))
ggplot(diamonds) +
  geom_histogram(aes(x = price), binwidth = 50) +
  xlim(0, 2000) +
  ylim(0, 1000)     # 超出的bar會被整條刪除

## 缺失值 ##
# 若資料中有異常值, 可選擇捨棄整筆資料, 但不建議如此
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))
# 第二種方式, 將異常值以NA取代
diamonds2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
# 在ggplot2, 缺失值不會出現在圖表中, 但會發出警告
ggplot(diamonds2, aes(x = x, y = y)) +
  geom_point()
ggplot(diamonds2, aes(x = x, y = y)) +
  geom_point(na.rm = TRUE)
# 想了解帶有缺失值的觀察與帶有紀錄值的觀察有何不同
# 在nycflights13::flights中, dep_time的缺失值代表航班被取消
# 比較取消與未取消航班的預訂起飛時間(sched_dep_time)
nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>%
  ggplot(aes(sched_dep_time)) +
  geom_freqpoly(
    aes(color = cancelled),
    binwidth = 1/4
  ) # 這圖表並不是很好, 因為未取消比取消的航班多太多了

# exercise
# 1.
nycflights13::flights %>%
  ggplot(aes(x = dep_time)) +
  geom_histogram(binwidth = 80)
diamonds %>%    # NA被當成一類
  mutate(cut = if_else(runif(n()) < 0.1, 
                       NA_character_, 
                       as.character(cut))) %>%
  ggplot() +
  geom_bar(mapping = aes(x = cut))
# 2.
sum(c(1, 2, 3, NA))
sum(c(1, 2, 3, NA), na.rm = TRUE)
mean(c(1, 2, 3, NA))
mean(c(1, 2, 3, NA), na.rm = TRUE)


## 共變異程度 ##

# 類別變數 vs 連續變數
ggplot(diamonds, aes(x = price)) +
  geom_freqpoly(aes(color = cut), binwidth = 500)
ggplot(diamonds) +
  geom_bar(aes(x = cut))  # 總數差異過大
ggplot(diamonds, aes(x = price, y = ..density..)) +
  geom_freqpoly(aes(color = cut), binwidth = 500)
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

# reorder
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot()
ggplot(mpg) +       # 依中位數大小排序
  geom_boxplot(
    mapping = aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy
    )
  )
ggplot(mpg) + 
  geom_boxplot(
    mapping = aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy
    )
  ) +
  coord_flip()

# exercise
# 1.
nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>%
  ggplot(aes(x = sched_dep_time, y = ..density..)) +
  geom_freqpoly(
    aes(color = cancelled),
    binwidth = 1/2
  )
# 2.


