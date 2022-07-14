#####  第5章 進階資料結構  #####
#####  5-1  data.frame 資料框   #####
#   https://www.gitbook.com/book/joe11051105/r_basic/details
# ---------------------------------------------------------- #
#  data.frame 是 R 軟體特有的資料結構
#  data.frame 和 Excel 試算表軟體非常類似，
#  它們都有直排的行(column)和橫排的列(row)。
#  在 R 裡，data.frame 的每一行都是由相同長度的 vector 所組成的。
#  眾多建立  data.frame  的方法中，最容易的是使用  data.frame  函數。
#  我們沿用之前的 vectors (x、y 和 q) 來建立一個簡單的 data.frame。

#  data.frame 資料框
x <- 10:1
y <- -4:5
q <- c("Hockey", "Football", "Baseball", "Curling", "Rugby",
       "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")
x
y
q
theDF <- data.frame(x, y, q)
theDF
class(theDF)

class(x)      # "integer"
class(q)      #  "character"
class(theDF)  # "data.frame"

?data.frame
# This function creates data frames

# ---------------------------------------------------------- #
# 加上欄位名稱
theDF
theDF <- data.frame(First = x, Second = y, Sport = q)
theDF
names(theDF)

names(theDF) <- c("First","Second","Sport")
theDF
names(theDF)
# ---------------------------------------------------------- #
#  data.frame是一個擁有很多屬性(attributes)的複雜物件，查看的屬性為其列和行的數量。
# R  提供了函數讓我們查看這兩個屬性:  nrow  和 ncol，
#  若我們要同時查看這兩個屬性，則可用 dim 函數。

theDF
nrow(theDF)
ncol(theDF)
dim(theDF)

# ---------------------------------------------------------- #
#   Show 欄位名稱
names(theDF)

#   Show 第三個欄位名稱
names(theDF)[3]

# ---------------------------------------------------------- #
#   Show 列位名稱(預設1 2 3通用的標引(index) )
rownames(theDF)
colnames(theDF)
names(theDF)

#   指定列位名稱
rownames(theDF) <- c("One", "Two", "Three", "Four", "Five", "Six",
                     "Seven", "Eight", "Nine", "Ten")
rownames(theDF)
theDF
# 把它們設回通用的標引(index)
rownames(theDF) <- NULL
theDF
rownames(theDF)

# ---------------------------------------------------------- #
#  通常 data.frame 會有很多列，以致無法全部顯示，head 函數可以讓 data.frame 只顯示首幾列。
# tail 最後6列


head(theDF)
head(theDF, n = 7)
tail(theDF)

# ---------------------------------------------------------- #
# ---------------------------------------------------------- #
#  由於  data.frame  的每一行皆為獨立的  vector，因此每個各自擁有自己所屬的資料型別，對此我們也可以逐一查看。
#  執行 theDF$Sport 可讓我們查看 theDF 的第三行，"$" 後是行的名稱，讓我們透過指定名稱來查看某一行的內容。

# $ 後接欄位名稱
theDF
theDF$Sport

#  執行 theDF$Sport 可讓我們查看 theDF 的第三行的內容。

# theDF$1  
# Error: unexpected numeric constant in "theDF$1"

# ---------------------------------------------------------- #
#  和 vector 相同，data.frame 可讓我們透過中括號來查看其元素，只要在中括號裡指定好所要查看的位置即可。data.frame 會要求兩個數字以查看其元素。第一個數字為列號，而第二數字為行號。

# theDF[列號, 行號]
theDF
theDF[3, 2]

# ---------------------------------------------------------- #

# 第三橫排,第二到第三直排(欄或行)
theDF
theDF[3, 2:3]

# 第二直排,第三和第五橫排
# 由於只選了一直排,其將回傳一個向量(vector)
# 因此直排名稱將不被顯示
theDF
theDF[c(3, 5), 2]

theDF[c(1, 5), 2]

theDF[c(1, 3), 2]

theDF[ 3: 5, 2]

# 第三和第五橫排,第二到三直排
theDF
theDF[c(3, 5), 2:3]

# ---------------------------------------------------------- #

# 所有第三直排的元素
# 由於只是單一直排,因此回傳一個向量(vector)
# 要查詢一整列則可指定該列的列號，行號留空即可。

