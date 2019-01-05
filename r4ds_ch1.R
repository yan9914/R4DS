library(tidyverse)

# �Ĥ@�B
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

# Aesthetic Mappings (���ǬM�g)

# exercise
# 1 �]��color�����e���ܼƵL��,����baes�~��
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


# Facets (���V)

# exercise
# 1
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ cty)
# 2 �S������ݩ󨺨�(drv,cyl)���զX
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
# color aesthetic ��i�{��ƾ���
# faceting �O�g�L�����,�����ݥX����
# �Y��ƶq�j, color aesthetic�]�|�ܤ����
# �o��faceting�O���n�����

# 5 
# nrow,ncol ���O����O���C�ƻP���
# facet_grid���C�P��O���ܼƪ�levels�өw

# 6 �]������ŦX�e�ت����e���,���|�L�ש��i