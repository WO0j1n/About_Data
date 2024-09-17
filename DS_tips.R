tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)
head(tips, 10)

summary(tips)

library(dplyr)
library(ggplot2)

tips%>%ggplot(aes(size)) + geom_histogram()
tips%>%ggplot(aes(total_bill, tip)) + geom_point()
tips%>%ggplot(aes(total_bill, tip)) + geom_point(aes(col=day))
tips%>%ggplot(aes(total_bill, tip)) + geom_point(aes(col = day, pch = sex), size = 3)
