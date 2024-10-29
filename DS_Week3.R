x = 1
y = 1

z = x + y
z

x + y = z

z <- x + y
z

x + y -> z
z


# 연습문제
x = 1
y = 2

temp = x
x = y
y = temp
x
y


# R의 기본 데이터형 학습 예제 #
x = 5
y = 2
x/y

xi = 1 + 2i
yi = 1 - 2i
xi+yi

# 문장 입력 시 ""
str = "Hello, World!"
str

blood.type = factor(c('A', 'B', 'O', 'AB'))
blood.type

T
F

xinf = Inf
yinf = -Inf
xinf/yinf

# 기본 데이터형
x = 1
x
is.integer(x)
x = 1L
x
is.integer(x)
x = as.integer(1) 
x
is.integer(x)


# 벡터
1:7
7:1
vector(length = 5)    #FALSE는 값이 없음을 의미

c(1:5)                #c = combination
c(1, 2, 3, c(4:6))
x = c(1, 2, 3)
x
y = c()
y = c(y, c(1:3))
y

seq(from = 1, to = 10, by = 2) 	# 순열(sequence) 벡터
seq(1, 10, by = 2)

seq(0, 1, by = 0.1)
seq(0, 1, length.out = 11)

rep(c(1:3), times = 2)          # 반복(repetition) 벡터
rep(c(1:3), each = 2)

x = c(2, 4, 6, 8, 10)
length(x)
x[1]
x[1, 2, 3]
x[c(1, 2, 3)]
x[-c(1, 2, 3)]
x[c(1:3)]

x = c(1, 2, 3, 4)
y = c(5, 6, 7, 8)
z = c(3, 4)
w = c(5, 6, 7)
x+2
x + y
x + z
x + w

x = 1 : 10
x > 5
all(x>5)
any(x>5)

x = 1:10
head(x)
tail(x)
head(x, 3)
tail(x, 3)

x = c(1, 2, 3)
y = c(3, 4, 5)
z = c(3, 1, 2)
union(x, y)
intersect(x, y)
setdiff(x, y) 
setdiff(y, x) 
setequal(x, y)
setequal(x, z)



# 배열

x = array(1:5, c(2, 4)) # n차원 배열 정의 array
x
x[1, ]
x[, 2]


dimnamex = list(c("1st", "2nd"), c("1st", "2nd", "3rd", "4th")) 
x = array(1:5, c(2, 4), dimnames = dimnamex)
x
x["1st", ]
x[, "4th"]


x = 1:12  # 2차원 배열 정의 matrix
x
matrix(x, nrow = 3)
matrix(x, nrow = 3, byrow = T)


v1 = c(1, 2, 3, 4)
v2 = c(5, 6, 7, 8)
v3 = c(9, 10, 11, 12)
cbind(v1, v2, v3) 
rbind(v1, v2, v3)


x = array(1:4, dim = c(2, 2))
y = array(5:8, dim = c(2, 2))
x
y
x + y
x - y
x * y 
x %*% y 
t(x)
solve(x)
det(x)


x = array(1:12, c(3, 4))
x
apply(x, 1, mean) 
apply(x, 2, mean) 

x = array(1:12, c(3, 4))
dim(x)

x = array(1:12, c(3, 4))
sample(x)
sample(x, 10)
sample(x, 10, prob = c(1:12)/24) 
sample(10)



# 데이터 프레임
name = c("철수", "춘향", "길동")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients = data.frame(name, age, gender, blood.type)
patients

patients1 = data.frame(name = c("철수", "춘향", "길동"), age = c(22, 20, 25), gender = factor(c("M", "F", "M")), blood.type = factor(c("A", "O", "B")))
patients1

patients$name 
patients[1, ] 
patients[, 2] 
patients[3, 1]
patients[patients$name=="철수", ] 
patients[patients$name=="철수", c("name", "age")]


head(cars)
speed
attach(cars) 
speed
detach(cars) 
speed

mean(cars$speed)
max(cars$speed)

with(cars, mean(speed))
with(cars, max(speed))

subset(cars, speed > 20)

subset(cars, speed > 20, select = c(dist))

subset(cars, speed > 20, select = -c(dist))


head(airquality)
head(na.omit(airquality))




name = c("철수", "춘향", "길동")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients1 = data.frame(name, age, gender)
patients1

patients2 = data.frame(name, blood.type)
patients2

patients = merge(patients1, patients2, by = "name")
patients


# 예제
merge(x, y, by = intersect(names(x), names(y)), by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all, sort = TRUE, suffixes = c(".x",".y"), incomparables = NULL, ...)E
name1 = c("철수", "춘향", "길동")
name2 = c("짱구", "춘향", "길동")
age = c(22, 20, 25)
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))
patients1 = data.frame(name1, age, gender)
patients1

patients2 = data.frame(name2, blood.type)
patients2

patients = merge(patients1, patients2, by.x = "name1", by.y = "name2")
patients

patients = merge(patients1, patients2, by.x = "name1", by.y = "name2", all = TRUE)
patients
x = array(1:12, c(3, 4))
is.data.frame(x)
as.data.frame(x)


is.data.frame(x)
x = as.data.frame(x)
x

is.data.frame(x)
names(x) = c("1st", "2nd", "3rd", "4th")
x


# 08 리스트
patients = data.frame(name = c("철수", "춘향", "길동"), age = c(22, 20, 25), gender = factor(c("M", "F", "M")), blood.type = factor(c("A", "O", "B")))
no.patients = data.frame(day = c(1:6), no = c(50, 60, 55, 52, 65, 58))

listPatients = list(patients, no.patients) 
listPatients

listPatients = list(patients=patients, no.patients = no.patients) 
listPatients

listPatients$patients	

listPatients[[1]]		

listPatients[["patients"]]		

listPatients[["no.patients"]]	

lapply(listPatients$no.patients, mean) 

lapply(listPatients$patients, mean) 

sapply(listPatients$no.patients, mean) 

sapply(listPatients$no.patients, mean, simplify = F) 
