# Page 5: 정규분포에서 특정 값과 누적 확률 계산

mu <- 170 # 평균
sigma <- 4 # 표준편차

# 정규분포에서 특정 구간 값을 계산
x <- c(mu - 2 * sigma, mu - sigma, mu, mu + sigma, mu + 2 * sigma)
x # 계산된 구간 출력

# 정규분포에서 해당 x 값들의 누적 확률 계산
pnorm(x, mu, sigma)

# 표준 정규분포로 변환된 z값 계산
z <- (x - mu) / sigma
z # z-score 값 출력

# 표준 정규분포에서 z값들의 누적 확률 계산
pnorm(z, 0, 1)

# Page 7: 정규분포 그래프를 그리기 위한 데이터 생성

library(dplyr)
library(ggplot2)

mu <- 1 # 평균
sigma <- 2 # 표준편차

# 평균 ± 3표준편차 구간에서 x값 생성
x <- seq(mu - 3 * sigma, mu + 3 * sigma, by = 0.01)

# 각 x에 대한 정규분포의 밀도(p)와 누적확률(dist) 계산
p <- dnorm(x, mean = mu, sd = sigma)
dist <- pnorm(x, mean = mu, sd = sigma)

# 데이터프레임으로 변환
normal <- tibble(x = x, y = p, cy = dist)
normal

# Page 8: 정규분포 곡선 시각화

normal %>%
  ggplot(aes(x, y)) + # x: x값, y: 밀도(p)
  geom_line() + # 정규분포 곡선
  geom_hline(yintercept = 0) + # y=0 기준선
  geom_segment(aes(x = 1, xend = 1, y = 0, yend = y[x == 1]), linetype = 3, size = 0.1) + # x=1에서의 세로선
  scale_x_continuous(breaks = seq(-5, 7, by = 1)) + # x축 눈금 설정
  theme_minimal() + # 미니멀 스타일
  theme(panel.grid = element_blank(), axis.text.y = element_blank(), axis.title = element_blank())

# Page 9: 정규분포의 누적 분포 시각화

normal %>%
  ggplot(aes(x, cy)) + # x: x값, cy: 누적 분포
  geom_line() + # 누적 분포 곡선
  geom_hline(yintercept = 0, size = 0.1) + # y=0 기준선
  geom_hline(yintercept = 1, size = 0.1) + # y=1 기준선
  geom_segment(aes(x = 1, xend = 1, y = 0, yend = cy[x == 1]), linetype = 3, size = 0.1) + # x=1 세로선
  geom_segment(aes(x = -5, xend = 1, y = cy[x == 1], yend = cy[x == 1]), linetype = 3, size = 0.1) + # 수평선
  scale_y_continuous(breaks = c(0, 0.5, 1)) + # y축 눈금 설정
  theme_minimal() + # 미니멀 스타일
  theme(panel.grid = element_blank(), axis.title = element_blank())

# Page 10: 난수 생성 및 행렬 변환

nos <- 5 # 표본 크기
tt <- 10000 # 반복 수
samples <- nos * tt # 총 샘플 수

set.seed(13) # 난수 생성 시드 고정
sampling <- rnorm(samples) # 정규분포 난수 생성
samp_mat <- matrix(sampling, ncol = nos, byrow = TRUE) # 난수를 행렬 형태로 변환
round(samp_mat, 3) # 행렬 출력

# Page 11: 표본 평균 계산

means <- apply(samp_mat, 1, mean) # 각 행(표본)에 대해 평균 계산
round(means, 3) # 평균값 출력

# Page 12: 표본 평균의 평균 및 표준편차 계산

mean(means) # 표본 평균의 평균
sd(means) # 표본 평균의 표준편차
1 / sqrt(nos) # 이론적으로 계산된 표준편차

