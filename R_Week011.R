# 1. 점추정과 구간추정

# Page 6

library(tidyverse)  # 데이터 조작과 시각화를 위한 패키지 로드

nos <- 4            # 샘플 개수 설정 (number of samples)
n_t <- 100          # 시뮬레이션 반복 수 설정 (number of trials)
set.seed(22)        # 난수 생성 시드 고정 (재현성을 위해)
rs <- rnorm(nos * n_t)  # 정규분포에서 난수 생성 (샘플 개수와 반복 수를 곱한 개수)

# 생성된 난수를 행렬로 변환 후 tibble 형식으로 변환
result <- matrix(rs, ncol = nos, byrow = TRUE) %>% as_tibble()
result  # 생성된 데이터 확인  

# Page 7

# 각 행에 대해 평균과 95% 신뢰구간 계산
result %>%
  mutate(id = 1:n_t) %>%                   # 각 행에 고유 id 부여
  rowwise() %>%                            # 행 단위로 작업
  mutate(m = mean(c_across(1:4))) %>%      # 4개의 샘플 평균 계산
  ungroup() %>%                            # 그룹화를 해제
  mutate(lwr = m - 1.96 * (1 / sqrt(nos))) %>%  # 95% 신뢰구간 하한 계산
  mutate(upr = m + 1.96 * (1 / sqrt(nos))) %>%  # 95% 신뢰구간 상 한 계산
  mutate(over = factor(ifelse(lwr * upr < 0, 0, 1))) -> n95pCI  # 신뢰구간이 0을 포함하는지 확인
n95pCI  # 결과 데이터 확인

# Page 8

# 신뢰구간 시각화
ggplot(n95pCI) +
  geom_errorbar(aes(x = id, ymin = lwr, ymax = upr, color = over),
                show.legend = FALSE) +  # 신뢰구간 에러바 표시, 범례는 숨김
  geom_hline(yintercept = 0, size = 0.2) +  # y = 0인 수평선 추가
  theme_minimal() +                         # 최소한의 테마 적용
  theme(
    panel.grid = element_blank(),           # 그리드 제거
    axis.title = element_blank()            # 축 제목 제거
  )



nos = 4
n_t = 100
set.seed(0)
rs = rnorm(nos*n_t)

result = metrix(rs, ncol = nos, byrow = T) %>% as.tibble()

result %>%
  mutate(id = 1:n_t) %>%
  rowwise() %>%
  mutate(m = mean(c_across(1:4))) %>%
  ungroup()%>%
  mutate(lwr = m - 1.96 * (1/sqrt(nos))) %>%
  mutate(upr = m + 1.96 * (1/sqrt(nos))) %>%
  mutate(over = facotr(ifelse(lwr&upr < 0, 0, 1))) -> n95pCI

ggplot(n95pCI)%>%
  geom_errorbar(aes(x = id, ymin = lwr, ymax = upr, color = over), show.legend = F)
# 2. 통계적 가설검정

# Page 14

set.seed(9)                # 난수 생성 시드 고정 (재현성을 위해)
rd <- sample(1:6, 60, replace = TRUE)  # 1~6 사이의 숫자를 60개 랜덤 샘플링
rd <- factor(rd, levels = 1:6, labels = 1:6)  # 데이터를 범주형(factor)으로 변환
table(rd)  # 각 숫자의 빈도수 확인

# Page 25

1 - pchisq(6.6, df = 5)  # 카이제곱 통계량 6.6의 p-value 계산 (자유도 5)

# Page 26

# 카이제곱 검정 실행
ct <- chisq.test(table(rd), p = rep(1/6, 6))  # 관측된 데이터와 기대 비율(1/6) 비교
ct  # 카이제곱 검정 결과 출력

# 검정 결과 속성 확인
attributes(ct)  # chisq.test 객체의 속성 확인
ct$statistic    # 카이제곱 통계량
ct$parameter    # 자유도
ct$p.value      # p-value


sct$df, ct$p.value
# Page 30

library(readxl)  # 엑셀 파일 읽기를 위한 패키지 로드

# airquality 데이터 불러오기
aq <- read_excel("./study/airquality_202107.xlsx")

# region 컬럼을 범주형(factor)으로 변환 (레벨 순서 지정)
aq$region <- factor(aq$region, levels = c("a", "b"))

# region별 pm10 데이터 요약
aq %>%
  group_by(region) %>%  # region 기준으로 그룹화
  summarise(
    n = n(),                            # 데이터 개수
    m = sprintf("%0.3f", mean(pm10)),   # pm10 평균 (소수점 3자리)
    s = sprintf("%0.4f", sd(pm10))      # pm10 표준편차 (소수점 4자리)
  )

# Page 32
var.test(aq$pm10 ~ aq$region)

t.test(aq$pm10 ~, aq$region, alternative = 'less/greater', mu = 0, val.equal = F, conf.level = 0.95)
t.test (aqfsdaf, alternative = 'less, greater', mu = 0, var.equal = T, conf.level = 0.95)
# 두 지역의 분산 동질성 검정
var.test(aq$pm10 ~ aq$region)

# Page 34

# 두 지역 간 평균 비교 t-검정 (등분산 가정하지 않음)
t.test(aq$pm10 ~ aq$region, 
       alternative = "less",     # 단측 검정 (a가 b보다 작음)
       mu = 0,                   # 귀무가설의 평균 차이
       var.equal = FALSE,        # 등분산 가정하지 않음
       conf.level = 0.95)        # 95% 신뢰수준

# 두 지역 간 평균 비교 t-검정 (등분산 가정)
t.test(aq$pm10 ~ aq$region, 
       alternative = "less",     # 단측 검정 (a가 b보다 작음)
       mu = 0,                   # 귀무가설의 평균 차이
       var.equal = TRUE,         # 등분산 가정
       conf.level = 0.95)        # 95% 신뢰수준
