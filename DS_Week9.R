# 1. 일반화 선형 모델의 필요성

muffler <- data.frame(discount = c(2.0, 4.0, 6.0, 8.0, 10.0), profit = c(0, 0, 0, 1, 1))
plot(muffler, pch = 20, cex = 2, xlim = c(0, 12)) 

# lm()을 활용한 선형 모델 얻기
m <- lm(profit ~ discount, data = muffler)
coef(m)
fitted(m)
residuals(m)
deviance(m)/length(muffler$discount) # MSE 구하기 -> 잔차제곱합/length(종속변수)

# 제공 데이터와 선형 모델
plot(muffler, pch = 20, cex = 2, xlim = c(0, 12))
abline(m)# 모델 경계선에 걸림

# 새로운 할인율 데이터를 바탕으로 한 예측
newdata <- data.frame(discount = c(1, 5, 12, 20, 30))
p <- predict(m, newdata)
print(p)

# 결과비교
plot(muffler, pch = 20, xlim = c(0, 32), ylim = c(-0.5, 4.2))
abline(m)
res <- data.frame(discount = newdata, profit = p)
points(res, pch = 20, cex = 2, col = 'red')
legend ("bottomright", legend = c("train data", "new data"), pch = c(20, 20), col = c("black", "red"), bg = "gray")





# 2. 일반화 선형 모델
# page 11
muffler <- data.frame(discount = c(2.0, 4.0, 6.0, 8.0, 10.0), profit = c(0, 0, 0, 1, 1))
g <- glm(profit ~ discount, data = muffler, family = binomial) # 해당 코드 경고 메시지 -> 과잉 적합이니 조심해라
# 데이터 셋이 너무 작기에 발생하는 일이므로 무시할 것

coef(g)
fitted(g)
residuals(g)
deviance(g)

plot(muffler, pch = 20, cex = 2)
abline(g, col = 'blue', lwd = 2) # glm을 사용했을 때, lm을 사용할 때 보다 더 분류가 잘 되는 것을 확인함
# 그렇다고 해서 항상 좋은 것은 아니기에 단순/다항/다중으로 안 되는 경우에, glm을 사용하기

# page 12
newdata <- data.frame(discount = c(1, 5, 12, 20, 30))
p <- predict(g, newdata, type='response') 
# predict 수행 시, type = 'response'를 설정하면 반환 값을 0 ~ 1 사이의 값으로 수행
print(p)

plot(muffler, pch = 20, xlim = c(0, 32))
abline(g, col = 'blue', lwd = 2)
res <- data.frame(discount = newdata, profit = p)
points(res, pch = 20, cex = 2, col = 'red')
legend ("bottomright", legend = c("train data", "new data"), pch = c(20, 20), col = c("black", "red"), bg = "gray")



# Page 13 - Haberman Survival

haberman <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/haberman/haberman.data", header = FALSE)
head(haberman)
names(haberman) <- c('age', 'op_year', 'no_nodes', 'survival')
str(haberman)

h <- glm(survival ~ age + op_year + no_nodes, data = haberman, family = binomial)

# Error correction # 1
haberman$survival <- ifelse(haberman$survival == 1, 0, 1)

h <- glm(survival ~ age + op_year + no_nodes, data = haberman, family = binomial)
coef(h)
deviance(h)

# Error correction # 2 - 범주형 데이터로 변환
haberman <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/haberman/haberman.data", header = FALSE)
names(haberman) <- c('age', 'op_year', 'no_nodes', 'survival')

haberman$survival <- factor(haberman$survival)
str(haberman)

h <- glm(survival ~ ., data = haberman, family = binomial)
coef(h)
deviance(h)

# 범주형으로 하든, 연속형(0/1)로 설정하여 수행하든 결과값은 동일함.
# 그러나 시각화 과정 및 해석하는 과정에서 차이 발생하기에 0/1의 값으로 변경 이후, 범주형으로 변경하는 것이 좋음.