theDF
theDF[, 3]

# 所有第二到第三直排的元素
theDF[, 2:3]

# 所有第二橫排的元素
theDF[2, ]

# 所有第二到第四橫排的元素
theDF
theDF[2:4, ]

# ---------------------------------------------------------- #
# 直接使用欄位名稱也可以

theDF[, c("First", "Sport")]

# ---------------------------------------------------------- #

#1 只顯示"Sport"直排
# 只有單一個直排,所以回傳一個向量vector(且為因素,factor)
theDF[, "Sport"]
class(theDF[, "Sport"])  # "factor"

#2 只指定顯示"Sport"直排
# 回傳單一直排的data.frame
theDF["Sport"]
class(theDF["Sport"])  # "data.frame"

#3 只顯示"Sport"直排
# 此也vector(且為因素,factor)
theDF[["Sport"]]
class(theDF[["Sport"]]) # "factor"

# ---------------------------------------------------------- #
# 若使用中括號且要保證所回傳的是單一行的  data.frame，則可使用其第 3 個引數:drop=FALSE

theDF[, "Sport", drop = FALSE]
class(theDF[, "Sport", drop = FALSE])  # "data.frame"
theDF[, 3, drop = FALSE]
class(theDF[, 3, drop = FALSE])  # "data.frame"

# ---------------------------------------------------------- #
#  在 4-4-2 節，我們可以看到 factor 被特別的方式所儲存。若要查看它們在 data.frame  是怎麼被表示的話，可以使用  model.matrix  來建立一些指標(或虛擬)變數(dummy  variable)。

# 


newFactor <- factor(c("Pennsylvania", "New York", "New Jersey", "New York",
                      "Tennessee", "Massachusetts", "Pennsylvania", "New York"))
class(newFactor)
model.matrix(~newFactor - 1)

?model.matrix   
#  model.matrix creates a design (or model) matrix. 

# https://joe11051105.gitbooks.io/r_basic/content/variable_and_data/data_frame.html
#### 
# data frame 基本相關函數
# 
# head：取得資料框架前六比資料(預設是 6)。
# names：修改或查詢 column 名稱。
# colnames：設定 column 名稱。
# row.names：修改或查詢 row 名稱。
# rownames：設定 row 的名稱
# summary：顯示資料基本資訊。

#### Data Frame 資料框架 補充講義  ######
#https://joe11051105.gitbooks.io/r_basic/content/variable_and_data/data_frame.html
# 利用 data.frame 建立資料框架
# 資料框架類似資料表，常當作大量資料集，例如：匯入外部檔或讀取資料庫資料等。

name <- c("Joe", "Bob", "Vicky")
age <- c("28", "26", "34")
gender <- c("Male","Male","Female")
name
age
gender
data <- data.frame(name, age, gender)
#Please compare with following code(stringsAsFactors )
data02 <- data.frame(name, age, gender, stringsAsFactors = FALSE)
View(data) # 自動點選 data 變數就會開啟資料的畫面。
edit(data)

data <- edit(data) #真正修改dataframe 的內容

#透過指標與名稱提取資料
data
class(data)
str(data)
names(data)

data[1,]

data[,1]

data[1, 1]

data[,"name"]

data[1:2,"name"]

data$name[1:2]

data$name

# 基本相關函數
# 
# head：取得資料框架前六比資料(預設是 6)。
# names：修改或查詢 column 名稱。
# colnames：設定 column 名稱。
# row.names：修改或查詢 row 名稱。
# rownames：設定 row 的名稱
# summary：顯示資料基本資訊。

colnames(data)
names(data)
names(data) <- c("Name","Age","Gender")
names(data)

rownames(data) <- LETTERS[1:3]

l = length(data$Name)

rownames(data) <- letters[1:l]

?LETTERS

summary(data)
# ---------------------------------------------------------- #
#####  5-2 List 列表   #####
#   list  可儲存任何型別和長度的資料，像是所有 numeric、character 或混合 numeric 和 character 的資料、data.frame 或者是另一個 list。

# ---------------------------------------------------------- #

# 建立三個元素的list
list1 <- list(1, 2, 3)

