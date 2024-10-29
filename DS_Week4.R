# 파일 읽기

# 텍스트 파일 읽기 - 절대 경로를 사용하여 파일을 읽음
students <- read.table("C:/DS2024/data/students.txt", header = TRUE, fileEncoding = "EUC-KR")

# 텍스트 파일 읽기 - 상대 경로를 사용하여 파일을 읽음
students <- read.table("./data/students.txt", header = TRUE, fileEncoding = "EUC-KR") 
students

# 첫 번째 줄을 데이터로 간주 (헤더로 사용하지 않음)
students_noheader <- read.table("./data/students.txt", header = FALSE, fileEncoding = "EUC-KR") 
students_noheader

# 데이터 구조 확인 - 문자열이 factor로 변환되었는지 여부 등 데이터의 유형과 구조를 확인
str(students)

# 텍스트 파일을 읽을 때 문자 데이터를 factor로 변환하지 않고 문자열 그대로 유지
students <- read.table("./data/students.txt", header = TRUE, as.is = TRUE, fileEncoding = "EUC-KR") 
str(students)

# 문자열을 자동으로 factor로 변환하여 범주형 데이터로 처리 (R 4.0.0 이전의 기본 설정)
students <- read.table("./data/students.txt", header = TRUE, stringsAsFactors = TRUE, fileEncoding = "EUC-KR") 
str(students)

# 쉼표(,)를 구분 기호로 사용하는 CSV 파일 읽기 - " NA" 값 때문에 `math` 열이 문자열로 인식
students1 <- read.table("./data/students1.txt", sep = ",", header = TRUE, as.is = TRUE, fileEncoding = "EUC-KR") 
str(students1)

# na.strings 인자를 사용하여 파일 내에서 "NA"를 결측값으로 처리
students1 <- read.table("./data/students1.txt", sep = ",", header = TRUE, as.is = TRUE, na.strings = "NA", fileEncoding = "EUC-KR")  
str(students1)

# 띄어쓰기가 포함된 " NA" 문자열을 결측값으로 처리 (na.strings = " NA")
students1 <- read.table("./data/students1.txt", sep = ",", header = TRUE, as.is = TRUE, na.strings = " NA", fileEncoding = "EUC-KR")  
str(students1)

# strip.white 인자를 사용해 데이터 값의 공백을 제거하여 결측값을 올바르게 인식
students1 <- read.table("./data/students1.txt", sep = ",", header = TRUE, as.is = TRUE, strip.white = TRUE, fileEncoding = "EUC-KR") 
str(students1)


# csv 파일 읽기
students <- read.csv("./data/students.csv", fileEncoding = "EUC-KR") 
students

str(students) 

# name 속성을 factor로 변경
students$name <- as.factor(students$name) 
str(students)

# name 속성을 charactor로 변경
students$name <- as.character(students$name)
str(students)

# 파일 읽을 때 charactor를 factor로 인식하지 않도록 설정
students <- read.csv("./data/students.csv", stringsAsFactors = FALSE, fileEncoding = "EUC-KR") 
str(students)





# 파일 쓰기 - 파일 생성 후 열어서 확인
students <- read.table("./data/students.txt", header = T, as.is = T, fileEncoding = "EUC-KR") 

write.table(students, file = "./data/output1.txt") 
output1 <- read.table("./data/output1.txt", header = T, as.is = T)
str(output1)

write.table(students, file = "./data/output2.txt", quote = F)
output2 <- read.table("./data/output2.txt", header = T, as.is = T)
str(output2)

write.table(students, file = "./data/output3.txt", quote = F, row.names = F) 
output3 <- read.table("./data/output3.txt", header = T, as.is = T)
str(output3)

# csv 파일로 쓰기
write.csv(students, file = "./data/output.csv", quote = F)
write.csv(students, file = "./data/output.csv", quote = F, fileEncoding = "EUC-KR")
write.csv(students, file = "./data/output.csv", quote = F, row.names = F, fileEncoding = "EUC-KR")

# 실습
students <- read.table("./data/students.txt", header = T, fileEncoding = "EUC-KR")
students$average <- (students$korean + students$english + students$math) / 3
students
write.csv(students, file = "./data/practice.csv", quote = F, row.names = F, fileEncoding = "EUC-KR")





# 조건문



# 벡터
test <- c(15, 20, 30, NA, 45)

# [] 안에 조건을 입력
test[test < 40]

# 3으로 나누어 떨어지지 않는 요소
test[test %% 3 != 0]	

test[is.na(test)]	

test[!is.na(test)]

# 2의 배수
test[test %% 2 == 0]

# 2의 배수이면서 NA가 아닌 요소
test[test %% 2 == 0 & !is.na(test)]



# 데이터 프레임
characters <- data.frame(name = c("길동", "춘향", "철수"), age = c(30, 16, 21), gender = factor(c("M", "F", "M")))

characters

# 성별이 여성인 데이터 추출
characters[characters$gender == "F",]

# 30살 미만의 남성 데이터 추출                
characters[characters$age < 30 & characters$gender == "M",]
                        


# if문 사용

# 두 가지 조건으로 나뉘는 경우
x <- 5
if(x %% 2 == 0) {
print('x는 짝수')
} else {
print('x는 홀수')
}

# 세 가지 조건으로 나뉘는 경우
x <- -1
if(x > 0) {
  print('x는 양수')	
} else if(x < 0) {
  print('x는 음수')
} else {
  print('x는 0')
}



