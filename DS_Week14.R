# 1. 문서 분류

# Page 5

library(tm)
library(rpart)
library(randomForest)
library(text2vec)
library(caret)


str(movie_review)

head(movie_review)



# Page 6

train_list = createDataPartition(y= movie_review$sentiment, p = 0.6, list =  FALSE)
mtrain = movie_review[train_list, ]
mtest = movie_review[-train_list, ]

doc = Corpus(VectorSource(mtrain$review))
doc = tm_map(doc, content_transformer(tolower))
doc = tm_map(doc, removeNumbers)
doc = tm_map(doc, removeWords, stopwords('english'))
doc = tm_map(doc, removePunctuation)
doc = tm_map(doc, stripWhitespace)
dtm = DocumentTermMatrix(doc)
dim(dtm)


str(dim)



# Page 7

inspect(dtm)



# Page 8

dtm_small = removeSparseTerms(dtm, 0.90)
X = as.matrix(dtm_small)
dataTrain = as.data.frame(cbind(mtrain$sentiment, X))
dataTrain$V1 = as.factor(dataTrain$V1)
colnames(dataTrain)[1] = 'y'



# Page 9

r = rpart(y~., data = dataTrain)
f = randomForest(y~., data = dataTrain)
printcp(r)



# Page 10

par(mfrow = c(1, 1), xpd = NA)
plot(r)
text(r, use.n = TRUE)



# Page 11

docTest = Corpus(VectorSource(mtest$review))
docTest = tm_map(docTest, content_transformer(tolower))
docTest = tm_map(docTest, removeNumbers)
docTest = tm_map(docTest, removeWords, stopwords('english'))
docTest = tm_map(docTest, removePunctuation)
docTest = tm_map(docTest, stripWhitespace)

dtmTest = DocumentTermMatrix(docTest, control=list(dictionary=dtm_small$dimnames$Terms))

dim(dtmTest)

str(dtmTest)
inspect(dtmTest)



# Page 12

X = as.matrix(dtmTest)
dataTest = as.data.frame(cbind(mtest$sentiment, X))
dataTest$V1 = as.factor(dataTest$V1)
colnames(dataTest)[1] = 'y'
pr = predict(r, newdata = dataTest, type = 'class')
table(pr, dataTest$y)

pf = predict(f, newdata = dataTest)
table(pf, dataTest$y)





# 2. 영어 텍스트 마이닝을 이용한 한국어 처리

# Page 13

library(XML)
library(wordcloud2)
library(SnowballC)
library(RCurl)
t = readLines('https://ko.wikipedia.org/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0')
d = htmlParse(t, asText = TRUE)
clean_doc = xpathSApply(d, "//p", xmlValue)

doc = Corpus(VectorSource(clean_doc))

doc = tm_map(doc, content_transformer(tolower))
doc = tm_map(doc, removeNumbers)
doc = tm_map(doc, removePunctuation)
doc = tm_map(doc, stripWhitespace)



# Page 14

dtm = DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)



# Page 15

m = as.matrix(dtm)
v = sort(colSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)
d1 = d[1:500, ]                
wordcloud2(d1)





# 3. 한국어 텍스트 마이닝

# Page 16

install.packages("KoNLP")



# Page 18

install.packages("RcppMeCab")
install.packages("XML")

library(RcppMeCab)
library(XML)
library(wordcloud2)

# 위키피디아 URL
url <- "https://ko.wikipedia.org/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0"

# HTML 문서 읽기
wiki_html <- readLines(url, encoding = "UTF-8")
wiki_parsed <- htmlParse(wiki_html, asText = TRUE)

# 문서 내용 추출
clean_doc <- xpathSApply(wiki_parsed, "//p", xmlValue)

# 특수문자 제거 및 전처리
clean_doc <- gsub("[^가-힣 ]", "", clean_doc)
clean_doc <- clean_doc[nchar(clean_doc) > 0]

# 형태소 분석 및 명사 추출
pos_result <- pos(clean_doc, format = "data.frame")
nouns <- pos_result$token[pos_result$pos == "NNG" | pos_result$pos == "NNP"]

# 명사 빈도 계산
noun_freq <- table(nouns)
sorted_freq <- sort(noun_freq, decreasing = TRUE)

# 데이터프레임 생성
noun_df <- data.frame(word = names(sorted_freq), freq = as.numeric(sorted_freq))

# 상위 100개의 단어만 선택
top_nouns <- noun_df[1:min(100, nrow(noun_df)), ]

# 단어구름 생성
wordcloud2(top_nouns, size = 1, color = "random-light")


install.packages("wordcloud")


# 필요한 라이브러리 로드
library(XML)         # HTML 파싱
library(tm)          # 텍스트 전처리
library(wordcloud)   # 워드 클라우드 생성
library(RColorBrewer) # 색상 팔레트
install.packages("showtext")

library(showtext)

# 폰트 추가
font_add("nanumgothic", "/System/Library/Fonts/Supplemental/AppleSDGothicNeo.ttc") # Apple SD Gothic Neo
showtext_auto(enable = TRUE)

# 워드 클라우드 생성
wordcloud(words = top_100$word, freq = top_100$freq, 
          min.freq = 1, random.order = FALSE, 
          rot.per = 0.35, colors = brewer.pal(8, "Dark2"), 
          family = "nanum")  # 폰트 이름 지정


# URL 설정
url <- "https://ko.wikipedia.org/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0"

# HTML 문서 읽기
html_doc <- readLines(url, encoding = "UTF-8")
html_parsed <- htmlParse(html_doc, asText = TRUE)

# 문서 내용 추출
clean_doc <- xpathSApply(html_parsed, "//p", xmlValue)

# 빈 문장 제거
clean_doc <- clean_doc[nchar(clean_doc) > 0]

# 텍스트 전처리 (Corpus로 변환)
corpus <- Corpus(VectorSource(clean_doc))
corpus <- tm_map(corpus, content_transformer(tolower))        # 소문자 변환
corpus <- tm_map(corpus, content_transformer(removeNumbers))  # 숫자 제거
corpus <- tm_map(corpus, content_transformer(removePunctuation)) # 구두점 제거
corpus <- tm_map(corpus, stripWhitespace)                    # 공백 제거

# Document-Term Matrix 생성
dtm <- DocumentTermMatrix(corpus)

# 상위 100개 단어 추출
term_matrix <- as.matrix(dtm)
term_sums <- sort(colSums(term_matrix), decreasing = TRUE)

# NA 제거 및 상위 100개 단어 추출
term_sums <- term_sums[!is.na(term_sums)]
top_100 <- data.frame(word = names(term_sums), freq = term_sums)[1:100, ]

# 워드 클라우드 생성
wordcloud(words = top_100$word, freq = top_100$freq, 
          min.freq = 1, random.order = FALSE, 
          rot.per = 0.35, colors = brewer.pal(8, "Dark2"))