# 建立一個元素的list,且其唯一的 元素為一個含有三個元素的vector
list2 <-list(c(1, 2, 3))

# 建立兩個元素的list
# 第一個元素為含有三個元素的vector
# 第二個元素為含有五個元素的vector
(list3 <- list(c(1, 2, 3), 3:7))

# 兩個元素的list
# 第一元素為 data.frame
# 第二元素為含有10個元素的vector
list4 <- list(theDF, 1:10)

list4

list4[1]
list4[2]

# 三個元素的list
# 第一個為data.frame
# 第二個為vector
# 第三個為含有兩個vector的list,名為list3
list5 <- list(theDF, 1:10, list3)
list5

# ---------------------------------------------------------- #
#  lists 也可被命名。其每個元素的名稱皆可由 names 來查詢或指派。

names(list5)
names(list5) <- c("data.frame", "vector", "list")
names(list5)
list5

# ---------------------------------------------------------- #
# 若要查詢  list  中的單一元素，可以使用雙中括號，並指定所要查詢的元素所對應的號碼(位置或索引)或名稱。
list5[[1]]
list5[[2]]
list5[[3]]
list5[[4]]  # Error in list5[[4]] : subscript out of bounds

# 使用名稱
list5[["data.frame"]]
list5[["vector"]]
list5[["list"]]

list5[1]
list5["data.frame"]

# ---------------------------------------------------------- #

list6 <- list(TheDataFrame = theDF, TheVector = 1:10, TheList = list3)
names(list6)
list6

# ---------------------------------------------------------- #
# 可以用 vector 建立一個某長度的 空list

(emptyList <- vector(mode = "list", length = 4))

# ---------------------------------------------------------- #

list5[[1]]
list5[["data.frame"]]

# ---------------------------------------------------------- #
#  透過巢狀索引(nested indexing)的標示方式，可以再進一步查看當中的元素。


list5[[1]]$Sport
list5[[1]][, "Second"]
list5[[1]][, "Second", drop = FALSE]

# or
list5[[1]]$q
list5[[1]]$y
list5[[1]][, "y"]
list5[[1]][, "y", drop = FALSE]

list5[[1]]$x

# ---------------------------------------------------------- #

# 勘查其長度
length(list5)

# 附加第四個元素,並不給於名稱
list5[[4]] <- 2
length(list5)

# 附加第五個元素,並給於名稱
list5[["NewElement"]] <- 3:6
length(list5)
names(list5)
list5

# https://joe11051105.gitbooks.io/r_basic/content/variable_and_data/list.html
# ---------------------------------------------------------- #

##### list 列表 補充 #####
x <- list(a = 1, b = TRUE, c = "test", d = c(1, 2, 3))
x

# 透過指標與名稱提取資料
x[1]
class(x[1])  #"list"

x[[1]]
class(x[[1]]) #"numeric"

dim(x)     #NULL
length(x)  #4

x$b

x[[4]][1] 
# x[[4]] 取出第四個值，因為第四個值是向量，所以可以在取一次指標，取出向量的元素值。

# 基本相關函數
# 
# as.list：建立列表
# is.list：判斷是否為列表
# attributes：查看所有元素的名稱，names 也有相同功能。

attributes(x)

names(x)

# ---------
#####  5-3 Matrix 矩陣  #####
#  matrix(矩陣)是統計學中很重要的數學結構。它和  data.frame  類似，都是由列和行所構成的。
#  不同的是，matrix  裡的每一個元素，不管是否在同一行裡，都必須是同樣的資料型別，matrix  也是以元素對元素作為其背後的運算操作(向量化運算) 。
# ---------------------------------------------------------- #

# 建立一個5x2 matrix
A <- matrix(1:10, nrow = 5)
A

# 建立另一個5x2 matrix
B <- matrix(21:30, nrow = 5)
B

# 建立另一個 2X10 matrix
C <- matrix(21:40, nrow = 2)
C

A
B
C

nrow(A)
ncol(A)
dim(A)
dim(B)
dim(C)

# 把它們加起來
A + B

# 把它們互相乘起來
A * B

# 勘查元素是否一樣
A == B