# 표본 평균 히스토그램 및 정규분포 곡선 시각화
x <- seq(-3, 3, by = 0.01)
y <- dnorm(x, 0, 1 / sqrt(nos))
tibble(sm = means) %>%
  ggplot(aes(x = sm)) +
  geom_histogram(aes(y = ..density..)) +
  geom_line(data = tibble(x, y), aes(x = x, y = y), color = "red") +
  theme_minimal() +
  theme(panel.grid = element_blank(), axis.text.y = element_blank(), axis.title = element_blank())

# Page 15: 이항분포 시각화

size <- 10 # 이항분포 시행 수
p <- 0.1 # 성공 확률

x <- 0:size # 가능한 성공 횟수
dp <- dbinom(x, size, p) # 이항분포 확률 계산

# 이항분포 히스토그램 시각화
ggplot(tibble(x, dp)) +
  geom_col(aes(x, dp)) +
  scale_x_continuous(breaks = 0:size) +
  theme_minimal() +
  theme(panel.grid = element_blank(), axis.title = element_blank())

nos <- 2 # 표본 크기
tt <- 10000 # 반복 수
samples <- nos * tt # 총 샘플 수

set.seed(21) # 난수 생성 시드 고정
sampling <- rbinom(samples, size, p) # 이항분포 난수 생성
samp_mat <- matrix(sampling, ncol = nos, byrow = TRUE) # 난수를 행렬로 변환
samp_mat
means <- apply(samp_mat, 1, mean) # 표본 평균 계산

# Page 16: 표본 평균 시각화

ex <- size * p # 기대값
sigma <- sqrt(size * p * (1 - p)) # 표준편차
x <- seq(ex - 3 * sigma, ex + 3 * sigma, by = 0.01)
y <- dnorm(x, ex, sigma / sqrt(nos)) # 정규분포 밀도 계산

# 표본 평균 히스토그램과 이론적 정규분포 곡선
tibble(sm = means) %>%
  ggplot(aes(x = sm)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.1) +
  geom_line(data = tibble(x, y), aes(x = x, y = y), color = "red") +
  scale_x_continuous(breaks = seq(0, size, 1)) +
  coord_cartesian(xlim = c(0, 10)) +
  theme_minimal() +
  theme(panel.grid = element_blank(), axis.text.y = element_blank(), axis.title = element_blank())

# Page 18: 표본 크기 증가 시 시각화

nos <- 30 # 표본 크기
tt <- 10000 # 반복 수
samples <- nos * tt # 총 샘플 수

set.seed(21) # 난수 생성 시드 고정
sampling <- rbinom(samples, size, p) # 이항분포 난수 생성
samp_mat <- matrix(sampling, ncol = nos, byrow = TRUE) # 난수를 행렬로 변환

means <- apply(samp_mat, 1, mean) # 표본 평균 계산

ex <- size * p # 기대값
sigma <- sqrt(size * p * (1 - p)) # 표준편차
x <- seq(ex - 3 * sigma, ex + 3 * sigma, by = 0.01)
y <- dnorm(x, ex, sigma / sqrt(nos)) # 정규분포 밀도 계산

# 표본 평균 히스토그램과 이론적 정규분포 곡선
tibble(sm = means) %>%
  ggplot(aes(x = sm)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.1) +
  geom_line(data = tibble(x, y), aes(x = x, y = y), color = "red") +
  scale_x_continuous(breaks = seq(0, size, 1)) +
  coord_cartesian(xlim = c(0, 10)) +
  theme_minimal() +
  theme(panel.grid = element_blank(), axis.text.y = element_blank(), axis.title = element_blank())




# Page 24: 가능한 모든 조합 생성

library(tidyr)

# x, y가 1부터 4까지일 때 모든 조합 생성
crossing(x = 1:4, y = 1:4)

# 각 조합에서 x와 y의 평균(xbar) 계산
crossing(x = 1:4, y = 1:4) %>%
  rowwise() %>%
  mutate(xbar = mean(c(x, y))) # x와 y의 평균(xbar)을 추가

