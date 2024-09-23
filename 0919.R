# 변수 값 저장하기
x = 1
y = 1

z = x + y
z

z <- x + y
z

x + y -> z
z
# 위와 같이 R을 활용하는 경우 <- 방향을 활용해서 수행하고자 함.
# 특히, 암묵적인 룰로 변수는 왼쪽에 두는 것으로 함.

# 아래의 경우 오류가 나는 코드
# x + y = z

# x = 1, y = 2로 정의되어 있을 때, 두 값을 교환해보라.
# 하나의 임시 저장공간 즉, 버퍼를 하나 만들어서 수행
x <- 1
y <- 2
tmp <- x
x <- y
y<- tmp
x
y

# R 선언 시, 유의 사항

# 대소문자를 구분함
# 특수문자 사용 불가
# 밑줄_ or 마침표. 쓸 수 있다
  # 이때, 숫자나 밑줄을 변수 이름의 첫 글자로는 사용할 수 없다.
# 한글 변수 선언이 가능하나 불편함.
# 미리 정해진 명령어 사용이 불가하다. -> if, for, while 기타 등등...

# R의 기본 데이터형: 숫자는 기본적으로 double로 처리

x <- 5
y <-2
x/y

xi = 1 +2i
yi = 1 -2i
xi + yi


str = "Hello, World!"
str

blood.type = factor(c('A', 'B', 'O', 'AB'))
blood.type

T
F

xinf = Inf # 양의 무한대
yinf = -Inf # 음의 무한대
xinf/yinf #연산이 불가능한 값 표시

# 데이터형 확인 함수 및 변환 함수
# 데이터형 확인 함수: class(), typeof(), is.integer(), is.numeric(), is.complex(), ischaracter(), is.na()
# 데이터 변환 함수: as.factor(), as.integer(), as.numeric(), as.character(), as.matrix(), as.array()

is.integer(x) # int 형 자료 변환
x = 1L # long integer로 설정

# 연산자 종류 타프로그래밍 언어와 비슷함.
# %%: 나눈 나머지
# %/%: 나눈 몫
# ^, **: 지수승

# 벡터
1:7 # 1부터 7까지 1씩 증가시켜 요소가 7개인 벡터 생성
7:1 # 7부터 1까지 1씩 감소시켜 요소가 7개인 벡터 생성
vector(length = 5) # 요소의 개수가 n개인 빈 벡터 생성
c(1:5) # c 함수 사용하여 1~5 요소로 구성된 벡터 생성
c(1,2,3,c(4:6)) # 1~3 요소와 4~6 요소를 결합한 1~6 요소로 구성된 벡터 생성

y = c() # y를 빈 벡터로 생성
y = c(y, c(1:3)) # 기존 y 벡터에 c(1:3) 벡터를 추가해 생성
y # y출력

# seq 함수 사용하기
seq(from = 1, to = 10, by = 2) # 1부터 10까지 2씩 증가하는 벡터 생성
seq(1, 10, by = 2)# 1부터 10까지 2씩 증가하는 벡터 생성

seq(0, 1, by = 0.1) # 0부터 1까지 0.1씩 증가하는 요소가 11개인 벡터 생성
seq(0, 1, length.out = 11) # 0부터 1까지 요소가 11개인 벡터 생성

rep(c(1:3), times = 2) # 벡터 전체를 2번 반복하여 벡터 생성
rep(c(1:3), each = 2) # (1,2,3) 벡터의 개별 요소를 2번씩 반복한 벡터 생성

x = c(2,4,6,8,10)
length(x) # 벡터의 크기를 구함

x[1]# 벡터의 1번 요소를 구함
# x[1,2,3] # 벡터의 1,2,3번 요소를 이런 식으로 접근하면 오류 발생
x[c(1,2,3)] # 벡터의 1,2,3번 요소를 구할 때는 이렇게 벡터로 묶어야 함
x[-c(1,2,3)] # 벡터에서 1,2,3번 요소를 제외한 값 출력
x[c(1:3)] # 1번부터 3번 요소를 출력

# 벡터 간 연산
  # 벡터의 길이가 같거나 요소 개수가 배수 관계에 있을 때 연산이 가능

x = c(1,2,3,4)
y = c(5,6,7,8)
z = c(3,4)
w = c(5,6,7)
x +2 # x 벡터의 개별 요소에 2를 각각 더함
x+y  # x 벡터와 y 벡터의 크기가 동일하므로 각 요소별로 더함
x+z # x벡터가 z 벡터 크기의 정수배인 경우엔 작은 쪽 벡터 요소를 순환하여 더함
# x+w # x와 w의 크기가 정수배가 아니므로 연산 오류 발생

# all, any 함수 : 벡터 내 모든, 일부 요소의 조건 검토
x = 1:10

x>5 # x 벡터의 요소 값이 5보다 큰지 확인
all(x>5)# x벡터의 요소 값이 모두 5보다 큰지 확인
any(x>5)# x 벡터의 요소 값 중 일부가 5보다 큰지 확인

# head, tail 함수: 데이터의 앞, 뒤 일부 요소 추출(기본적으로 6개 추출)
x=1:10
head(x)
tail(x)
head(x, 3)
tail(x, 3)

# union, intersect, setdiff, setequal 함수: 벡터 간 집합 연산
x = c(1,2,3)
y = c(3,4,5)
z = c(3,1,2)

union(x, y)
intersect(x, y)
setdiff(x, y)
setdiff(y, x)
setequal(x, y)
setequal(x, z)