# ifelse문 사용
x <- c(-5:5)
options(digits = 3)
sqrt(x)

sqrt(ifelse(x >= 0, x, NA))





# 반복문



# repeat문 사용

# 1부터 10까지 수 증가시키기
i <- 1	 
repeat {
  if(i > 10) {
    break
  } else {
    print(i)
    i <- i + 1 
  }
}

# while문 사용
i <- 1
while(i <= 10){ 
  print(i)
  i <- i + 1 
}

# 구구단 2단
i <- 1
while(i < 10) {
  print(paste(2, "X", i, "=", 2 * i))
  i <- i + 1
}

# for문 사용
for(i in 1:10) {
  print(i)
}  

# 구구단 2단
for(i in 1:9) {
  print(paste(2, "X", i, "=", 2 * i))
}

# 구구단 2 ~ 9단
for(i in 2:9) {
  for(j in 1:9) {
    print(paste(i, "X", j, "=", i * j))
  }
}

# 조건문과 반복문의 복합 활용 1 - 1 ~ 10 중 짝수 출력
for(i in 1:10) {
  if(i %% 2 == 0) {
    print(i)
  }
}

# 조건문과 반복문의 복합 활용 2 - 1 ~ 10 중 소수 출력
for(i in 1:10) {
  check <- 0
  for(j in 1:i) {
    if(i %% j ==0) {
      check <- check + 1
    }
  }
  if(check == 2) { 
    print(i)
  }
}

# 실습 - 조건문과 반복문의 복합 활용을 통한 데이터 정제
students <- read.csv("./data/students2.csv", fileEncoding = "EUC-KR")
students	   

# 해답
for(i in 2:4) {
  students[, i] <- ifelse(students[, i] >= 0 & students[, i] <= 100, students[, i], NA)
}

students	   





# 사용자 정의 함수

fact = function(x) { 
  fa <- 1  
  while(x > 1) {  
    fa <- fa * x   
    x <- x - 1  
  }  
  return(fa) 
}

fact(5)	  





# 데이터 정제 예제 1: 결측값 처리

# is.na 사용
str(airquality)
head(is.na(airquality))
table(is.na(airquality))
table(is.na(airquality$Temp))
table(is.na(airquality$Ozone))
mean(airquality$Temp)	
mean(airquality$Ozone)

# NA가 없는 값만 추출
air_narm <- airquality[!is.na(airquality$Ozone), ]
air_narm

mean(air_narm$Ozone)

# na.omit 사용
air_narm1 <- na.omit(airquality)
mean(air_narm1$Ozone)

# na.rm을 TRUE로 설정
mean(airquality$Ozone, na.rm = T)

options(digits = 6)

# na.omit사용한 경우와 아닌경우 결과가 다른이유 - Solar.R에도 NA가 있기 때문
table(is.na(airquality))
table(is.na(airquality$Ozone))
table(is.na(airquality$Solar.R))
air_narm <- airquality[!is.na(airquality$Ozone) & !is.na(airquality$Solar.R), ]
mean(air_narm$Ozone)





# 데이터 정제 예제 2: 이상값 처리 
patients <- data.frame(name = c("환자1", "환자2", "환자3", "환자4", "환자5"), age = c(22, 20, 25, 30, 27), gender = factor(c("M", "F", "M", "K", "F")), blood.type = factor(c("A", "O", "B", "AB", "C")))
patients

# 성별의 이상값 제거
patients_outrm <- patients[patients$gender == "M"|patients$gender == "F", ]
patients_outrm	

# 성별과 혈액형의 이상값 제거
patients_outrm1 <- patients[(patients$gender == "M"|patients$gender == "F") & (patients$blood.type == "A"|patients$blood.type == "B"|patients$blood.type == "O"|patients$blood.type == "AB"), ]
patients_outrm1	 

# 성별과 혈액형의 이상값 처리 ver.2
patients <- data.frame(name = c("환자1", "환자2", "환자3", "환자4", "환자5"), age = c(22, 20, 25, 30, 27), gender = c(1, 2, 1, 3, 2), blood.type = c(1, 3, 2, 4, 5))
patients	

# 성별의 이상값을 결측값으로 변경
patients$gender <- ifelse((patients$gender < 1|patients$gender > 2), NA, patients$gender)
patients	

# 혈액형의 이상값을 결측값으로 변경
patients$blood.type <- ifelse((patients$blood.type < 1|patients$blood.type > 4), NA, patients$blood.type)
patients

# 결측값으로 표현된 이상값을 모두 제거
patients[!is.na(patients$gender) & !is.na(patients$blood.type), ]

# boxplot 활용 이상값 처리
# airquality 데이터 boxplot
boxplot(airquality[, c(1:4)])
# Ozone의 boxplot 통계값 계산
boxplot(airquality[, 1])$stats   
# air 변수에 airquality 데이터 임시 저장
air <- airquality
# Ozone의 현재 NA 개수 확인
table(is.na(air$Ozone))          

# 이상값을 NA로 변경
air$Ozone <- ifelse(air$Ozone < 1|air$Ozone > 122, NA, air$Ozone) 
# 이상값 처리 후 NA 개수 확인: 이전 결과 대비 2개 증가
table(is.na(air$Ozone))

# NA 제거
air_narm <- air[!is.na(air$Ozone), ] 
# 이상값 제거 결과: is.na 활용한 이전 결과보다 평균 값이 감소
mean(air_narm$Ozone) 