# Page 25: 각 평균(xbar) 값의 빈도수 계산

crossing(x = 1:4, y = 1:4) %>%
  rowwise() %>%
  mutate(xbar = mean(c(x, y))) %>% # x와 y의 평균(xbar) 계산
  count(xbar) # 각 평균 값의 빈도수 계산

# Page 26: xbar에 대한 확률(p) 계산

crossing(x = 1:4, y = 1:4) %>%
  rowwise() %>%
  mutate(xbar = mean(c(x, y))) %>%
  count(xbar) %>% # 각 평균 값의 빈도 계산
  ungroup() %>%
  mutate(p = n / sum(n)) %>% # 각 평균의 확률 계산
  mutate(xbar_p = xbar * p) # 평균 값에 확률을 곱한 값 추가

# Page 27: 기대값 계산

crossing(x = 1:4, y = 1:4) %>%
  rowwise() %>%
  mutate(xbar = mean(c(x, y))) %>%
  count(xbar) %>%
  ungroup() %>%
  mutate(p = n / sum(n)) %>%
  mutate(xbar_p = xbar * p) %>%
  summarise(mom = sum(xbar_p)) %>% # 기대값 계산
  pull(mom) -> em # 기대값(em)을 변수에 저장
em # 기대값 출력

# Page 28: 분산과 표준편차 계산

crossing(x = 1:4, y = 1:4) %>%
  rowwise() %>%
  mutate(xbar = mean(c(x, y))) %>%
  count(xbar) %>%
  ungroup() %>%
  mutate(p = n / sum(n)) %>%
  mutate(xbar2_p = xbar^2 * p) %>% # 평균의 제곱값에 확률을 곱한 값 추가
  summarise(m2om = sum(xbar2_p)) %>% # 제곱값의 기대값 계산
  pull(m2om) -> em2 # 계산 결과를 변수 em2에 저장

sqrt(em2 - em^2) # 분산에서 제곱된 기대값을 빼고 제곱근으로 표준편차 계산

# Page 29: 개별 값의 표준편차와 표본 표준편차 비교

x <- 1:4 # 1부터 4까지의 값
dev <- x - mean(x) # 각 값에서 평균을 뺀 편차 계산
p_sd <- sqrt(sum(dev^2) / 4) # 분산을 계산하고 제곱근으로 표준편차 계산
p_sd # 전체 데이터의 표준편차 출력

p_sd / sqrt(2) # 표본 크기가 2일 때 표본 표준편차 출력

# n = 3: 세 개의 값에 대해 조합 생성 및 기대값, 표준편차 계산

crossing(x = 1:4, y = 1:4, z = 1:4) %>%
  rowwise() %>%
  mutate(xbar = mean(c(x, y, z))) %>% # 세 값의 평균 계산
  count(xbar) %>%
  ungroup() %>%
  mutate(p = n / sum(n)) %>%
  mutate(xbar_p = xbar * p) %>%
  summarise(mom = sum(xbar_p)) %>% # 기대값 계산
  pull(mom) -> em_n3 # 기대값을 변수 em_n3에 저장

crossing(x = 1:4, y = 1:4, z = 1:4) %>%
  rowwise() %>%
  mutate(xbar = mean(c(x, y, z))) %>%
  count(xbar) %>%
  ungroup() %>%
  mutate(p = n / sum(n)) %>%
  mutate(xbar2_p = xbar^2 * p) %>%
  summarise(m2om = sum(xbar2_p)) %>% # 제곱된 평균의 기대값 계산
  pull(m2om) -> em2_n3 # 결과를 변수 em2_n3에 저장

sqrt(em2_n3 - em_n3^2) # 분산에서 제곱된 기대값을 빼고 제곱근으로 표준편차 계산

p_sd / sqrt(3) # 표본 크기가 3일 때 표본 표준편차 계산
