# 1. gapminder 라이브러리

library(gapminder)
str(gapminder)
library(dplyr)
glimpse(gapminder)





# 2. baseR

gapminder[, c("country", "lifeExp")]

gapminder[, c("country", "lifeExp", "year")]

gapminder[1:15, ]

gapminder[gapminder$country == "Croatia", ]


gapminder[gapminder$country == "Croatia", "pop"]


gapminder[gapminder$country == "Croatia", c("lifeExp","pop")]

gapminder[gapminder$country == "Croatia" & gapminder$year > 1990, c("lifeExp","pop")]


apply(gapminder[gapminder$country == "Croatia", c("lifeExp","pop")], 2, mean)





# 3. dplyr 라이브러리

select(gapminder, country, year, lifeExp)

filter(gapminder, country == "Croatia")

summarise(gapminder, pop_avg = mean(pop))

summarise(group_by(gapminder, continent), pop_avg = mean(pop))
#e#
#
summarise(group_by(gapminder, continent, country), pop_avg = mean(pop))

gapminder %>% group_by(continent, country) %>% summarise(pop_avg = mean(pop))


temp1 = filter(gapminder, country == "Croatia")      
temp2 = select(temp1, country, year, lifeExp)  
temp3 = apply(temp2[ , c("lifeExp")], 2, mean)
temp3

gapminder %>% filter(country == "Croatia") %>% select(country, year, lifeExp) %>% summarise(lifeExp_avg = mean(lifeExp))




# 4. 방대한 데이터 요약

avocado <- read.csv("./DS/DS_data/avocado.csv")

str(avocado)
glimpse(avocado)

x_avg <- avocado %>% 
  group_by(region) %>% 
  summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice))
x_avg

x_avg <- avocado %>% 
  group_by(region, year) %>% 
  summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice))
x_avg

x_avg <- avocado %>% 
  group_by(region, year, type) %>% 
  summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice))
x_avg

install.packages("ggplot2")
library(ggplot2)

x_avg %>% filter(region != "TotalUS") %>% ggplot(aes(year, V_avg, col = type)) + geom_line() + facet_wrap(~region)
x_avg %>% 
  filter(region != "TotalUS") %>% 
  ggplot(aes(year, P_avg, col = type)) + geom_line() + facet_wrap(~region)

arrange(x_avg, desc(V_avg))

x_avg1 <- x_avg %>% filter(region != "TotalUS")
x_avg1

arrange(x_avg1, desc(V_avg))

x_avg1[x_avg1$V_avg == max(x_avg1$V_avg), ]

install.packages("lubridate")
library(lubridate)

x_avg <- avocado %>% 
    group_by(region, year, month(Date), type) %>% 
    summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice))
x_avg





# 5. 모델링을 위한 가공

wine <- read.table("./data/wine.data.txt", header = FALSE, sep = ",")
head(wine)

n = readLines("./data/wine.name.txt")
n

names(wine)[2:14] <- substr(n, 4, nchar(n))
names(wine)

head(wine)

train_set = sample_frac(wine, 0.6)
glimpse(train_set)

glimpse(wine)

test_set = setdiff(wine, train_set)
glimpse(test_set)





# 6. 데이터 구조 변경

elec_gen <- read.csv("./data/electricity_generation_per_person.csv", header = TRUE, sep = ",")
str(elec_gen)
glimpse(elec_gen)
names(elec_gen)

names(elec_gen)[2:33] = substr(names(elec_gen)[2:33], 2, nchar(names(elec_gen)[2:33]))
names(elec_gen)

elec_use = read.csv("./data/electricity_use_per_person.csv", header = TRUE, sep = ",")
names(elec_use)[2:56] = substr(names(elec_use)[2:56], 2, nchar(names(elec_use)[2:56]))
names(elec_use)

install.packages("tidyr")
library(tidyr)
elec_gen_df = gather(elec_gen, -country, key = "year", value = "ElectricityGeneration")
elec_use_df = gather(elec_use, -country, key = "year", value = "ElectricityUse")

elec_gen_use = merge(elec_gen_df, elec_use_df)




gapminder[gapminder$country == "Korea, Rep.", ]
filter(gapminder, country == "Korea, Rep.")
gapminder %>% filter(country == "Korea, Rep.")

gapminder[gapminder$country == "Korea, Rep.", c("year", "lifeExp")]
gapminder %>%
  filter(country == "Korea, Rep.") %>%
  select(year, lifeExp)

data <- gapminder %>%
  filter(country == "Korea, Rep.") %>%
  select(year, lifeExp)data

apply(data, 2, mean)
summarise(data, mean(lifeExp))
summarise(data, Life.Exp = mean(lifeExp))

gapminder %>%
  group_by(continent) %>%
  summarise(Pop.Avg = mean(pop))

gapminder %>%
  filter(country == "Korea, Rep.") %>%
  mutate(gdp = pop * gdpPercap) %>%
  arrange(desc(gdp))
