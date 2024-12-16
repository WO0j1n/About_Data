# 1. 랜덤 포레스트
# Page 9

library(randomForest)
f = randomForest(Species~., data=iris)
# 학습된 결정 트리에 대한 자세한 정보
f 
# 학습된 결정 트리에 대한 더 자세한 정보
summary(f) 
print(f)



# Page 10

plot(f)



# Page 11

varUsed(f)
varImpPlot(f)



# Page 12

treesize(f)



# Page 13

newd = data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width = c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))
predict(f, newdata = newd)



# Page 14

predict(f, newdata = newd, type = 'prob')

predict(f, newd, type = 'vote', norm.votes = FALSE)



# Page 15

small_forest = randomForest(Species~., data=iris, ntree=20, nodesize=6, maxnodes=12)
treesize(small_forest)
small_forest





# 2. SVM
# Page 23

library(e1071)

s = svm(Species~., data = iris)
print(s)

table(predict(s, iris), iris$Species)  
p = predict(s, iris)
table(p, iris$Species)



# Page 24

s = svm(Species~., data = iris,kernel = 'polynomial')
p = predict(s, iris)
table(p, iris$Species)



# Page 25

s = svm(Species~., data = iris, cost = 100)
p = predict(s, iris)
table(p, iris$Species)





# 3. k-NN
# Page 31

library(class)
train = iris
test = data.frame(Sepal.Length = c(5.11, 7.01, 6.32), Sepal.Width = c(3.51, 3.2, 3.31), Petal.Length = c(1.4, 4.71, 6.02), Petal.Width = c(0.19, 1.4, 2.49))
k = knn(train[, 1:4], test, train$Species, k = 5)
k



# Page 32

library(caret)
r = train(Species~., data = iris, method = 'rpart')
f = train(Species~., data = iris, method = 'rf')
s = train(Species~., data = iris, method = 'svmRadial')
k = train(Species~., data = iris, method = 'knn')

names(getModelInfo())



# Page 33

ucla = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)
ucla$admit = factor(ucla$admit)



# Page 34
r = rpart(admit~., data = ucla)
par(mfrow = c(1, 1), xpd = NA)
plot(r)
text(r, use.n = TRUE)

p = predict(r, ucla, type = 'class')
table(p, ucla$admit)



# Page 35

f = randomForest(admit~., data = ucla)
print(f)



# Page 36

library(survival)
clean_colon = na.omit(colon)                 
clean_colon = clean_colon[c(TRUE, FALSE), ]  
clean_colon$status = factor(clean_colon$status)
str(clean_colon)



# Page 37

r = rpart(status~rx + sex + age + obstruct + perfor + adhere + nodes + differ + extent + surg + node4, data = clean_colon)
p = predict(r, clean_colon, type = 'class')
table(p, clean_colon$status)

plot(r)
text(r, use.n = TRUE)



# Page 38

summary(r)



# Page 39

f = randomForest(status~rx + sex + age + obstruct + perfor + adhere + nodes + differ + extent + surg + node4, data = clean_colon)
print(f)

treesize(f)



# Page 40

voice = read.csv('./data/voice.csv')
str(voice)

table(is.na(voice))



# Page 41

r = rpart(label~., data = voice)
par(mfrow = c(1, 1), xpd = NA)
plot(r)
text(r, use.n = TRUE)

p = predict(r, voice, type = 'class')
table(p, voice$label)



# Page 42

voice$label = factor(voice$label)

f = randomForest(label~., data = voice)
print(f)

treesize(f)

