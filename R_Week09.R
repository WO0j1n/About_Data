library(tidyverse)  # 데이터 처리 및 시각화를 위한 패키지 로드

# 1. 기초 확률

# Page 12 - sample() 함수의 활용
dice <- 1:6  # 주사위의 각 면 정의 (1~6)
sample(dice, size = 1)  # 주사위를 한 번 굴려 결과를 랜덤으로 선택

set.seed(9)  # 난수 생성 시드 설정 (결과를 재현 가능하도록 고정)
sample(dice, 1)  # 주사위를 한 번 굴림
sample(dice, 1)  # 동일한 시드로 또 한 번 굴림 (결과 동일)


# sample()는 기본적으로 무조건 random성을 가지고 있음
# 그렇기 때문에 set.seed()로 무조건 선행하고 sample() 후행하기
# 즉, 시선샘후
set.seed(0)
sample(dice, 1)
set.seed(0)
sample(dice, 1)

# Page 13
sample(dice, size = 2)  # 주사위를 2번 굴림 (비복원추출)
sample(dice, size = 6)  # 주사위를 6번 굴림
sample(dice, size = 12)  # 주사위를 12번 굴림 (6면만 있으므로 에러 발생)

# Page 14
sample(dice, size = 6, replace = TRUE)  # 복원추출로 주사위를 6번 굴림
sample(dice, size = 12, replace = TRUE)  # 복원추출로 주사위를 12번 굴림

# 주사위를 여러 번 굴렸을 때 결과를 분석
roll <- sample(dice, size = 12, replace = TRUE)  # 복원추출로 12번 주사위 굴림
roll  # 굴린 결과 출력

roll %>%
  table()  # 각 숫자가 나온 빈도 계산

roll %>%
  factor(levels = 1:6) %>%
  table()  # 모든 주사위 면(1~6)에 대한 빈도 계산

roll %>%
  factor(levels = 1:6) %>%
  table() %>%
  as_tibble()  # 결과를 tibble 형식으로 변환

roll %>%
  factor(levels = 1:6) %>%
  table() %>%
  as_tibble() %>%
  rename("dice" = ".") %>%  # 열 이름 변경
  ggplot() +
  geom_bar(aes(dice, n), stat = 'identity')  # 주사위 결과의 빈도를 막대 그래프로 시각화

roll  # 주사위 결과 출력


# 2. 확률변수
# Page 18
coin <- c("H", "T")  # 동전의 앞면(H), 뒷면(T) 정의

crossing(t1 = coin, t2 = coin)  # 두 번 동전을 던졌을 때 가능한 모든 경우의 수 생성
crossing(t1 = coin, t2 = coin) %>%
  mutate(x = rowSums(. == "H"))  # 각 경우에서 앞면(H)이 나온 횟수 계산

crossing(t1 = coin, t2 = coin) %>%
  mutate(x = rowSums(. == "H")) %>%
  mutate(px = 1 / n())  # 각 경우의 확률 계산 (균등 확률)


# Page 20
crossing(t1 = coin, t2 = coin) %>%
  mutate(x = rowSums(. == "H")) %>%
  mutate(px = 1 / n()) %>%
  mutate(xpx = x * px)  # 확률 가중값 계산

crossing(t1 = coin, t2 = coin) %>%
  mutate(x = rowSums(. == "H")) %>%
  mutate(px = 1 / n()) %>%
  mutate(xpx = x * px) %>%
  summarise(
    ex = sum(xpx)  # 기대값 계산
  )

# Page 21
crossing(t1 = coin, t2 = coin) %>%
  mutate(x = rowSums(. == "H")) %>%
  mutate(px = 1 / n()) %>%
  mutate(xpx = x * px) %>%
  mutate(x2px = x^2 * px) %>%  # x^2 * px 계산
  summarise(
    ex = sum(xpx),  # 기대값
    varx = sum(x2px) - ex^2  # 분산 계산
  )


# 3. 확률분포 I

# 이항분포

# Page 28
n <- 2  # 시행 횟수
p <- 0.5  # 성공 확률
x <- c(0, 1, 2)  # 가능한 성공 횟수

dbinom(x, size = n, prob = p)  # 이항분포의 확률 질량 함수(PMF) 계산

# Page 29
pbinom(x, size = n, prob = p)  # 누적 분포 함수(CDF) 계산

qbinom(c(0.25, 0.5, 0.75, 1), size = n, prob = p)  # 분위수 계산

set.seed(11)
rbinom(100, size = n, prob = p)  # 이항분포 난수 생성


# 이항분포의 확률도표 그리기
# ex1)
n <- 2
p <- 0.5
coins_pd <- tibble(
  x = 0:2,
  p = dbinom(x, size = n, prob = p)  # 이항분포 PMF 계산
)

coins_pd

# 막대 그래프 그리기
ggplot(coins_pd, aes(x = x, y = p)) +
  geom_col() +
  theme_minimal()

# 점과 선 그래프 그리기
ggplot(coins_pd, aes(x = x, y = p)) +
  geom_point() +
  geom_segment(aes(x = x, xend = x, y = 0, yend = p)) +
  scale_y_continuous(breaks = seq(0, 0.6, 0.1)) +
  labs(x = "성공 횟수", y = "확률") +
  coord_cartesian(xlim = c(-0.5, 2.5), ylim = c(0.0, 0.52)) +
  theme_minimal() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    text = element_text(family = 'appleGothic')
  )

# ex2) 시행 횟수가 큰 경우의 예시
n <- 10000  # 시행 횟수
x <- 0:n  # 가능한 성공 횟수

coins_pd <- tibble(
  x = x,
  p = dbinom(x, size = n, prob = p)  # 이항분포 PMF 계산
)
coins_pd
# 확률 가중 평균 및 분산 계산
ex <- coins_pd %>%
  mutate(xp = x * p) %>%
  summarise(ex = sum(xp)) %>%
  pull(ex)  # 기대값 계산

ex2 <- coins_pd %>%
  mutate(x2p = x^2 * p) %>%
  summarise(ex2 = sum(x2p)) %>%
  pull(ex2)  # 기대값의 제곱합 계산

varx <- ex2 - ex^2  # 분산 계산
varx

# 확률도표 시각화
ggplot(coins_pd, aes(x = x, y = p)) + 
  geom_segment(aes(x = x, xend = x, y = 0, yend = p)) +
  labs(x = "성공 횟수", y = "확률") +
  coord_cartesian(xlim = c(n / 2 - 200, n / 2 + 200)) +  # 기대값 주변 확대
  theme_minimal() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )


# 정규분포
# Page 32
mu <- 1  # 평균
sigma <- 2  # 표준편차

x <- c(mu - 1.96 * sigma, mu - sigma, mu)  # 특정 지점 계산
dnorm(x, mean = mu, sd = sigma)  # 정규분포 밀도 계산
pnorm(x, mean = mu, sd = sigma)  # 누적 분포 계산

p <- c(0.005, 0.025, 0.05)
qnorm(p, mean = mu, sd = sigma)  # 분위수 계산


# 정규분포의 확률도표 그리기
# Page 33
set.seed(5)  # 난수 생성 시드 설정
rs <- rnorm(1000, mean = mu, sd = sigma)  # 정규분포 난수 생성

# 히스토그램 시각화
tibble(x = rs) %>%
  ggplot(aes(x)) +
  geom_histogram()  # 정규분포 난수의 빈도 히스토그램

