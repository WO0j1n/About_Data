# 필요한 패키지 로드 ----
library(shiny)      # Shiny 웹 애플리케이션을 만들기 위한 패키지
library(bslib)      # Shiny의 사용자 인터페이스 테마를 위한 패키지
library(dplyr)      # 데이터 조작을 위한 패키지
library(ggplot2)    # 데이터 시각화를 위한 패키지
library(ggExtra)    # ggplot2 그래프에 주변부 그래프(마진 그래프)를 추가하는 패키지

# 펭귄 데이터셋 URL 설정 ----
penguins_csv <- "https://raw.githubusercontent.com/jcheng5/simplepenguins.R/main/penguins.csv"

# 데이터 불러오기 ----
df <- readr::read_csv(penguins_csv)  # URL에서 펭귄 데이터를 불러옴
# 산점도에 적합한 숫자형 변수만 추출 (연도 제외) ----
df_num <- df |> select(where(is.numeric), -Year)

# UI 정의 ----
ui <- page_sidebar(  # Shiny의 사이드바 레이아웃 사용
  
  # 사이드바 설정 ----
  sidebar = sidebar(
    
    # X축 변수 선택 입력 ----
    varSelectInput("xvar", "X variable", df_num, selected = "Bill Length (mm)"),
    # 사용자가 X축에 사용할 변수를 선택할 수 있도록 설정
    
    # Y축 변수 선택 입력 ----
    varSelectInput("yvar", "Y variable", df_num, selected = "Bill Depth (mm)"),
    # 사용자가 Y축에 사용할 변수를 선택할 수 있도록 설정
    
    # 종(Species) 필터링 ----
    checkboxGroupInput(
      "species", "Filter by species",  # 필터 이름
      choices = unique(df$Species),    # 선택 가능한 종 목록
      selected = unique(df$Species)    # 기본 선택: 모든 종
    ),
    
    hr(),  # 사이드바에 가로줄 추가
    
    # 종별 색상 표시 여부 선택 ----
    checkboxInput("by_species", "Show species", TRUE),
    # 체크박스: 종별 색상을 활성화할지 여부
    
    # 주변부 그래프 표시 여부 선택 ----
    checkboxInput("show_margins", "Show marginal plots", TRUE),
    # 체크박스: 주변부 그래프 활성화 여부
    
    # 스무딩 선 추가 여부 선택 ----
    checkboxInput("smooth", "Add smoother")
    # 체크박스: 스무딩 선 활성화 여부
  ),
  
  # 산점도 출력 ----
  plotOutput("scatter")  # 서버에서 생성된 산점도를 출력
)

# 서버 로직 정의 ----
server <- function(input, output, session) {
  
  # 반응형 데이터 필터링 ----
  subsetted <- reactive({
    req(input$species)  # 종 필터 입력값이 유효한지 확인
    df |> filter(Species %in% input$species)  # 선택된 종만 필터링
  })
  
  # 산점도 생성 ----
  output$scatter <- renderPlot({
    
    # 기본 ggplot 생성 ----
    p <- ggplot(subsetted(), aes(!!input$xvar, !!input$yvar)) + list(
      theme(legend.position = "bottom"),  # 범례 위치를 하단으로 설정
      if (input$by_species) aes(color = Species),  # 종별 색상을 설정 (체크박스 선택 시)
      geom_point(),  # 점 그래프 추가
      if (input$smooth) geom_smooth()  # 스무딩 선 추가 (체크박스 선택 시)
    )
    
    # 주변부 그래프 추가 ----
    if (input$show_margins) {
      margin_type <- if (input$by_species) "density" else "histogram"
      # 종별 색상이 활성화된 경우 "밀도 그래프", 비활성화된 경우 "히스토그램" 사용
      p <- ggExtra::ggMarginal(
        p, type = margin_type, margins = "both",  # 양쪽 주변부 그래프 추가
        size = 8,  # 주변부 그래프 크기 설정
        groupColour = input$by_species,  # 그룹별 색상 활성화 여부
        groupFill = input$by_species    # 그룹별 채우기 색상 활성화 여부
      )
    }
    
    p  # 최종 ggplot 반환
  }, res = 100)  # 그래프 해상도 설정 (100 dpi)
}

# Shiny 앱 실행 ----
shinyApp(ui, server)  # UI와 서버 로직을 연결하여 앱 실행
