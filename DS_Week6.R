# 1. 데이터 시각화의 필요성

View(anscombe)

apply(anscombe, 2, mean)
apply(anscombe, 2, var)
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)

lm(anscombe$y1~anscombe$x1)
lm(anscombe$y2~anscombe$x2)
lm(anscombe$y3~anscombe$x3)
lm(anscombe$y4~anscombe$x4)

plot(anscombe$x1, anscombe$y1)
abline(lm(anscombe$y1~anscombe$x1), col = 'red')
plot(anscombe$x2, anscombe$y2)
abline(lm(anscombe$y2~anscombe$x2), col = 'red')
plot(anscombe$x3, anscombe$y3)
abline(lm(anscombe$y3~anscombe$x3), col = 'red')
plot(anscombe$x4, anscombe$y4)
abline(lm(anscombe$y4~anscombe$x4), col = 'red')

x_range <- c(4, 20)
y_range <- c(2, 14)
par(mfrow = c(2, 2))
plot(anscombe$x1, anscombe$y1, main = "Dataset 1", xlim = x_range, ylim = y_range)
abline(lm(anscombe$y1 ~ anscombe$x1), col = 'red')
plot(anscombe$x2, anscombe$y2, main = "Dataset 2", xlim = x_range, ylim = y_range)
abline(lm(anscombe$y2 ~ anscombe$x2), col = 'red')
plot(anscombe$x3, anscombe$y3, main = "Dataset 3", xlim = x_range, ylim = y_range)
abline(lm(anscombe$y3 ~ anscombe$x3), col = 'red')
plot(anscombe$x4, anscombe$y4, main = "Dataset 4", xlim = x_range, ylim = y_range)
abline(lm(anscombe$y4 ~ anscombe$x4), col = 'red')
par(mfrow = c(1, 1))





# 2. plot 함수 활용
library(gapminder)
library(dplyr)

y <- gapminder %>% group_by(year, continent) %>% summarize(c_pop = sum(pop)) 
glimpse(y)

par(mfrow = c(2, 2))
plot(y$year, y$c_pop, cex = 2)
plot(y$year, y$c_pop, cex = 2, col = y$continent)
plot(y$year, y$c_pop, cex = 2, col = y$continent, pch = c(1:5))
plot(y$year, y$c_pop, cex = 2, col = y$continent, pch = c(1:length(levels(y$continent))))
par(mfrow = c(1, 1))

plot(y$year, y$c_pop, cex = 2, col = y$continent, pch = c(1:length(levels(y$continent))))
legend("topleft", legend = 5, pch = c(1:5), col = c(1:5)) 
legend("topleft", legend = levels((y$continent)), pch = c(cex = 1.5, 1:length(levels(y$continent))), col = c(1:length(levels(y$continent))))





# 3. 시각화의 기본 기능 1
plot(gapminder$gdpPercap, 
     gapminder$lifeExp,
     pch = c(1:length(levels(gapminder$continent))),
     col = gapminder$continent)
legend("bottomright", 
       legend = levels((gapminder$continent)), 
       pch = c(1:length(levels(gapminder$continent))), 
       col = c(1:length(levels(y$continent))))

plot(log10(gapminder$gdpPercap), 
     gapminder$lifeExp, 
     col = gapminder$continent)
legend("bottomright", 
       legend  = levels((gapminder$continent)), 
       pch = c(1:length(levels(gapminder$continent))), 
       col = c(1:length(levels(y$continent))))



# ggplot2 라이브러리 활용

install.packages("ggplot2")
library(ggplot2)

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent)) + geom_point() + scale_x_log10()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent, size = pop)) + geom_point() + scale_x_log10()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent, size = pop)) + geom_point(alpha = 0.5) + scale_x_log10()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent, size = pop)) + geom_point(alpha = 0.5) + scale_x_log10() + facet_wrap(~year)





# 4. 시각화의 기본 기능 2

gapminder %>% 
  filter(year == 1952 & continent == "Asia") %>% 
  ggplot(aes(pop, reorder(country, pop))) + geom_bar(stat = "identity")

