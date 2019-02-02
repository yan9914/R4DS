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
# 1.
ggplot(diamonds) +
  geom_histogram(aes(x = x), binwidth = 0.5)
ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = 0.5)
ggplot(diamonds) +
  geom_histogram(aes(x = z), binwidth = 0.3)
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
