data()

# ctrl+L: Clear console panel

str(women)
?women

head(women)
head(women, 10)

tail(women)
tail(women, 10)

women[,1]
women[,2]
women[1,]
women[2,]

women$height
women[,1]
women$weight

getwd()

setwd('C:/DS2024/Week2')
getwd()

install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)
library(ggplot2)


str(iris)
head(iris, 10)
plot(iris)
pairs(iris)

plot(women)
pairs(women)  # Correlation with variables

plot(iris$Petal.Width, iris$Petal.Length, col = iris$Species)

tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)
head(tips, 10)


summary(tips)                


library(dplyr)
library(ggplot2)

# %>% : Pipe

tips%>%ggplot(aes(size)) + geom_histogram()                                           
tips%>%ggplot(aes(total_bill, tip)) + geom_point()                                    
tips%>%ggplot(aes(total_bill, tip)) + geom_point(aes(col = day))                      
tips%>%ggplot(aes(total_bill, tip)) + geom_point(aes(col = day, pch = sex, size = 3)) 


# 교수님 소스코드 따라하기
data()

str(women)
?women

head(women)
head(women, 10)

tail(women)
tail(women, 7)

women[,1]
women[,2]
women[1,]
women[2,]

women$height
women[,1]
women$weight

getwd()
#setwd()

#install.packages("dplyr")
#install.packages('ggplot2')

# library(dplyr)
# library(ggpolt2)

str(iris)
head(iris, 10)
plot(iris)
pairs(iris) # 각각의 columns의 상관관계를 분석함 -> 산점도로 그림

plot(women)
pairs(women)
plot(iris$Petal.Width, iris$Petal.Length, col = iris$Species) # 종류에 따른 색상과 마커 모양 다르게 하기는?


tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)
head(tips, 10)

tips %>% ggplot(aes(size)) + geom_histogram()
tips %>% ggplot(aes(total_bill, tip)) + geom_point()
tips %>% ggplot(aes(total_bill, tip, col = day)) + geom_point()
tips %>% ggplot(aes(total_bill, tip, col = day), size = 3) + geom_point()
# (aes(x, y, 개별마다 적용하고 싶은 설정), 전부 다 일정하게 고정하고 싶은 설정)
