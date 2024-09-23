# R에서 사용하는 데이터형
 # 실수형(double), 정수형(integer, 3L), 숫자형(numeritc), 문자형, 논리형(True, False), 복소수형(1 + 3i)

# 문자의 경우, ASCII Code 를 활용해서 2진수로 변환되어 저장.
# 문자의 경우, 출력 시, ASCII Code로 변환된 2진수를 ASCII Code와 매칭하여 반환
char<- "R"
char

# 문자형 확인 함수
typeof(char) # 해당 변수의 자료형 파악
is.numeric(char) # 숫자형인지 확인
is.character(char) # 문자인지 확인 -> 마침 문자로 저장했으니 True

# 데이터형 확인 함수
# 데이터형 확인 함수: typeof()
# 데이터형 판단 함수: is.numeric(), is.integer(), is.double(), is.character(), is.logical()
# 데이터형 변환 함수: as.integer(), as.double(), as.character(), as.logical()

typeof(char) # 변수 char에 저장된 값의 데이터형 출력
is.numeric(char)# char저장된 값이 숫자형인지 확인
is.character(char) # char에 저장된 값이 문자열인지 확인

lgc1 <- c(TRUE, FALSE, FALSE, TRUE) # c() -> 기본적인 벡터 즉, 여러개의 값을 하나의 변수에 할당하고자 함.
lgc2int <- as.integer(lgc1)# 논리값 4개를 정수로 변환한 값을 할당
lgc2int # 변환값 출력, 논리형으로 정수 변환 가능
typeof(lgc2int)# 변수 lgc2int에 저당된 값의 데이터형 출력

lgc2char <- as.character(lgc1) # lgc1을 문자로 변환한 값을 할당
lgc2char # TRUE -> "TRUE", FALSE -> "FALSE"
typeof(lgc2char)

char2lgc <- as.logical(lgc2char) # lgc2char을 논리 값으로 변환
char2lgc # 문자열에서 논리값으로 변경
typeof(char2lgc)

char
char2lgc2 <- as.logical(char) # 문자열을 논리형으로 변환하고 할당
char2lgc2 # 문자열을 논리형으로 변환하고 그 결과, TRUE, FALSE가 아닌 문자열은 변환시 결측 값 NA 출력
typeof(char2lgc2) # 값의 변환에 실패해도 변수의 데이터형은 논리형임을 주의하자!!!!

# 특수데이터
  # NA: 결측값 -> is.na()
  # NaN: 0으로 나누는 것과 같이 수로 표현되지 않는 상황 -> is.nan()
  # NULL: 데이터형과 값이 결정되지 않은 상태를 나타내며, 데이터를 제거할 때도 사용 -> is.null()
  # Inf/-Inf: 양의 무한대와 음의 무한대 -> is.infinite(), is.finite()

var1 <- NA # 변수 var1에 NA(결측)을 저장
var2 <- 1 / 0 # 변수 var2에 1/0을 저장
var3 <- -var2 # 변수 var3에 var2의 값에 부호를 바꾼 값을 저장
var4 <- var2 / var3 # 변수 var4에 var2를 var3로 나눈 값을 저장
var5 <- NULL # 변수 var5에 NULL을 저장

is.na( var1 ) # 변수 var1이 결측인지 확인. 결과는 TRUE

is.na( var2 ) # 변수 var2가 결측인지 확인. 결과는 FALSE
is.infinite( var2 ) # 변수 var2가 무한대인지 확인. 결과는 TRUE
is.finite( var2 ) # 변수 var2가 유한한 값인지 확인. 결과는 FALSE.
# var2는 무한대 상태

is.nan( var4 ) # 양의 무한대 나누기 음의 무한대가 NaN인지 확인. 결과는 TRUE.
# 무한대끼리의 나누기는 수치화 할 수 없음
is.null( var5 ) # 변수 var5가 NULL인지 확인. 결과는 TRUE

# 벡터 - 생성하기
  # c() - 인수로 전달받은 데이터를 원소로 하는 벡터 생성, 다른 벡터를 인수로 전달할때 사용
  # seq(from = , to = , by = ) -from~to까지 by만큼 증가/감소하는 벡터 생성
  # seq(0, 1, length = ) - from~to까지의 자료를 length로 등분한 값들의 벡터 생성
  # rep(c(), times = ) - 전달한 벡터 전체를 times만큼 반복한 벡터 생성
  # rep(c(), each = ) - 전달한 각 벡터는 Each번 반목한 벡터 생성

c(1,2,3,c(4,5)) 
seq(from = 0 , to = 1, by = 0.1) 
seq(0, 1, length = 10 )
rep(c(1, 2), times = 2)
rep(c(1, 2), each = 2)

# R에서 벡터와 팩터의 차이

