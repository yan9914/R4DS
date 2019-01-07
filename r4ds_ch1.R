library(tidyverse)

## 第一步 ##
mpg
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy))

# exercise
# 1
ggplot(mpg)
# 2 
dim(mtcars)
# 3
?mpg
# 4
ggplot(mpg) + 
  geom_point(aes(x = hwy, y = cyl))
# 5
ggplot(mpg) + 
  geom_point(aes(x = class, y = drv))

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, color = class))

## Aesthetic Mappings (美學映射) ##

# exercise
# 1 因為color的內容跟變數無關,應放在aes外面
# 2
str(mpg)
# 3
ggplot(mpg) + 
  geom_point(aes(x = drv, y = hwy, color = displ))
ggplot(mpg) + 
  geom_point(aes(x = drv, y = hwy, size = displ))
ggplot(mpg) + 
  geom_point(aes(x = drv, y = hwy, shape = displ))
# 4
ggplot(mpg) + 
  geom_point(aes(x = drv, y = hwy, color = hwy, size = hwy))
# 5
?geom_point
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "skyblue", size = 5, stroke = 3)
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "skyblue", size = 5, stroke = 5)
# 6
ggplot(mpg) + 
  geom_point(aes(x = drv, y = hwy, color = displ < 5))

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)


## Facets (面向) ##

# exercise
# 1
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ cty)
# 2 沒有資料屬於那些(drv,cyl)的組合
ggplot(mpg) +
  geom_point(aes(x = drv, y = cyl))
# 3
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# 4
# color aesthetic 能展現資料整體
# faceting 是經過拆分的,較難看出整體
# 若資料量大, color aesthetic也會變比較亂
# 這時faceting是較好的選擇

# 5 
# nrow,ncol 分別控制面板的列數與行數
# facet_grid的列與行是由變數的levels而定

# 6 因為比較符合畫框的長寬比例,不會過度延展


## 幾何物件 (Geometric Objects) ##

ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv))
ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy))
ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy, group = drv))
ggplot(mpg) +
  geom_smooth(aes(x = displ, y = hwy, color = drv), show.legend = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == 'subcompact'),
    se = FALSE
  )

# exercise

# 1 geom_line(), geom_boxplot(), geom_histogram(), geom_area()
# 2
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
# 3 取消圖示, 為了排版
# 4 是否顯示信賴區間
# 5 相同, 一個是global mapping, 一個是重複的local mapping, 作用一樣
# 6
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 6, color = 'white') +
  geom_point(aes(color = drv), size = 3)

## 統計變換 (Statistical Transformations) ##

ggplot(diamonds) +      # 每個geom都有一個預設的stat
  geom_bar(aes(x = cut))
ggplot(diamonds) +      # 每個stat都有一個預設的geom
  stat_count(aes(x = cut))  

demo <- tribble(
  ~a, ~b,
  'bar_1', 20,
  'bar_2', 30,
  'bar_3', 40
)
ggplot(demo) +      # 原始資料就包含長條的高度, 此時要改用stat_identity
  geom_bar(aes(x = a, y = b), stat = 'identity')
ggplot(diamonds) +
  geom_bar(aes(x = cut, y = ..prop.., group = 1))

ggplot(diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# exercise
# 1
?stat_summary
?geom_pointrange

ggplot(diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = 'summary',
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# 2
ggplot(diamonds) +  # geom_col有要求y值, 使用stat_identity
  geom_col(aes(x = cut, y = depth))
?geom_col
ggplot(diamonds) +
  geom_bar(aes(x = cut, y = depth), stat = 'identity')

# 3 https://ggplot2.tidyverse.org/reference/

# 4
?stat_smooth
# y, ymin, ymax, se
# method, se, na.rm

# 5   
# 設定group = 1讓全部資料當作計算比例的分母
# 1也可替換成其他數字或字串 ex: 2,100,'a'
ggplot(diamonds) +
  geom_bar(aes(x = cut, y = ..prop..))
ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = color, y = ..prop..))

ggplot(diamonds) +
  geom_bar(aes(x = cut, y = ..prop.., group = 1))
ggplot(diamonds) +
  geom_bar(aes(x = cut, y = ..count../sum(..count..), fill = color)) +
  ylab('prop')
