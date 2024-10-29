# 1. 데이터 시각화

library( tidyverse )

anscombe
anscombe %>%
  select( ends_with( c("1", "2", "3", "4") ) )

anscombe %>%
  pivot_longer( 1:8 ) %>%
  group_by( name ) %>%
  summarise(
    mean = mean( value ),
    sd = sd( value )
  )

par( mfrow=c(2, 2) )
plot( anscombe$x1, anscombe$y1, main="X1, Y1", xlab="", ylab="", ylim=c(0, 15), xlim=c(4, 20) )
abline( lm(anscombe$y1 ~ anscombe$x1), col="red" )
plot( anscombe$x2, anscombe$y2, main="X2, Y2", xlab="", ylab="", ylim=c(0, 15), xlim=c(4, 20)  )
abline( lm(anscombe$y2 ~ anscombe$x2), col="red" )
plot( anscombe$x3, anscombe$y3, main="X3, Y3", xlab="", ylab="", ylim=c(0, 15), xlim=c(4, 20)  )  
abline( lm(anscombe$y3 ~ anscombe$x3), col="red" )
plot( anscombe$x4, anscombe$y4, main="X4, Y4", xlab="", ylab="", ylim=c(0, 15), xlim=c(4, 20)  )
abline( lm(anscombe$y4 ~ anscombe$x4), col="red" )
par( mfrow=c(1, 1) )





# 2. ggplot2 기본

year2023 <- read.csv("./data/2023_pops_income_cafe.csv", fileEncoding="EUC-KR")

# year2023$sido <- iconv(year2023$sido, from="EUC-KR", to="UTF-8")
# year2023$sigungu <- iconv(year2023$sigungu, from="EUC-KR", to="UTF-8")
# year2023$is.Sido <- iconv(year2023$is.Sido, from="EUC-KR", to="UTF-8")

ggplot( data = year2023 )

ggplot( year2023 )

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes) )

p <- ggplot( year2023 )
p + geom_point( aes(x = income, y = cafes) )

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes, color = sido) )

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes, color = sido) ) +
  geom_text( aes(x = income, y = cafes, label = sigungu ) )

ggplot( year2023 %>% filter(sido == "강원도") ) +
  geom_point( aes(x = income, y = cafes) ) +
  geom_text( aes(x = income, y = cafes, label = sigungu ) )

ggplot( year2023 %>% filter(sido == "서울특별시") ) +
  geom_point( aes(x = income, y = cafes) ) +
  geom_text( aes(x = income, y = cafes, label = sigungu ) )

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes) ) +
  geom_text( aes(x = income, y = cafes, label = sigungu ) ) + 
  facet_wrap( vars( sido ), ncol = 4 )

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes) ) +
  geom_text( aes(x = income, y = cafes, label = sigungu ) ) + 
  theme_minimal()

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes) ) +
  geom_text( aes(x = income, y = cafes, label = sigungu ) ) + 
  labs( x = "Total Income", y = "No. of Cafes" ) +
  scale_x_continuous( labels = scales::comma ) +
  theme_minimal()


ggplot(year2023) %>%
  geom_point(aes(x = income, y = cafes)) + 
  geom_text(aes(x = income, y = cafes, label = sigungu)) %>%
  scale_x_continuous(labels = scales :: comma)

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes, color = sido) ) +
  labs( x = "소득", y = "개업 카페 수")

install.packages( "showtext" )
library( showtext )

font_add( family = "KWD", 
          regular = "KoPubWorld Dotum Medium.ttf")

font_add_google("Noto Sans KR", "NSK")
showtext_auto()

ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes, color = sido) ) +
  labs( x = "소득", y = "개업 카페 수") +
  theme(
    text = element_text( family = "NSK" )
  )