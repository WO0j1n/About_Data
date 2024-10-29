library( tidyverse )
year2023 <- read.csv("./R_data/data/2023_pops_income_cafe.csv", fileEncoding="EUC-KR")
year2023 <- year2023 %>% filter(sido == "강원도")





# 1. ggplot2와 데이터 매핑

# Page 5
ggplot( year2023 ) + 
  geom_point( aes(x = income, y = cafes) )

ggplot() + 
  geom_point( data = year2023, aes(x = income, y = cafes) )

ggplot( year2023, aes(x = income, y = cafes) ) + 
  geom_point()

# Page 7
ggplot( year2023, aes(x = income, y = cafes) ) + 
  geom_point( aes( color = isCity ) )

ggplot( year2023, aes(x = income, y = cafes) ) + 
  geom_point( color = "steelblue", size = 5 )

# ggplot()에서 전달받은 데이터를 사용하지 않을 경우
ggplot( year2023, aes(x = income, y = cafes) ) +
  geom_point( aes( color = isCity ) ) +
  geom_text( data = year2023 %>% filter( income == max(income) | income == min(income) ), aes( x = income, y = cafes, label = sigungu) )




# 2. geom 계열 함수

# Page 9
ggplot( mtcars, aes(wt, mpg) ) +
  geom_point() +
  labs( x = "Weight(1,000lbs)", y= "Mile/Gallon" )

# Page 10
ggplot( mtcars, aes(wt, mpg) ) +
  geom_point( aes( color = cyl, 
                   size = hp, 
                   shape = factor( am ) ) ) +
  labs( x = "Weight(1,000lbs)", y= "Mile/Gallon" )

# Page 11
ggplot( mtcars, aes( x = gear )) +
  geom_bar()

ggplot( mtcars, aes( y = gear )) +
  geom_bar()

# Page 12
ggplot( mtcars, aes( gear )) +
  geom_bar( aes(weight = wt) )

# Page 13
ggplot( mtcars, aes( gear )) +
  geom_bar( color = "lightgray",
            size = 2 )

# 엔진 모양(vs)에 따라 구분
ggplot( mtcars, aes( gear )) +
  geom_bar( aes( fill = factor(vs) ), 
            color = "lightgray",
            size = 2 )

ggplot( mtcars, aes( gear )) +
  geom_bar( aes( fill = factor(vs) ), 
            color = "lightgray",
            size = 2,
            position = "dodge" )

# Page 14
ggplot( mtcars, aes( gear )) +
  geom_col( aes( fill = factor(vs) ), 
            color = "lightgray",
            size = 2,
            position = "dodge" )

mtcars %>%
  group_by( gear, vs ) %>%
  summarise(
    n = n()
  ) 

mtcars %>%
  group_by( gear, vs ) %>%
  summarise(
    n = n()
  ) %>%
  ggplot( aes( x = gear, y = n )) +
  geom_col( aes( fill = factor(vs) ), 
            color = "lightgray",
            size = 2,
            position = "dodge" )

# Page 15
ggplot( mtcars, aes( wt, mpg ) ) +
  geom_point() +
  geom_smooth()

# Page 16
ggplot( mtcars, aes( wt, mpg ) ) +
  geom_point( aes(color = factor(vs)) ) +
  geom_smooth( aes(color = factor(vs)))

ggplot( mtcars, aes( wt, mpg ) ) +
  geom_point( aes(color = factor(vs)) ) +
  geom_smooth( aes(color = factor(vs)), se = FALSE)

# Page 17
ggplot( mtcars, aes( y = mpg ) ) +
  geom_boxplot()

# 기어 수(gear)에 따라 구분
ggplot( mtcars, aes( y = mpg ) ) +
  geom_boxplot( aes( fill = factor(gear) ) )





# 3. coord 계열 함수

install.packages("HistData")
library(HistData)

Nightingale %>% 
  select(Date, Month, Year, ends_with("rate")) %>% 
  pivot_longer(cols = 4:6, names_to = "Cause", values_to = "Rate") %>% 
  mutate(Cause = gsub(".rate", "", Cause)) %>% 
  filter( Date <= as.Date("1855-03-01") ) %>%
  write.csv( "./data/rosechart_before_1855_march.csv")

# Page 20
ng <- read.csv( "./data/rosechart_before_1855_march.csv", stringsAsFactors = TRUE )

ng <- ng %>%
  mutate( Month = fct_relevel(Month, "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun")) 

# Page 21
ng %>%
  ggplot( aes( Month, sqrt(Rate) ) ) + 
  geom_col( aes(fill = Cause), width = 1, position = "identity" ) + 
  scale_fill_manual( values = c("skyblue3", "grey30", "firebrick") ) +
  theme_void() 

# Page 22
ng %>%
  ggplot( aes( Month, sqrt(Rate) ) ) + 
  geom_col(aes(fill = Cause), width = 1, position = "identity") + 
  scale_fill_manual(values = c("skyblue3", "grey30", "firebrick")) +
  coord_polar() + 
  theme_void() 





# 4. 고급 데이터 시각화

# facet_계열 함수수
# Page 24
ggplot( mtcars, aes( wt, mpg ) ) +
  geom_point() +
  facet_wrap( vars( cyl ), 
              ncol = 2,
              scales = "free",
              strip.position = "right",
              dir = "v" )

# Page 25
ggplot( mtcars, aes( wt, mpg ) ) +
  geom_point() +
  facet_grid( rows = vars(vs), cols = vars(am) )

# Page 26
ggplot( mtcars, aes( wt, mpg ) ) +
  geom_point() +
  facet_grid( vs ~ am ) 

# 변수 더하기
ggplot( mtcars, aes( wt, mpg ) ) +
  geom_point() +
  facet_grid( vs + am ~ gear)  



# theme_ 계열 함수

p <- ggplot( mtcars ) +
  geom_boxplot( aes(y = mpg, fill = factor(am) ) )

# Page 27
p + theme_grey() + labs(title = "Default, theme_grey()")
p + theme_void() + ggtitle("theme_void()")
p + theme_classic() + ggtitle("theme_classic()")
p + theme_minimal() + ggtitle("theme_minimal()")

p + theme_linedraw() + ggtitle("theme_linedraw()")
p + theme_bw() + ggtitle("theme_bw()")
p + theme_light() + ggtitle("theme_light()")
p + theme_dark() + ggtitle("theme_dark()")

# Page 32
install.packages("ggthemes")
library( ggthemes )

p + theme_wsj() + ggtitle("Wall Street Journal")
p + theme_economist() + ggtitle("Economist")
p + theme_fivethirtyeight() + ggtitle("fivethirtyeight")
p + theme_excel_new() + ggtitle("Microsoft Excel") + scale_fill_excel_new()
p + theme_stata() + ggtitle("Stata")

# Page 38
p + theme_economist() + ggtitle("Economist") +
  theme( 
    plot.title = element_text( size = 20 ),
    panel.background = element_rect( fill = "white"),
    axis.ticks = element_blank(),
    legend.position = "bottom"
  )