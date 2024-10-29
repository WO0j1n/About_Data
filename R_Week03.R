char <- "R"
char

typeof(char)

is.numeric(char)
is.character(char)

lgc1 <- c(TRUE, FALSE, FALSE, TRUE)
lgc1

lgc2int <- as.integer(lgc1)
lgc2int
typeof(lgc2int)

lgc2char <- as.character(lgc1)
lgc2char
typeof(lgc2char)

char2lgc <- as.logical(lgc2char)
char2lgc
typeof(char2lgc)

char
char2lgc2 <- as.logical(char)
char2lgc2
typeof(char2lgc2)



var1 <- NA
var2 <- 1 / 0
var3 <- -var2
var4 <- var2/var3
var5 <- NULL

is.na(var1)

is.na(var2)
is.infinite(var2)
is.finite(var2)

is.infinite(var4)
is.nan(var4)

is.null(var5)



c(1, 3, 4)
c(1, 3, c(4, 5, 6))

seq(from = 0, to = 1, by = 0.1)
seq(0, 1, 0.1)
seq(0, 1, by = 0.1)
seq(from = 0, to = 1, length = 10)
seq(from = 0, to = 1, length = 11)

rep(c(1,2), times = 2)
rep(c(1,2), each = 2)



vec1 <- 1:24
vec1

arr1 <- array(vec1, dim = c(3,4,2))
arr1

dim(arr1)

mat1 <- matrix(vec1, nrow = 6)
mat1

mat2 <- matrix(vec1, nrow = 6, byrow = T)
mat2

mat3 <- matrix(vec1, ncol = 6)
mat3

mat4 <- matrix(vec1, ncol = 6, byrow = T)
mat4



df1 <- data.frame(col1 = integer(), col2 = character(), col3 = double())
df1
str(df1)
names(df1)
dim(df1)
nrow(df1)
ncol(df1)



vec <- c(1, 5, 2, 3)
mat <- matrix(rep(vec, 3), ncol = 3)
df <- data.frame(id = 1:4, col1 = vec, col2 = factor(vec))
vec
mat
df
typeof(df$col1)
typeof(df$col2)

lst <- list(elem1 = vec, elem2 = mat, elem3 = df)
lst

str(lst)
length(lst)
names(lst)
dim(lst)



iris$Species

table(iris$Species)
prop.table(table(iris$Species))



resp.str <- c("매우 불만족", "매우 만족", "보통", "불만족")
resp.str

resp <- c(1, 5, 4, 2)
resp.fct <- factor(resp, levels = 1 : 5, labels = c("매우 불만족", "불만족", "보통", "만족", "매우 만족"))
resp.fct

as.numeric(resp.fct)
as.numeric(resp.str)

resp.fct2 <- factor(test <- c(1, 2, 3, 4, 5), levels = 1 : 5, labels = c("매우 불만족", "불만족", "보통", "만족", "매우 만족"))
resp.fct2
as.numeric(resp.fct2)



iris$Sepal.Length

mean(iris$Sepal.Length)
median(iris$Sepal.Length)

ex1 <- c(1, 4, 5, 2, 3)
mean(ex1)
median(ex1)

ex2 <- c(1, 4, 8, 2, 3)
mean(ex2)
median(ex2)



x <- c(4, 1, 2, 9)
dev <- mean(x) - x
dev
sum(dev)



str(cars)
plot(cars)



cor(cars$speed, cars$dist)
