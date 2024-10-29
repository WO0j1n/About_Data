# 3. 단순 선형 회귀

x = c(3.0, 6.0, 9.0, 12.0)
y = c(3.0, 4.0, 5.5, 6.5)
m = lm(y ~ x)
m

plot(x, y)
abline(m, col = 'red')

coef(m)       
fitted(m)     
residuals(m)  
deviance(m)   
deviance(m)/length(x) 

summary(m)

new_x <- data.frame(x = c(1.2, 2.0, 20.65))
predict(m, newdata = new_x)

nx <- c(1.2, 2.0, 20.65)
ny <- c(2.23, 2.55, 10.01)
plot(nx, ny, col='red', cex=2, pch=20)
abline(m)





# 4 단순 선형 회귀의 적용 : cars 데이터

str(cars)
head(cars)
plot(cars)

cars_model <- lm(dist ~ speed, data = cars)
coef(cars_model)
plot(cars)
abline(cars_model, col = 'red')

cars[20, ]
fitted(cars_model)
residuals(cars_model)

plot(cars)
abline(cars_model, col = 'red')
points(14, 37.474628, col='blue', cex=2, pch=20)

nx1 <- data.frame(speed = c(21.5))
predict(cars_model, nx1)
nx2 <- data.frame(speed = c(25.0, 25.5, 26.0, 26.5, 27.0, 27.5, 28.0))
predict(cars_model, nx2)

nx <- data.frame(speed = c(21.5, 25.0, 25.5, 26.0, 26.5, 27.0, 27.5, 28.0))
plot(nx$speed, predict(cars_model, nx), col ='red', cex = 2, pch = 20)
abline(cars_model)

plot(cars)      
x <- seq(0, 25, length.out = 26)
for(i in 1:4) {  
  m <- lm(dist ~ poly(speed, i), data = cars)
  lines(x, predict(m, data.frame(speed = x)), col = i) 
}
print(m)

for(i in 1:4) {  
  m <- lm(dist ~ poly(speed, i), data = cars)
  assign(paste('m', i, sep = '.'), m)        # i차 모델 m을 m.i로 선언
}

anova(m.1, m.2, m.3, m.4)                 





# 5 다중 선형 회귀

install.packages('scatterplot3d')
library(scatterplot3d)
x <- c(3.0, 6.0, 3.0, 6.0)
u <- c(10.0, 10.0, 20.0, 20.0)
y <- c(4.65, 5.9, 6.7, 8.02)
scatterplot3d(x, u, y, xlim = 2 : 7, ylim = 7 : 23, zlim = 0 : 10, pch = 20, type = 'h')


m <- lm(y ~ x + u)
coef(m)

s <- scatterplot3d(x, u, y, xlim = 2 : 7, ylim = 7 : 23, zlim = 0 : 10, pch = 20, type = 'h')
s$plane3d(m)

fitted(m)
residuals(m) 
deviance(m)           
deviance(m)/length(x) 

new_x <- c(7.5, 5.0)
new_u <- c(15.0, 12.0)
new_data <- data.frame(x = new_x, u = new_u)          
new_y <- predict(m, new_data)
new_y

s <- scatterplot3d(new_x, new_u, new_y, xlim = 0 : 10, ylim = 7 : 23, zlim = 0 : 10, pch = 20, type = 'h', color = 'red', angle = 60)
s$plane3d(m)