# ---------------------------------------------------------- #
# 矩陣乘法常被用在數學運算上，其運算規則要求左手邊的矩陣之直行個數必須對上右手邊的矩陣之橫列個數。

B
t(B)

A %*% t(B)

## A * t(B)  #Error in A * t(B) : non-conformable arrays


# ---------------------------------------------------------- #

colnames(A)
rownames(A)
colnames(A) <- c("Left", "Right")
rownames(A) <- c("1st", "2nd", "3rd", "4th", "5th")

colnames(B)
rownames(B)
colnames(B) <- c("First", "Second")
rownames(B) <- c("One", "Two", "Three", "Four", "Five")

colnames(C)
rownames(C)
colnames(C) <- LETTERS[1:10]
rownames(C) <- c("Top", "Bottom")

A
B
C

# ---------------------------------------------------------- #
A
t(A)
C
A %*% C

A * C  # Error in A * C : non-conformable arrays

# https://joe11051105.gitbooks.io/r_basic/content/variable_and_data/matrix.html

#####  matrix 矩陣 補充 #####
matrix(c(1:6), nrow = 2, ncol = 3) # 預設是按照 column 填入資料
matrix(c(1:6), nrow = 2, ncol = 3, byrow = TRUE) # 可以更改成按照 row 填入資料


m <- matrix(c(1:6), nrow = 2, ncol = 3)
m
dim(m)
length(m)  #6
names(m)   #Error in m$V1 : $ operator is invalid for atomic vectors
length(m[,1])
length(m[1,])


#透過指標提取資料
x <- c(1, 2, 3)
y <- c(4, 5, 6)

m2 <- rbind(x, y)
m2

m3 <- cbind(x,y)
m3

m3[,1] # 選取第一行(column、直)
m3[1,] # 選取第一列(row、橫)

m3
m3[1,1:2] # 選取第一列第一到二行

m3[2,2]

# 基本相關函數
# 
# t(x)：將矩陣轉置。
# %*%：矩陣相乘。
# diag：產生一個對角矩陣，或回傳矩陣的對角線向量
# det：計算矩陣行列式值，一定是要對稱矩陣。
# solve：傳回矩陣的反矩陣，非常適合解線性方程式。
# eigen：計算矩陣的特徵向量與特徵值。
# rownames：修改或查詢 row 名稱。
# colnames：修改或查詢 column 名稱。

# ---------------------------------------------------------- #
#####  5-4  Array 陣列   #####
#  Array(陣列)  其實只是一個多維度的  vector。
#  其元素必須皆為同一種資料型式，而查詢元素的方法與之前差別不大，也是使用中括號。
# ---------------------------------------------------------- #

?array
# array(data = NA, dim = length(data), dimnames = NULL)

letters
class(letters)
l <- as.array(letters)
l
class(l)
dim(l)
dim(as.array(letters))

AA <- array(1:3, c(2,4)) # recycle 1:3 "2 2/3 times"
AA

A1 <- array(1:10)
A1
dim(A1)
A1[6]

A2 <- array(1:10, dim = c(2,5,2))
A2

A3 <- array(1:10, dim = c(3,5,3))
A3

theArray <- array(1:12, dim = c(2, 3, 2))
theArray
theArray[1, , ]
theArray[1, , 1]
theArray[, , 1]

# array 與 matrix 的主要差別為  matrix 只有二個維度
# https://joe11051105.gitbooks.io/r_basic/content/variable_and_data/array.html
# ---------------------------------------------------------- #

#### Array 陣列 補充  #####
# 利用 rbind、cbind 與 array 函數建立陣列
# 陣列可視為多維度的向量變數，跟向量一樣，所有陣列元素的資料屬性必須一致。

x <- c(1, 2, 3)
y <- c(4, 5, 6)

rbind(x, y) # rbind 是利用 row(橫) 合併。
cbind(x, y) # cbind 是利用 column(直) 合併。

array(x,c(1,3)) # c(1,3) 代表產生 1 x 3 陣列
array(x,c(2,3)) # c(2,3) 代表產生 2 x 3 陣列

array(x,c(3,3)) # c(3,3) 代表產生 3 x 3 陣列

#透過指標提取資料
#陣列與向量相同，可以透過指標或名稱選取陣列的元素。

