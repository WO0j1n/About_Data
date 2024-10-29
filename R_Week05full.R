library(tidyverse)

# 1. 코드 덩어리 { ... }

test <- "Hi"
{
  print( test )
  cat( paste0( test, " { ... }"))
  cat( paste0( test, " { ... }\n"))
  cat( paste0( test, "\n"))
}

test2 <- 2
print(test2)
cat(test2)


# 2. 반복문

# 일일이 3단 구하기
3 * 2
3 * 3
3 * 8
3 * 9

# 반복문을 활용한 3단 구하기기
for( i in 2:9 ) {
  print( 3 * i )
}

for( i in 2:9 ) {
  print( paste(3, "X", i, "=", 3 * i ))
}


# 구구단 전체 출력
for( dan in 2:9 ) {
  for( times in 2:9 ) {
    print( dan * times )
  }
}


# 구구단 3단과 같은 연산의 경우 반복문보다 벡터 연산 추천
3 * (2:9)



# 3. 조건문
pops <- read.csv( "./R_data/data/pop_2018_2020.csv", fileEncoding = "CP949")
str(pops)
pops

names( pops )[1] <- c("sido")
names( pops )
pops

pops2 <- pops
pops2$sido_group <- "시"
pops2

# str_detect(): stringr 패키지 함수
# 문자열의 끝 $, 문자열의 시작 ^

for( i in 1:nrow(pops2) ) {
  if( str_detect( pops2$sido[i], "도$" ) ) {
    pops2$sido_group[i] <- "도"    
  }
}
pops2$sido_group
pops2

# 조건의 참/거짓에 따른 서로 다른 코드 덩어리 수행하기
for( i in 1:nrow(pops2) ) {
  if( str_detect( pops2$sido[i], "도$" ) ) {
    pops2$sido_group[i] <- "도지역"    
  } else {
    pops2$sido_group[i] <- "시지역"    
  }
}


for (i in 1:nrow(pops2)){
  pops2$sido_group[i] <- ifelse(str_detect(pops2$sido[i], "도$"), "도지역", "시지역")
}

pops2$sido_group
pops2


# else if() 를 이용하여 양자택일문 확장하기
score <- 45
if( score > 90 ) {
  grade <- "A"
} else if( score > 80 ) {
  grade <- "B"
} else if( score > 70 ) {
  grade <- "C"
} else if( score > 60 ) {
  grade <- "D"
} else {
  grade <- "F"
}
grade


# 벡터와 조건문 함수 ifelse()
x <- c( 1, 3, -2, 4)
x
x + 3


ifelse( c(1, 3, -2, 4) %% 2 == 0, "짝수", "홀수" )

pops3 <- pops
pops3$sido_group <- "시"
pops3
for( i in 1:nrow(pops3) ) {
  if( str_detect( pops3$sido[i], "도$" ) ) {
    pops3$sido_group[i] <- "도"    
  }
}
pops3
pops3 %>%
  mutate( sido_group2 = ifelse( str_detect( sido, "도$" ), "도지역", "시지역"))



mean( pops2$X2020 )
sd( pops2$X2020 )

mean_sd <- function( x, na = TRUE ) {
  m <- mean( x, na.rm = na )
  s <- sd( x, na.rm = na )
  result <- c( m, s )
  return( result )
}

mean_sd( pops2$X2019 )
mean_sd( pops2$X2020 )



myMean <- function(x, type="ari", na.rm=TRUE) {
  if( type == "ari" ) {
    result <- mean( x, na.rm = na.rm )
  } else if( type == "geo" ) {
    result <- exp( mean( log( x ), na.rm = na.rm ) )
  } 
  return( result )
}

x <- c(100, 200, 300, 400, 500)
myMean( x )

x <- c(2.0, 1.5, 1.33, 1.25)
myMean( x, type="geo" )



# 5. 실습

library( readxl )

ws_wide <- read_excel( "./data/water_2020.xlsx" )
ws_wide

ws_wide %>%
  pivot_longer( cols = 2:13 )

ws <- ws_wide %>%
  pivot_longer( cols = 2:13 ) %>%
  select(name, 구분, value)

ws_wide %>%
  pivot_longer( cols = 2:13 ) %>%
  select(name, 구분, value) %>%
  rename( 
    month = name,
    day = 구분,
    supply = value
  )

ws_wide %>%
  pivot_longer( cols = 2:13 ) %>%
  select(name, 구분, value) %>%
  rename( 
    month = name,
    day = 구분,
    supply = value
  ) %>%
  arrange( month, day )

# %02d: 2자리 숫자를 출력하되, 한자리 수 같은 경우는 앞에 0을 붙여라
ws_wide %>%
  pivot_longer( cols = 2:13 ) %>%
  select(name, 구분, value) %>%
  rename( 
    month = name,
    day = 구분,
    supply = value
  ) %>%
  mutate( day = sprintf("%02d", as.numeric(day) ) ) %>%
  arrange( month, day )


# sprintf() 함수 사용하기
int <- 3
dbl <- 123.4567
str <- "Hi"

sprintf("%s R!", str)
sprintf("%s %d!", str, int)
sprintf("%5.2f", dbl)
sprintf("%7s", str)
sprintf("%02d", int)


# csv 파일로 저장하기
ws_wide %>%
  pivot_longer( cols = 2:13 ) %>%
  select(name, 구분, value) %>%
  rename( 
    month = name,
    day = 구분,
    supply = value
  ) %>%
  mutate( day = sprintf("%02d", as.numeric(day) ) ) %>%
  arrange( month, day ) %>%
  write.csv( "./output/2020_water.csv", row.names=FALSE )



ws_wide %>%
  pivot_longer(cols = 2:13) %>%
  select(name, 구분, value) %>%
  rename(
    month = name,
    day = 구분, 
    supply = value
  ) %>%
  mutate(day = sprintf('%2d', as.numeric(day)))%>%
  arrange(month, day)


ws_wide %>%
  pivot_longer(cols = 2:14)%>%
  select(name, 구분, value)%>%
  rename(
    month = name,
    day = 구분,
    supply = value
  )%>%
  mutate(day = sprintf('%02d', as.numeric(day)))%>%
  arrange(desc(day))

for (i in 1:nrow(pops2{
  if(str_detect(pops2$sido, '도$')){
    pops2$sido_group <- '도지역'
  }
})
