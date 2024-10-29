# csv

ws <- read.csv("./data/water_2020.csv", skip = 3, header = T)
str(ws)





# 함수를 활용한 데이터 분석

mean(ws)
mean(ws$supply)
median(ws$supply)
var(ws$supply)
sd(ws$supply)

fivenum(ws$supply)
diff(fivenum(ws$supply))

boxplot(ws$supply)

winter <- ws[ ws$month == 1 | ws$month == 2, ]
winter <- ws[ ws$month == 1 | ws$month == 2 | ws$month == 12, ]
str(winter)

summer <- subset(ws, ws$month == 6 | ws$month == 7 | ws$month == 8)
str(summer)

mean(winter$supply)
mean(summer$supply)

median(winter$supply)
median(summer$supply)

boxplot(winter$supply)
boxplot(summer$supply)

boxplot(winter$supply, summer$supply)
boxplot(winter$supply, summer$supply, names = c("Winter", "Summer"), ylab = "Water Supply")





# 데이터 활용 기법

install.packages("tidyverse")
library(tidyverse)



# filter

ws <- read.csv("./data/water_2020.csv", skip = 3, header = T)
str(ws)

ws_Jan <- filter(ws, month == 1)
dim(ws_Jan)
head(ws_Jan)
tail(ws_Jan, 3)

ws_Jan_Feb <- filter(ws, month == 1 | month == 2)
dim(ws_Jan_Feb)
tail(ws_Jan_Feb, 3)

ws_Mar_WE <- filter(ws, month == 3 & (date %% 7 == 0 | date %% 7 == 1))
ws_Mar_WE



# select

select(ws_Mar_WE, 2:3)
select(ws_Mar_WE, -1)
select(ws_Mar_WE, c(date, supply))
select(ws_Mar_WE, -month)
select(ws_Mar_WE, date:supply)
select(ws_Mar_WE, -(date:supply))



# mutate

ws_Mar_WE <- mutate(ws_Mar_WE, supply2 = supply / 1000)
head(ws_Mar_WE, 3)

transmute(ws_Mar_WE, supply2 = supply / 1000)



# arrange

arrange(ws_Mar_WE, supply)
arrange(ws_Mar_WE, desc(supply))

arrange(ws, date, desc(month))



# summarise

summarise(ws_Mar_WE,
          n = n(),
          sum = sum(supply2),
          mean = sum / n,
          mean2 = mean(supply2),
          median = fivenum(supply2)[3],
          std.dev = sd(supply2))

ws_grp <- group_by(ws, month)
ws_grp
str(ws_grp)
summarise(ws_grp, days = n(), m = mean(supply), sd = sd(supply))



# 위 다섯가지 기법의 결합

ws_Spring <- filter(ws, month == 3 | month == 4 | month == 5)
ws_Spring_sp2 <- mutate(ws_Spring, supply2 = supply / 1000)
ws_Spring_sp2_ds <- select(ws_Spring_sp2, -supply)
ws_Spring_sp2_ds_grp <- group_by(ws_Spring_sp2_ds, month)
ws_Spring_summary <- summarise(ws_Spring_sp2_ds_grp,
                               n = n(),
                               m = mean(supply2),
                               sd = sd(supply2))
arrange(ws_Spring_summary, desc(month))

# 파이프 연산자의 활용
ws %>%
  filter(month == 3 | month == 4 | month == 5) %>%
  mutate(supply2 = supply / 1000) %>%
  select(-supply) %>%
  group_by(month) %>%
  summarise(n = n(),
            m = mean(supply2),
            sd = sd(supply2)) %>%
  arrange(desc(month))





# 데이터 정리 - 데이터 과학자의 소양

install.packages("readxl")
library(readxl)

# Wide to Long

ws_wide <- read_excel("./data/water_2020.xlsx")
ws_wide

ws_wide %>%
  pivot_longer(cols = 2:13)

ws_long <- pivot_longer(ws_wide, cols = 2:13)
ws_long





# 문자 데이터

year <- "2024"
month <- "9"
day <- "27"

nchar(year)
nchar(c(year, month))