x <- c(1, 2, 3)
y <- c(4, 5, 6)

a01 <- rbind(x, y) # rbind 是利用 row(橫) 合併。
a01

a01[,1] # 選取第一行(column、直)
a01[1,] # 選取第一列(row、橫)

a01[1,1:2] # 選取第一列第一到二行

基本相關函數

# 陣列加減乘除
# length：計算陣列中的所有元素個數。
# dim：列出維度資訊
# ncol、nrow：計算(column、直) 或 (row、橫) 個數。
# aperm：將陣列轉置

#### 課後練習題 #########
### R Tutorials
# 資料來源: http://www.endmemo.com/program/R/index.php

##### 課後練習題 R Data Types #####
#######################################################################################################
##### 課後練習題 1-1 R Array      #####
#######################################################################################################
# Array is R data type which has multiple dimensions. 
# array() function creates or tests for arrays. 
# dim() function defines the dimension of an array. 
# 
# array(data=NA, dim=length(data), dimnames=NULL)
# 
# data: vector to fill the array
# dim: row and col numbers

a1 <- array(1:9)
a1
#[1] 1 2 3 4 5 6 7 8 9

a2 <- array(1:9,c(3,3))
a2
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

a3 <- 1:64
is.array(a3)
#[1] FALSE
a3
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
# [16] 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
# [31] 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
# [46] 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60
# [61] 61 62 63 64
dim(a3) <- c(2,4,8) 
#dim() converts the vector into array
is.array(a3)
#[1] TRUE
dim(a3)
#[1] 2 4 8
a3
# , , 1
# 
#       [,1] [,2] [,3] [,4]
# [1,]    1    3    5    7
# [2,]    2    4    6    8
# 
# , , 2
# 
#       [,1] [,2] [,3] [,4]
# [1,]    9   11   13   15
# [2,]   10   12   14   16
# 
# , , 3
# 
#       [,1] [,2] [,3] [,4]
# [1,]   17   19   21   23
# [2,]   18   20   22   24
# 
# , , 4
# 
#       [,1] [,2] [,3] [,4]
# [1,]   25   27   29   31
# [2,]   26   28   30   32
# 
# , , 5
# 
#       [,1] [,2] [,3] [,4]
# [1,]   33   35   37   39
# [2,]   34   36   38   40
# 
# , , 6
# 
#       [,1] [,2] [,3] [,4]
# [1,]   41   43   45   47
# [2,]   42   44   46   48
# 
# , , 7
# 
#       [,1] [,2] [,3] [,4]
# [1,]   49   51   53   55
# [2,]   50   52   54   56
# 
# , , 8
# 
#       [,1] [,2] [,3] [,4]
# [1,]   57   59   61   63
# [2,]   58   60   62   64
a3[1,,]
#       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
# [1,]    1    9   17   25   33   41   49   57
# [2,]    3   11   19   27   35   43   51   59
# [3,]    5   13   21   29   37   45   53   61
# [4,]    7   15   23   31   39   47   55   63
a3[1,2,]
#[1]  3 11 19 27 35 43 51 59
a3[1,2,1]
# [1] 3
#######################################################################################################
##### 課後練習題1-2 R Vector Data Type #####
#######################################################################################################
# R vector data type is similar to array of other programming languages. 
#It's consisted of an ordered number of elements. The elements can be numeric (integer, double), logical, character, complex, or raw.
#Vector assignment:
v1 <- c(2,3,5.5,7.1,2.1,3)
v1
#[1] 2.0 3.0 5.5 7.1 2.1 3.0

#Other vector assignment syntax:
assign("v2",c(2,3,5.5,7.1,2.1,3))
v2
#[1] 2.0 3.0 5.5 7.1 2.1 3.0 the same as v1
c(2,3,5.5,7.1,2.1,3) -> v3
v3
#[1] 2.0 3.0 5.5 7.1 2.1 3.0 the same as v1 and v2

### The 1st element of R vector is indexed as 1, not 0 as some other programming languages.
# Access the 3rd elements of vector v:
v1[3]