# 배열: 열과 행으로 구성된 데이터
# 벡터: 행만 존재하고 열이 1개인 경우를 의미
x = array(1:5, c(2, 4)) # 1~5 값을 2x4 행렬에 할당
x
x[1,]
x[,2]

# amtrix 함수 : 2ㅊ원 배열 생성

x = 1: 12
x

matrix(x, nrow = 3)

matrix(x, nrow = 3, byrow = T)

v1 = c(1,2,3,4)
v2 = c(5,6,7,8)
v3 = c(9, 10, 11, 12)

cbind(v1,v2,v3) # 열 단위로 묶어서 배열 생성
rbind(v1,v2,v3) # 행 단위로 묶어서 배열을 생성

# 벡터 연산 예제
x = array(1:4, dim = c(2,2))
y = array(5:8, dim = c(2, 2))

x
y
x+y
x-y
x*y # 각 요소별 곱셈
x%%y# 수학적인 행렬 곱셈
t(x)# x 의 전치 행렬
solve(x) # x의 역행렬
det(x)# x 의 행렬

x = array(1:12, c(3, 4))
sample(x)# 배열 요소를 임의로 섞어 추출
sample(x, 10)# 배열 요소 중 10개를 골라 추출
sample(x, 10, prob = c(1:12)/24) # 각 요소별 추출 확률을 달리할 수 있음
sample(10) # 단순히 숫자만 사용하여 샘플을 만듦

# 데이터 프레임
  # 가장 흔히 쓰이는 표 형태의 데이터 구조
  # 행렬과 달리 여러 데이터형을 혼합하여 저장할 수 있음
  # 리스트와 달리 행의 수를 일치시켜서 저장해야 함
name = c('철수', '춘향', '길동')
age = c(22, 20, 25)  
gender = factor(c("M", "F", "M"))
blood.type = factor(c("A", "O", "B"))

patients = data.frame(name, age, gender, blood.type)
patients

patients$name # name 속성 값 출력
patients[1,] # 1행 값 출력
patients[,2] # 2열 값 출력
patients[3,1] # 3행 1열 값 출력
patients[patients$name == "철수", ] # 환자 중 철수에 대한 정보 추출
patients[patients$name == "철수", c("name", "age")] # 철수 이름과 나이 정보만 추출

# 해당 데이터 프레임을 가져와서 속성명을 변수명으로 사용하여 접근하고자 하면 attach를 수행해야 함.
# 반대로 detatch로 속성명을 변수명으로 사용할 수 없음
head(cars) # cars 데이터셋에서 앞의 6개 데이터 추출
#speed # attach을 하지 않았기에 속성명을 변수로 가져올 수 없음
attach(cars) # attach 를 통해서 속성명을 변수로 가져올 수 있음
speed
detach(cars) # detatch를 통해서 속성명을 변수로 가져올 수 없도록 원래대로 함.
#speed

# with 함수: 데이터 프레임에 다양한 함수 적용(apply와 유사)
# 데이터 속성을 이용해 함수 적용
mean(cars$speed)
max(cars$speed)

# with 함수를 이용해 함수 적용
with(cars, mean(speed))
with(cars, max(speed))

# subset 함수: 데이터 프레임에서 일부 데이터만 추출
subset(cars, speed > 20) # 속도가 20초과인 데이터만 추출
subset(cars,speed > 20 , select = -c(dist))# 속도가 20초과인 데이터 중 dist 제외한 데이터만 추출
subset(cars, speed > 20, select = c(dist))# 속도가 20 초과인 dist 데이터 만 추출, 여러 열 선택은 c() 안을 , 로 구분

# na.omit(): 데이터 프레임의 결측값(NA) 제거
head(airquality)
head(na.omit(airquality)) # NA 결측값이 포함된 값을 제외하여 추출함

# merge 함수: 여러 데이터 프레임 병합
name = c('철수', '춘향', '길동')
age = c(22, 20, 25)
gender = factor(c('M', 'F', 'M'))
blood.type = factor(c("A", "O", "B"))

patients1 = data.frame(name, age, gender)
patients1

patients2 = data.frame(name, blood.type)
patients2

patients = merge(patients1, patients2, by = 'name')
patients

# 리스트
  # 서로 다른 기본 데이터형을 갖는 자료구조
  # 데이터 프레임보다 넓은 의미의 데이터 모임
  # 데이터 프레임과 달리 모든 속성의 크기가 같을 필요가 없음

patients
no.patients = data.frame(day = c(1:6), no = c(50, 60, 55, 52, 65, 58))
no.patients

# merge 함수로는 속성들의 사이즈가 다르기에 불가능함.
# list 함수를 활용해서 속성들의 사이즈가 달라도 병합할 수 있음
listPatients = list(patients, no.patients)
listPatients

# 각 데이터에 이름을 부여하면서 추가
listPatients = list(patients = patients, no.patients = no.patients)
listPatients

# 리스트 요소에 접근: $, [[]] 이용
listPatients$patients # 요소명 입력
listPatients[[1]] # 인덱스 입력
listPatients[['patients']] # 요소명을 ""에 입력
listPatients[['no.patients']]# 요소명을 ""에 입력

# 리스트에 유용한 함수
  # lapply, sapply 함수: 리스트 요소에 다양한 함수 적용

lapply(listPatients$no.patients, mean) # no.patients 요소의 평균을 구해줌
lapply(listPatients$patients, mean) # 숫자형이 아닌 경우는 평균이 구해지지 않음

sapply(listPatients$no.patients, mean) # simplify의 기본 설정 T, apply와 출력 결과 다름 유의!!!
sapply(listPatients$no.patients, mean, simplify = F) # sapply()의 simplify를 F로 설정하면 apply와 동일한 결과를 반환함