gapminder %>% 
  filter(year == 1952 & continent == "Asia") %>% 
  ggplot(aes(pop, reorder(country, pop))) + geom_bar(stat  = "identity") + scale_x_log10()

gapminder %>% 
  filter(country == "Korea, Rep.") %>% 
  ggplot(aes(year, lifeExp, col = country)) + geom_point() + geom_line()

gapminder %>% 
  ggplot(aes(x = year, y = lifeExp, col = continent)) + geom_point(alpha = 0.2) + geom_smooth()

x = filter(gapminder, year == 1952)
hist(x$lifeExp, main = "Histogram of lifeExp in 1952")

x %>% ggplot(aes(lifeExp)) + geom_histogram()

x %>% ggplot(aes(continent, lifeExp)) + geom_boxplot()

plot(log10(gapminder$gdpPercap), gapminder$lifeExp)





# 5. 시각화 도구: baseR

head(cars)

plot(cars, type = "p", main = "cars")
plot(cars, type = "l", main = "cars")
plot(cars, type = "b", main = "cars")
plot(cars, type = "h", main = "cars")

x <- gapminder %>% filter(year == 2007 & continent == "Asia") %>% 
  mutate(gdp  = gdpPercap*pop) %>% select(country, gdp) %>% arrange(desc(gdp)) %>% head()
pie(x$gdp, x$country)
barplot(x$gdp, names.arg = x$country)

par(mfrow = c(1, 2))
pie(x$gdp, x$country)
barplot(x$gdp, names.arg = x$country)
par(mfrow = c(1, 1))

matplot(iris[, 1:4], type = "l")
legend("topleft", names(iris)[1:4], lty = c(1, 2, 3, 4), col = c(1, 2, 3, 4))

hist(cars$speed)





# 6. 시각화 도구: ggplot2 라이브러리

gapminder %>% 
  filter(country == "Korea, Rep.") %>% 
  ggplot(aes(year, lifeExp, col = country)) + geom_point() + geom_line()

gapminder %>% filter(year == 2007) %>% ggplot(aes(lifeExp, col = continent)) + geom_histogram()
gapminder %>% filter(year == 2007) %>% ggplot(aes(lifeExp, col = continent)) + geom_histogram(position = "dodge")

gapminder %>% filter(year == 2007) %>% ggplot(aes(continent, lifeExp, col = continent)) + geom_boxplot()

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, col = continent)) + geom_point() + scale_x_log10()

gapminder %>% filter(continent == "Africa") %>% ggplot(aes(country, lifeExp)) + geom_bar(stat  =  "identity")
gapminder %>% filter(continent == "Africa") %>% ggplot(aes(country, lifeExp)) + geom_bar(stat  =  "identity") + coord_flip()





# 7. 시각화를 이용한 데이터 탐색

gapminder %>% 
  ggplot(aes(gdpPercap, lifeExp, col = continent)) + geom_point(alpha  =  0.2) + facet_wrap(~year) + scale_x_log10()

gapminder %>% 
  filter(country == "Kuwait"|country == "Saudi Arabia"|country == "Iraq"|country == "Iran"|country == "Korea, Rep."|country == "China"|country == "Japan") %>% 
  ggplot(aes(year, gdpPercap, col = country)) + geom_point() + geom_line()

gapminder %>% 
  filter(country == "Kuwait"|country == "Saudi Arabia"|country == "Iraq"|country == "Iran"|country == "Korea, Rep."|country == "China"|country == "Japan") %>% 
  ggplot(aes(year, pop, col=country)) + geom_point() + geom_line() + scale_y_log10()

gapminder %>% 
  filter(country == "Kuwait"|country == "Saudi Arabia"|country == "Iraq"|country == "Iran"|country == "Korea, Rep."|country == "China"|country == "Japan") %>% 
  mutate(gdp=gdpPercap*pop) %>% 
  ggplot(aes(year, gdp, col = country)) + geom_point() + geom_line() + scale_y_log10()