### R can operate vector like a single element. e.g.
1/v1
#[1] 0.5000000 0.3333333 0.1818182 0.1408451 0.4761905 0.3333333
2+v1
#[1] 4.0 5.0 7.5 9.1 4.1 5.0
v4 <- v1 + 1/v1 + 5
v4
#[1]  7.500000  8.333333 10.681818 12.240845  7.576190  8.333333

### Judge a data structure is vector or not:
is.vector(v1)
#[1] TRUE
is.vector(3,mode="any")
#[1] TRUE
is.vector(3,mode="list")
# [1] FALSE

#Under default mode "any", logical, number, character are treated as vectors with length 1. It will retrun FALSE only if the object being judged has name attribute. Under mode "numeric", is.vector will return true for vectors of types integer or double. and mode "integer" can only be true for vectors of type integer.

### Other methods for generating regular vectors:
v5 <- 1:10
v5
# [1]  1  2  3  4  5  6  7  8  9 10
v6 <- rep(2,10)
v6
# [1] 2 2 2 2 2 2 2 2 2 2
v7 <- seq(1,5,by=0.5)
v7
# [1] 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
v8 <- seq(length=10,from=1,by=0.5)
v8
# [1] 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5

#######################################################################################################
##### 課後練習題1-3 R Matrix     #####
#######################################################################################################
#R matrix is a two dimensional array. 
# R has a lot of operator and functions that make matrix handling very convenient.

#Matrix assignment:
M1 <- matrix(c(3,5,7,1,9,4),nrow=3,ncol=2,byrow=TRUE)
M1
#      [,1] [,2]
# [1,]    3    5
# [2,]    7    1
# [3,]    9    4
M2 <- matrix(c(3,5,7,1,9,4),nrow=3,ncol=2,byrow=FALSE)
M2
#      [,1] [,2]
# [1,]    3    1
# [2,]    5    9
# [3,]    7    4

### Matrix row and column count:
rM <- nrow(M1)
rM
# [1] 3
cM <- ncol(M1)
cM
#[1] 2

### t(A) function returns a transposed matrix of M:
Mt <- t(M1)
Mt
#       [,1] [,2] [,3]      # a transposed matrix
# [1,]    3    7    9
# [2,]    5    1    4

# Matrix multplication:
MM <- M1 * M1
MM
#      [,1] [,2]
# [1,]    9   25
# [2,]   49    1
# [3,]   81   16

#Matrix Addition:
MA <- M1 + M1
MA
# [,1] [,2]
# [1,]    6   10
# [2,]   14    2
# [3,]   18    8

# Matrix subtraction (-) and division (/) operations ... ... 
# practice by yurself

### Sometimes a matrix need to be sorted by a specific column, which can be done by using order() function. 

# Following is a csv file example. -- sortmatrix.csv
# ,t1,t2,t3,t4,t5,t6,t7,t8
# r1,1,0,1,0,0,1,0,2
# r2,1,2,5,1,2,1,2,1
# r3,0,0,9,2,1,1,0,1
# r4,0,0,2,1,2,0,0,0
# r5,0,2,15,1,1,0,0,0
# r6,2,2,3,1,1,1,0,0
# r7,2,2,3,1,1,1,0,1

### Following R code will read in the above file into a matrix
#   , and sort it by column 4, then write to a output file., then write to a output file. 
sortMatrixDoc <- read.csv("data/sortmatrix.csv",header=T,sep=",")
class(sortMatrixDoc)
#[1] "data.frame"
sortMatrixDoc
#    X t1 t2 t3 t4 t5 t6 t7 t8
# 1 r1  1  0  1  0  0  1  0  2
# 2 r2  1  2  5  1  2  1  2  1
# 3 r3  0  0  9  2  1  1  0  1
# 4 r4  0  0  2  1  2  0  0  0
# 5 r5  0  2 15  1  1  0  0  0
# 6 r6  2  2  3  1  1  1  0  0
# 7 r7  2  2  3  1  1  1  0  1

