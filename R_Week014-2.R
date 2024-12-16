# Shiny와 bslib 패키지 로드 (Shiny는 웹 애플리케이션을 생성하고, bslib은 테마 관련 기능 제공)
library(shiny)
library(bslib)

# UI 정의 시작 ----
ui <- page_sidebar(  # 페이지 레이아웃을 사이드바 포함 형식으로 정의
  
  # App 제목 추가 ----
  title = "Hello Shiny!",  # 앱의 제목
  
  # 사이드바 패널 정의 ----
  sidebar = sidebar(  
    
    # 슬라이더 입력 추가 ----
    sliderInput(  # 사용자가 슬라이더를 통해 입력값을 조정할 수 있도록 설정
      inputId = "bins",  # 입력 ID, 서버에서 이 값을 참조
      label = "Number of bins:",  # 슬라이더의 라벨
      min = 1,  # 슬라이더의 최소값
      max = 50,  # 슬라이더의 최대값
      value = 30  # 슬라이더의 기본값 (초기값)
    )
  ),
  
  # 출력: 히스토그램 추가 ----
  plotOutput(outputId = "distPlot")  # 서버에서 생성된 그래프를 표시할 공간 정의
)

# 서버 로직 정의 ----
server <- function(input, output) {
  
  # 히스토그램 생성 로직 ----
  # 이 부분은 반응형으로 설정되어 input$bins 값이 변경되면 자동으로 다시 실행됨
  output$distPlot <- renderPlot({  # "distPlot" 출력 ID와 연결된 그래프 생성
    
    x <- faithful$waiting  # Old Faithful 간헐천 데이터에서 대기 시간 추출
    bins <- seq(min(x), max(x), length.out = input$bins + 1)  
    # 히스토그램의 구간(bin) 경계 계산
    # 사용자가 지정한 bin 개수를 기준으로 등간격 생성
    
    # 히스토그램 생성 ----
    hist(x, breaks = bins,  # 히스토그램의 구간(bin) 경계 지정
         col = "#007bc2",  # 막대의 색상
         border = "white",  # 막대 테두리 색상
         xlab = "Waiting time to next eruption (in mins)",  # x축 라벨
         main = "Histogram of waiting times")  # 그래프 제목
    
  })  # renderPlot 종료
  
}

# Shiny 앱 실행 ----
shinyApp(ui = ui, server = server)  # 정의된 UI와 서버 로직을 사용해 Shiny 앱 실행