date1 <- paste(year, month, day, sep = "-")
date1

date2 <- paste(year, 1:3, day, sep = "-")
date2

paste(year, 1:3, day, sep = "-", collapse = ",")

date3 <- paste0(year, month, day)
date3

substr(date3, 5, 6)

substr(date3, 5, nchar(date3))

substr(date3, 5, nchar(date3)) <- "813"
date3

strsplit(date1, split = "-")
strsplit(date2, split = "-")
simplify(strsplit(date2, split = "-"))



# 정규표현식
rno <- c("240927-3000118", "2206304012345")

str_detect(rno, "-")
str_extract(rno, "-")

str_detect(rno, "-[12345678]")
str_extract(rno, "-[12345678]")

str_detect(rno, "-[1-8]")
str_extract(rno, "-[1-8]")

titles <- c("Butter-방탄소년단", "Supernatural-NewJeans")

str_detect(titles, "-[가-힣]")
str_extract(titles, "-[가-힣]")
str_detect(titles, "[b-z]a")
str_extract(titles, "[b-z]a")
str_extract_all(titles, "[b-z]a")

# 이스케이프 문자
expression <- c("y = ax + b", "y = a^x")
str_detect(expression, "[+-*/]")

str_detect(expression, "[+\\-*/]")

idol <- c("aespa", "BTS", "IVE", "H.O.T.", "NewJeans", "Seventeen")
str_detect(idol, "[:alpha:][:alpha:]")

str_detect(idol, "[:alpha:]{2}")
str_detect(idol, "[:alpha:]{5,6}")
str_detect(idol, "[:alpha:]{2,}")

# 알파벳, 임의의 문자, 알파벳 패턴 여부 파악(2NE1이 예시가 되면 FALSE 출력)
str_detect(idol, "[:alpha:].[:alpha:]")

str_detect(idol, "[:punct:]?[:alpha:]")
str_detect(idol, "[:punct:]+[:alpha:]")
str_detect(idol, "[:punct:]*[:alpha:]")





# 날짜 및 시간

d1 <- as.Date("1970-01-01")

typeof(d1)
class(d1)
d1

t1 <- Sys.time()
t1
class(t1)
as.numeric(t1)

time.list <- as.POSIXlt(t1)
time.list
class(time.list)

attributes(time.list)

attr(time.list, "names")

time.list$wday

months(t1)
weekdays(t1)

unlist(time.list)

dt1 <- "2024년 6월 5일 13시 00분 11초"
dt2 <- "06/05/2024"
dt3 <- "2024 06 05"

as.Date(dt1)
as.Date(dt2)
as.Date(dt3)
# 저장한 시간 정보를 날짜형으로 변환하기 전에 데이터의 현태를 반드시 확인해야 함
# R의 날짜시간 표준 서식 - YYYY-mm-dd hh:mm:ss

dt4 <- "2024-06-05 13:00:11"
as.Date(dt4)

sdt1 <- strptime(dt1, format = "%Y년 %m월 %d일 %H시 %M분 %S초")

class(sdt1)
sdt1

sdt2 <- strptime(dt2, format = "%m/%d/%Y")
sdt3 <- strptime(dt3, format = "%Y %m %d")

class(sdt2)
sdt2
class(sdt3)

sdt3

t2 <- as.Date("2025-12-25")
t3 <- as.Date("2024-06-05")
diff <- t2 - t3
class(diff)
diff


t4 <- as.POSIXct("2025-12-25 00:00:00")
t5 <- as.POSIXlt("2024-06-05 12:00:00")
diff2 <- t4 - t5
class(diff2)
diff2

difftime(t4, t5, units = "secs")
difftime(t4, t5, units = "hours")
difftime(t4, t5, units = "weeks")

as.numeric(difftime(t4, t5, units = "secs"))
as.numeric(difftime(t4, t5, units = "hours"))

t6 <- as.Date("2024-01-01")
t7 <- as.Date("2024-06-05")
difftime(t7, t6, units = "weeks")
difftime(t7, t6, units = "weeks") <= 1
difftime(t7, t6, units = "weeks") <= 30