#sort it by column 4
sortMatrixDoc[,1]
#Levels: r1 r2 r3 r4 r5 r6 r7
sortMatrixDoc[,4]
#[1]  1  5  9  2 15  3  3
sortMatrixDocDone <- sortMatrixDoc[order(sortMatrixDoc[,4]),]
sortMatrixDocDone
#    X t1 t2 t3 t4 t5 t6 t7 t8
# 1 r1  1  0  1  0  0  1  0  2
# 4 r4  0  0  2  1  2  0  0  0
# 6 r6  2  2  3  1  1  1  0  0
# 7 r7  2  2  3  1  1  1  0  1
# 2 r2  1  2  5  1  2  1  2  1
# 3 r3  0  0  9  2  1  1  0  1
# 5 r5  0  2 15  1  1  0  0  0
sortMatrixDocDone[,4]
#[1]  1  2  3  3  5  9 15

#, then write to a output file.
write.table(sortMatrixDocDone,file="data/sortmatrixOutput.txt",sep=",")
#######################################################################################################
##### 課後練習題1-4 R factor Function   #####
#######################################################################################################
# R factors variable is a vector of categorical data. 
# factor() function creates a factor variable, and calculates the categorical distribution of a vector data.
# 
# factor(x = character(), levels, labels = levels,
#        exclude = NA, ordered = is.ordered(x))
# 
#        x: a vector of data
#        ...

v <- c(1,3,5,8,2,1,3,5,3,5)
is.factor(v)
#[1] FALSE

#Calculates the categorical distribution:
factor(v)
# [1] 1 3 5 8 2 1 3 5 3 5
# Levels: 1 2 3 5 8

F <- factor(v)
F
# [1] 1 3 5 8 2 1 3 5 3 5
# Levels: 1 2 3 5 8
is.factor(F)
#[1] TRUE

#Select levels:
SF <- factor(F, levels=c(2,1))
SF
##[1] 1    3    5    8    2    1    3    5    3    5
# [1] 1    <NA> <NA> <NA> 2    1    <NA> <NA> <NA> <NA>
# Levels: 2 1

#Change the level value:
levels(SF)
#[1] "2" "1"
levels(SF) <- c("two","one")
SF
# [1] one  <NA> <NA> <NA> two  one  <NA> <NA> <NA> <NA>
# Levels: two one
#######################################################################################################
##### 課後練習題1-5 R Data Frame Data Type   #####
#######################################################################################################
#R data.frame is a powerful data type, especially when processing table (.csv). 
#It can store the data as row and columns according to the table. 
#The difference between data frame and matrix is that the column data of matrix are the same, while the column data of data frame may be of different modes and attributes.

#Let's use the R Data Sets BOD (Biochemical Oxygen Demand), which is a data frame:
bod <- BOD
is.matrix(bod)
#[1] FALSE
is.data.frame(bod)
#[1] TRUE
class(bod)
#[1] "data.frame"
bod
# Time demand
# 1    1    8.3
# 2    2   10.3
# 3    3   19.0
# 4    4   16.0
# 5    5   15.6
# 6    7   19.8

#as.data.frame() can coerce a list into a data frame, providing that the components of the list conforms to the restrictions of a data frame.
bod[2,]
# Time demand
# 2    2   10.3

###Each row of the data frame is a list or a data frame with one row:
y <- bod[2,]
is.list(y)
#[1] TRUE
y
# Time demand
# 2    2   10.3
is.data.frame(y)
# [1] TRUE

#Access the column of the data frame:
names(bod)
#[1] "Time"   "demand"
bod$Time
#[1] 1 2 3 4 5 7
bod$demand
#[1]  8.3 10.3 19.0 16.0 15.6 19.8

### A convenient way to access the columns of a data frame is using attach(), detach() statement. e.g. after attach(x), the column x$demand can be accessed by simply typing demand.
attach(bod)
Time
#[1] 1 2 3 4 5 7
demand
#[1]  8.3 10.3 19.0 16.0 15.6 19.8

### n other words, attach() statement makes the components of the data frame visible. We can do some operations with the variable demand, and the components demand of the data frame will not be changed.
demand <- demand + 10
demand
#[1] 18.3 20.3 29.0 26.0 25.6 29.8
bod$demand
#[1]  8.3 10.3 19.0 16.0 15.6 19.8 #the data frame is not changed.

#Statement detach() is the reverse statement of attach().
detach(bod)
demand

