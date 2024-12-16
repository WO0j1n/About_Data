# Page 14

iris



# Page 16
library(rpart)
r = rpart(Species~., data = iris)
# rpart(), anova(), party() 이렇게 3가지 방법으로 만들 수 있음
# method = 'calss', 'anova', poisson, exp
# parms = list(piror = c())

# predict(model, newdataframe, type = 'class','prob')
printcp(r)



# Page 17
par(mfrow = c(1, 1), xpd = NA)
# xpd는 NA로 설정해주자 -> 박스 크기에 벗어나도 자동으로 쓰겠단 말임.
plot(r)
text(r, use.n = TRUE)



# Page 20
p = predict(r, iris, type = 'class')
table(p, iris$Species)
 


# Page 21
newd = data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width = c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))
print(newd) 
predict(r, newdata = newd)



# Page 23
r_prior = rpart(Species~., data = iris, parms = list(prior = c(0.1, 0.1, 0.8)))
# 사전확률을 저장할 수 있다! -> parms = list(prior = c ())
plot(r_prior)
text(r_prior, use.n = TRUE)
# r_prior - 노드의 질문을 text로 가져오기
# use.n -  각 노드의 질문으로 나눠지는 관칙지 수 함께 써줌




# Page 24
summary(r)



# Page 26
install.packages(rpart.plot)
library(rpart.plot)
rpart.plot(r)
rpart.plot(r, type = 4) # type = 0, 1, 2, 3, 4 존재함
# 0 - 기본적인 트리 형식
# 1 - 자식과 부모노드의 관계 강조
# 3 - 모든 노드를 같은 수평선에 배치
# 4 - 모든 노드를 세로 방향으로 간결히 정렬