# Page 14 - 새로운 환자 생존 여부 예측
new_patients <- data.frame(age = c(37, 66), op_year = c(58, 60), no_nodes = c(5, 32)) 
predict(h, newdata = new_patients, type = 'response')


# Page 16 
h <- glm(survival ~ age + no_nodes, data = haberman, family = binomial)
coef(h)
deviance(h)

new_patients <- data.frame(age = c(37, 66), no_nodes = c(5, 32))
predict(h, newdata = new_patients, type = 'response')





# Page 19 - UCLA Admission 데이터
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)

levels(ucla$rank)
levels(factor(ucla$rank)) # names(df)와 비슷한 동작 수행, 해당 levels()는 각 범주의 levels를 나타내줌
# 그렇기 때문에 항상 levels()에 전달하는 params type는 factor 형태일 것

# Page 20
plot(ucla)

# Page 21
# 과정: 
  # 0 또는 1의 범주로 변경하기 -> ifelse(, 0, 1)
  # factor로 형 변환하기
  # noise 부여하여 분포 퍼지게 하기 -> geom_jitter()로 수행하기
  # aes(col = facotr()) 각각의 범주 level의 따른 색상 다르게 부여 -> 명시적으로 factor을 적는 것이 좋음.
  # 이후, 시각화 결과 보고 geom_jitter(height, width) 설정을 통해서 분포 조정

library(dplyr)
library(ggplot2)

ucla %>% ggplot(aes(gre, admit)) + geom_point()   
ucla %>% ggplot(aes(gre, admit)) + geom_jitter()  
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col = admit))
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col = factor(admit)))
ucla %>% ggplot(aes(gre, admit)) + geom_jitter(aes(col = factor(admit)), height = 0.1, width = 0.0)   

# Page 23
install.packages('gridExtra')
library(gridExtra) # subplot 생성 라이브러리라고 생각하기
p1 <- ucla%>%ggplot(aes(gpa, admit)) + geom_jitter(aes(col = factor(admit)), height = 0.1, width = 0.0)
p2 <- ucla%>%ggplot(aes(rank, admit)) + geom_jitter(aes(col = factor(admit)), height = 0.1, width = 0.1)
grid.arrange(p1, p2, ncol = 2) # 두개의 plot을 한 fig에 동시 시각화가 가능함.

# Page 24
m <- glm(admit ~ ., data = ucla, family = binomial)
coef(m)
deviance(m)
summary(ucla)

s <- data.frame(gre = c(376), gpa = c(3.6), rank = c(3))
predict(m, newdata = s, type ='response')


# Page 26 - colon 데이터
library(survival)
str(colon)

# Page 29
plot(colon)

# Page 30
p1 <- colon %>% ggplot(aes(extent, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)
p2 <- colon %>% ggplot(aes(age, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)
p3 <- colon %>% ggplot(aes(sex, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)
p4 <- colon %>% ggplot(aes(nodes, status)) + geom_jitter(aes(col = factor(status)), height = 0.1, width = 0.1)
grid.arrange(p1, p2, p3, p4, ncol = 2, nrow = 2)

# Page 32
m = glm(status~., data = colon, family = binomial)
m

summary(m)
deviance(m)

# 결측값 수동 제거 관련
table(is.na(colon))

clean_colon = na.omit(colon)
m = glm(status~., data = clean_colon, family = binomial)
m

deviance(m)

# Page 34

clean_colon = na.omit(colon)
clean_colon = clean_colon[c(TRUE, FALSE), ]	           # 홀수 번째 것만 취함
m = glm(status~rx + sex + age + obstruct + perfor + adhere + nodes + differ + extent + surg + node4, data = clean_colon, family = binomial)
m



# 원핫인코딩 하는 이유
 # 명칭값을 거리성이 있는 숫자형 데이터로 변환하여 학습에 사용하고자 함.