# 1. 벡터 (Vector):
# - 기본적인 데이터 구조로, 동일한 데이터 유형의 원소들을 순차적으로 나열한 것입니다.
# - 예를 들어, 숫자, 문자, 논리 값 등으로 구성될 수 있습니다.
# - 생성 예: c(1, 2, 3)

# 2. 팩터 (Factor):
# - 범주형 데이터를 저장하는데 사용되는 데이터 구조입니다.
# - 주로 통계 모델링에서 사용되며, 각 범주를 정수로 인코딩합니다.
# - 생성 예: factor(c("A", "B", "A", "C"))
# - 팩터는 범주 간의 순서를 정의할 수 있으며, 이를 통해 더 효율적인 메모리 사용과 특정 통계적 분석을 가능하게 합니다.

# 요약:
# - 벡터는 연속적인 데이터 값의 모음
# - 팩터는 특정 범주를 가지는 데이터로, 주로 범주형 변수를 나타낼 때 사용



# 배열과 행렬
vec <- 1:24

arr1 <- array(vec, dim = c(3,4,2)) # dim = c(행,열 면)
arr1
dim(arr1)

vec1 <- 1:24
arr1 <- array(vec1, dim = c(3,4,2))
arr1
dim(arr1)
# 열을 먼저 채워 나가는게 R의 기본이지만 byrow = TRUE로 행부터 채우는 것으로 변경 가능
mat1 <- matrix(vec1, nrow = 6)
mat1

mat2 <- matrix(vec1, nrow = 6, byrow = TRUE)
mat2

# 데이터 프레임
# R에서 데이터 프레임과 행렬의 차이

# 1. 행렬 (Matrix):
# - 동일한 데이터 유형의 원소들로 구성된 2차원 배열입니다.
# - 행과 열로 구성되며, 모든 원소는 같은 유형이어야 합니다.
# - 생성 예: matrix(1:6, nrow = 2) # 2행 3열의 숫자 행렬

# 2. 데이터 프레임 (Data Frame):
# - 서로 다른 데이터 유형을 포함할 수 있는 2차원 구조입니다.
# - 각 열은 같은 길이를 가지지만, 각 열은 서로 다른 데이터 유형(숫자, 문자 등)을 가질 수 있습니다.
# - 생성 예: data.frame(Name = c("Alice", "Bob"), Age = c(25, 30)) # 이름과 나이를 가진 데이터 프레임

# 요약:
# - 행렬: 동일한 데이터 유형의 2차원 배열.
# - 데이터 프레임: 서로 다른 데이터 유형을 포함할 수 있는 2차원 표 형태.

# 이 두 구조는 각각의 용도에 맞게 사용됩니다.
# 행렬은 수치적 계산에 유용하고, 데이터 프레임은 데이터 분석과 처리에 더 적합합니다.

df1 <- data.frame(col1 = integer(), col2 = character(), col3 = double()) # 데이터 프레임의 열에 대한 형태만 설정
df1
str(df1) # 해당 프레임의 구조를 확인할 수 있는 함수 -> structure

names(df1) # 각 열의 이름 확인하기
dim(df1)# 차원 정보 (행과 열의 수) 확인하기
nrow(df1) # 행의 수를 직접 구하는 함수
ncol(df1)# 열의 수를 직접 구하는 함수

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

vec <- c(1,5,2,3)
mat <- matrix(rep(vec, 3), ncol = 3)
df<- data.frame(id = 1:4, col1 = vec, col2 = factor(vec))
df
str(df)
dim(df)
nrow(df)
ncol(df)

lst = list(elem1 = vec, elem2 = mat, elem3 = df)
lst
str(lst)
length(lst)
names(lst)
dim(lst) #list의 경우 dim() 출력은 NULL이다.

# 세기와 비율
iris$Species
table(iris$Species) # table() 함수를 통해서 count하여 그 결과를 알려줌
prop.table(table(iris$Species)) # table() 함수를 인수로 하여 비율을 알려줌


resp.str <- c('매우 불만족', "매우 만족", '보통', '부족함')
resp.str

resp <-c(1,5,4,2)
resp.fct <- factor(resp, levels = 1: 5, labels = c('매우 불만족', "불만족", '보통', '만족', '매우 만족'))
resp.fct

as.numeric(resp.fct)
as.numeric(resp.str)


# 평균과 중앙값 -> 평균과 중앙값의 개념 차이를 잘 알고 넘어가자
mean(iris$Sepal.Length)
median(iris$Sepal.Length)

cars
str(cars)
plot(cars)
# 상관관계
  # -1, 1인 경우, 완전 상관
  # +-0.5 ~ +-1인 경우, 높은 상관
  # 0 ~ +-0.3인경우, 낮은 상관
  # 0인 경우, 상관 없음.
cor(cars$speed, cars$dist)  # 상관계수를 구하는 함수