#data.frame is the default data type when you read in a table. #Following is a csv table file dataframe.csv, there are "Expression" value vs Subtype "A", "B" and "C" in column 1 and column 2:
df <- read.csv("data/dataframe.csv",header=T,sep="\t")
is.data.frame(df)
#[1] TRUE
df
# Subtype Expression
# 1        A      -0.54
# 2        A      -0.80
# 3        A      -1.03
# 4        B      -1.34
# 5        B      -0.72
# 6        B      -0.47
# 7        B       0.10
# 8        B       0.15
# 9        C       1.67
# 10       C       0.81
# 11       C      -1.81
# 12       C      -1.18
#######################################################################################################
##### 課後練習題1-6 R List Data Type     #####
#######################################################################################################
#R list data type refers to an object consisting of an ordered collection of elements. 
#The elements may be of different mode or type.

#Let's create a list containing numeric, character and vector data types:
l <- list(batch=3,label="Lung Cancer Patients", subtype=c("A","B","C"))
l
# $batch
# [1] 3
# 
# $label
# [1] "Lung Cancer Patients"
# 
# $subtype
# [1] "A" "B" "C"
is.list(l)
# [1] TRUE

#The elements of list data type are indexed by numbers. e.g. x[[1]] refers to 3 ...
l[1]
# $batch
# [1] 3
l[[1]]   #get the values of list element
#[1] 3
class(l[1])
#[1] "list"
class(l[[1]])
#[1] "numeric"
dim(l[[1]])
#NULL
length(l[[1]])
#[1] 1

l[2]
# $label
# [1] "Lung Cancer Patients"
l[[2]]   #get the values of list element
# [1] "Lung Cancer Patients"
class(l[[2]])
#[1] "character"
dim(l[[2]])
#NULL
length(l[[2]])
#[1] 1

l[[3]]
#[1] "A" "B" "C"
class(l[[3]])
#[1] "character"
length(l[[3]])
#[1] 3
l[[3,1]]
#Error in l[[3, 1]] : incorrect number of subscripts
l[[3]][1]
#[1] "A"
l[[3]][2]
#[1] "B"
l[[3]][3]
#[1] "C"

###The elements of list can also be accessed by their names.
names(l)
#[1] "batch"   "label"   "subtype"
l$batch
#[1] 3
l$label
#[1] "Lung Cancer Patients"
l$subtype
#[1] "A" "B" "C"
l$subtype[2]
#[1] "B"

l[["subtype"]]
#[1] "A" "B" "C"


#The statement length() calculate the total elements number of a list.
length(l)
#[1] 3
dim(l)
#NULL

### Function c() can be used for concatenating two or more lists.
l2 <- list(operator="Mary",location="New York")
l3 <- list(cost=1000.24,urgent="yes")
final_list <- c(l,l2,l3)
final_list
# $batch
# [1] 3
# 
# $label
# [1] "Lung Cancer Patients"
# 
# $subtype
# [1] "A" "B" "C"
# 
# $operator
# [1] "Mary"
# 
# $location
# [1] "New York"
# 
# $cost
# [1] 1000.24
# 
# $urgent
# [1] "yes"

length(final_list)
#[1] 7
final_list[[7]]
#[1] "yes"
final_list[7]
# $urgent
# [1] "yes"

### List to data frame: as.data.frame() can coerce a list into a data frame, providing that the components of the list conforms to the restrictions of a data frame.
df_l <- as.data.frame(l)
df_l
# batch                label subtype
# 1     3 Lung Cancer Patients       A
# 2     3 Lung Cancer Patients       B
# 3     3 Lung Cancer Patients       C
l   # please compare with df_l
# $batch
# [1] 3
# 
# $label
# [1] "Lung Cancer Patients"
# 
# $subtype
# [1] "A" "B" "C"
class(df_l)
#[1] "data.frame"

### List to matrix: as.matrix() can coerce a list into a matrix, providing that the components of the list conforms to the restrictions of a matrix.
mx_l <- as.matrix(l)
mx_l
#         [,1]                  
# batch   3                     
# label   "Lung Cancer Patients"
# subtype Character,3  
dim(mx_l)
#[1] 3 1
View(mx_l)
mx_l[3,1]
# $subtype
# [1] "A" "B" "C"
mx_l[1,1]
# $batch
# [1] 3
