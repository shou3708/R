### 巨量資料分析與應用 Using - R --------
### 04- 巨量資料分析與應用 Using -R-機器學習-決策樹與隨機森林(Decision Trees and Random Forest)----
# 東海大學資訊管理學系 姜自強博士

#@@@ 本章介紹如何使用package套件 party (ctree)，rpart 與 C50 和 randomForest構建預測模型。 @@@@
# 首先用套件 party建立決策樹，並使用構建的樹進行分類，
# 然後用另一種套件 rpart 來構建決策樹。之後
# 使用randomForest 套件來訓練隨機森林模型。

## 何謂 機器學習 Machine Learning? -----
#  https://technews.tw/2017/10/05/ai-machine-learning-and-deep-learning/
# 機器學習（Machine learning）
# 顧名思義機器學習就是要讓機器（電腦）像人類一樣具有學習的能力，要了解機器學習，就先回頭看看人類學習的過程，人類是如何學會辨識一隻貓的？大致上可以分為「訓練」（Training）與「預測」（Predict）兩個步驟：
# 
# 訓練（Training）：小時候父母帶著我們看標註了動物名字的圖片，我們看到一隻小動物有四隻腳、尖耳朵、長鬍子等，對照圖片上的文字就知道這是貓，如果我們不小心把老虎的照片當成貓，父母會糾正我們，因此我們就自然地學會辨識貓了，這就是我們學習的過程，也可以說是父母在「訓練」我們。
# 
# 預測（Predict）：等我們學會了辨識貓，下回去動物園看到一隻有四隻腳、尖耳朵、長鬍子的小動物，我們就知道這是貓，如果我們不小心又把老虎當成貓，父母會再次糾正我們，或者我們自己反覆比較發現其實老虎和貓是不同的，即使父母沒有告訴我們，這個是我們判斷的過程，也可以說是我們在「預測」事物。

# 機器的訓練與預測
# 要讓機器（電腦）像人類一樣具有學習與判斷的能力，就要把人類大腦學習與判斷的流程轉移到機器（電腦），基本就就是運用數據進行「訓練」與「預測」，包括下列 4 個步驟：
# 
# 1. 獲取數據：人類的大腦經由眼耳鼻舌皮膚收集大量的數據，才能進行分析與處理，機器學習也必須先收集大量的數據進行訓練。
# 
# 2. 分析數據：人類的大腦分析收集到的數據找出可能的規則，例如：下雨之後某個溫度與濕度下會出現彩虹，彩虹出現在與太陽相反的方向等。
# 
# 3. 建立模型：人類的大腦找出可能的規則後，會利用這個規則來建立「模型」（Model），例如：下雨之後某個溫度與濕度、與太陽相反的方向等，就是大腦經由學習而來的經驗，機器學習裡的「模型」有點類似我們所謂的「經驗」（Experience）。
# 
# 4. 預測未來：等學習完成了，再將新的數據輸入模型就可以預測未來，例如：以後只要下雨，溫度與濕度達到標準，就可以預測與太陽相反的方向就可能會看到彩虹。

# 機器學習的種類
# 1. 監督式學習（Supervised learning）：所有資料都有標準答案，可以提供機器學習在輸出時判斷誤差使用，預測時比較精準，就好像模擬考有提供答案，學生考後可以比對誤差，這樣聯考時成績會比較好。例如：我們任意選出 100 張照片並且「標註」（Label）哪些是貓哪些是狗，輸入電腦後讓電腦學習認識貓與狗的外觀，因為照片已經標註了，因此電腦只要把照片內的「特徵」（Feature）取出來，將來在做預測時只要尋找這個特徵（四肢腳、尖耳朵、長鬍子）就可以辨識貓了！這種方法等於是人工「分類」，對電腦而言最簡單，但是對人類來說最辛苦。
# 
# 2. 非監督式學習（Un-supervised learning）：所有資料都沒有標準答案，無法提供機器學習輸出判斷誤差使用，機器必須自己尋找答案，預測時比較不準，就好像模擬考沒有提供答案，學生考後無法比對誤差，這樣聯考時成績會比較差。例如：我們任意選出 100 張照片但是沒有標註，輸入電腦後讓電腦學習認識貓與狗的外觀，因為照片沒有標註，因此電腦必須自己嘗試把照片內的「特徵」取出來，同時自己進行「分類」，將來在做預測時只要尋找這個特徵（四隻腳、尖耳朵、長鬍子）就可以辨識是「哪類動物」了！這種方法不必人工分類，對人類來說最簡單，但是對電腦來說最辛苦，而且判斷誤差比較大。


## 何謂 決策樹 Decision Trees? -----
# 決策樹 https://zh.wikipedia.org/wiki/%E5%86%B3%E7%AD%96%E6%A0%91
# 決策樹（Decision tree）由一個決策圖和可能的結果（包括資源成本和風險）組成， 用來創建到達目標的規劃。決策樹建立並用來輔助決策，是一種特殊的樹結構。決策樹是一個利用像樹一樣的圖形或決策模型的決策支持工具，包括隨機事件結果，資源代價和實用性。它是一個算法顯示的方法。決策樹經常在運籌學中使用，特別是在決策分析中，它幫助確定一個能最可能達到目標的策略。

# 決策樹有幾種產生方法：
# 1. 分類樹分析是當預計結果可能為離散類型（例如三個種類的花，輸贏等）使用的概念。
# 2. 回歸樹分析是當局域結果可能為實數（例如房價，患者住院時間等）使用的概念。
# 3. CART分析是結合了上述二者的一個概念。CART是Classification And Regression Trees的縮寫.
# 4. en:CHAID（Chi-Square Automatic Interaction Detector）

# 舉例闡述 Play Tennis or not?

## 決策樹 Decision Trees 適用的時機? -----

### 4-1 使用package套件 party -函數ctree建立決策樹(Decision Trees with Package party with ctree()) ------- 
# 本節介紹如何在包中使用函數ctree（）構建鳶尾花(iris)資料集的決策樹
# 其中Sepal.Length，Sepal.Width，Petal.Length和Petal.Width被用來預測鳶尾花品種
# 在函數ctree（）構建決策樹，而 predict（）對新數據進行預測。
# 在建模之前，鳶尾花(iris)資料集被分成兩個子集：訓練（70％）和測試（30％）。
# 隨機種子設置為以下的固定值，以使結果可重現。

#  IRIS data ( 屬性: 5, 觀測值: 150) 

#  (C1) SepalLength : 花萼長度  --- 解釋變數 X1
#  (C2) SepalWidth :  花萼寬度  --- 解釋變數 X2
#  (C3) PetalLength : 花瓣長度  --- 解釋變數 X3
#  (C4) PetalWidth :  花瓣寬度  --- 解釋變數 X4
#  (C5) Species :     品種      --- 目標變數  Y
###

data(iris)
head(iris)
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa

pairs(iris, col = iris$Species)

# 一起來看看我們的資料分布囉!
# 基礎的plot函數可依參數的性質畫出不同的X-Y散佈圖、長條圖、盒狀圖、散佈圖矩陣：

#花萼長度(Sepal Length)與花萼寬度(Sepal Width) 散佈圖
plot(iris$Sepal.Length, iris$Sepal.Width) 
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species)

library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col = Species, shape = Species)) + geom_point(size = 5)

#品種類別(Species Class) 長條圖
plot(iris$Species)
plot(iris$Species, col = 2:4) 

ggplot(iris, aes(x=Sepal.Length)) + geom_histogram(fill = "blue")
ggplot(iris, aes(x=Sepal.Length, fill = Species)) + geom_histogram()

#品種類別(Species Class)與花萼長度(Sepal Length) 盒鬚圖
plot(iris$Species, iris$Sepal.Length) 
plot(iris$Species, iris$Sepal.Length, col = 2:4) 

ggplot(iris, aes(x=Sepal.Length, y =Sepal.Width, fill = Species)) + geom_boxplot()
ggplot(iris, aes(x=Species, y =Sepal.Length, fill = Species)) + geom_boxplot()

#散佈圖矩陣
plot(iris)
plot(iris, col = iris$Species)
pairs(iris, col = iris$Species)

#分別來看看各品種的長度散佈圖矩陣
attach(iris)
plot(Sepal.Length[Species=="setosa"],Petal.Length[Species=="setosa"], 
     pch=1 ,col="blue", xlim=c(4,8), ylim= c(0,8), 
     main="各品種的長度散佈圖", xlab= "SLen", ylab= "PLen")
points(Sepal.Length[Species=="virginica"], Petal.Length[Species== "virginica"],
       pch=3,col="green")
points(Sepal.Length[Species=="versicolor"], Petal.Length[Species== "versicolor"],
       pch=2,col="red")
legend(4,8,legend=c("setosa","versicolor","virginica"), col=c("blue","red","green"), pch=c(1,2,3))

### 4-1 作業****: 分別來看看各品種的"寬度"散佈圖矩陣? ------------
plot(Sepal.Width[Species=="setosa"],Petal.Width[Species=="setosa"], 
     pch=1 ,col="blue", xlim=c(4,8), ylim= c(0,8), 
     main="各品種的寬度散佈圖", xlab= "SWid", ylab= "PWid")
points(Sepal.Width[Species=="virginica"], Petal.Width[Species== "virginica"],
       pch=3,col="green")
points(Sepal.Width[Species=="versicolor"], Petal.Width[Species== "versicolor"],
       pch=2,col="red")
legend(4,8,legend=c("setosa","versicolor","virginica"), col=c("blue","red","green"), pch=c(1,2,3))


# 查看資料集的資料結構:
str(iris)
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

# 隨機種子設置為以下的固定值，以使結果可重現。
set.seed(1234)

# 在建模之前，鳶尾花(iris)資料集被分成兩個子集：訓練（70％）和測試（30％）。
index <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
index
# [1] 1 1 1 1 2 1 1 1 1 1 1 1 1 2 1 2 1 1 1 1 1 1 1 1 1 2 1 2 2 1 1 1 1 1 1 2 1 1 2 2 1 1 1 1 1 1 1
# [48] 1 1 2 1 1 2 1 1 1 1 2 1 2 2 1 1 1 1 2 1 1 1 1 1 2 1 2 1 1 1 1 1 1 2 1 1 1 1 2 1 1 1 2 1 2 1 1
# [95] 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 2 1 2 1 1 2 2 1 1 2 2 2 2 2 1 1 1 1 1 1 2 1 1 1 2 1 2 1 1 2 1
# [142] 2 1 1 1 1 2 1 2 1


# 驗證取樣百分比!
sum(index == 1) / length(index)  # [1] 0.7466667
sum(index == 2) / length(index)  # [1] 0.2533333

# 訓練（70％）和測試（30％）
trainData <- iris[index==1, ]
dim(trainData)   
# [1] 112   5
testData <- iris[index==2, ]
dim(testData)
# [1] 38  5

# 作業 4-1-2 請看看 sample 指令與範例練習 ------------
## sample() 取樣函數
?sample
# Random Samples and Permutations
# Description
# sample takes a sample of the specified size from the elements of x using either with or without replacement.
# Usage
# sample(x, size, replace = FALSE, prob = NULL)
x <- 1:12
# a random permutation
sample(x)
#[1]  4  3  9 11  7  5 12  2  8 10  1  6
sample(x, replace = TRUE)
#[1] 12  1  5 11 11  9 11  1 10  4  7  7
sample(c(0,1), 100, replace = TRUE)
#[1] 0 0 1 1 0 1 1 1 0 1 1 1 0 1 0 1 0 0 0 0 0 1 1 0 0 1 1 1 0 1 1 1 1 1 0 1 0 1 0 1 1 0 0 0 1
#[46] 1 1 0 0 0 1 0 0 1 1 0 1 1 1 1 0 0 1 0 0 0 0 1 1 1 0 1 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 0 0 1
#[91] 0 0 0 0 0 0 1 0 0 0
### 另一種取樣方式:
#### 使用sample()隨機抽取30% 的觀察值做測試集資料
np <- ceiling(0.3 * nrow(iris))
np  # 45
irisTestIndex <- sample(1:nrow(iris), np)  #隨機抽取30% 的觀察值做測試集 45筆 Test Dataset
length(irisTestIndex)

irisTestData <- iris[irisTestIndex, ]     #測試資料 45筆
irisTestData
dim(irisTestData)  #[1] 45  5

irisTrainData <- iris[-irisTestIndex, ]     #訓練資料 除了-irisTestIndex以外的筆數 
dim(irisTrainData) #[1] 105   5
### End of 另一種取樣方式:

# install.packages("party")
library(party)
myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(myFormula, data = trainData)

iris_ctree
#   Conditional inference tree with 4 terminal nodes
# 
# Response:  Species 
# Inputs:  Sepal.Length, Sepal.Width, Petal.Length, Petal.Width 
# Number of observations:  112 
# 
# 1) Petal.Length <= 1.9; criterion = 1, statistic = 104.643
#   2)*  weights = 40 
# 1) Petal.Length > 1.9
#   3) Petal.Width <= 1.7; criterion = 1, statistic = 48.939
#     4) Petal.Length <= 4.4; criterion = 0.974, statistic = 7.397
#       5)*  weights = 21 
#     4) Petal.Length > 4.4
#       6)*  weights = 19 
#   3) Petal.Width > 1.7
#     7)*  weights = 32 

class(iris_ctree)
# [1] "BinaryTree"
# attr(,"package")
# [1] "party"
attributes(iris_ctree)

summary(iris_ctree)

# check the prediction
table(predict(iris_ctree), trainData$Species)
#            setosa versicolor virginica
# setosa         40          0         0
# versicolor      0         37         3
# virginica       0          1        31

print(iris_ctree)
# 
#      Conditional inference tree with 4 terminal nodes
# 
# Response:  Species 
# Inputs:  Sepal.Length, Sepal.Width, Petal.Length, Petal.Width 
# Number of observations:  112 
# 
# 1) Petal.Length <= 1.9; criterion = 1, statistic = 104.643
#   2)*  weights = 40 
# 1) Petal.Length > 1.9
#   3) Petal.Width <= 1.7; criterion = 1, statistic = 48.939
#     4) Petal.Length <= 4.4; criterion = 0.974, statistic = 7.397
#       5)*  weights = 21 
#     4) Petal.Length > 4.4
#       6)*  weights = 19 
#   3) Petal.Width > 1.7
#     7)*  weights = 32 

plot(iris_ctree)

plot(iris_ctree, type="simple")


# 預測 predict on test data
testPred <- predict(iris_ctree, newdata = testData)
testPred
# [1] setosa     setosa     setosa     setosa     setosa     setosa     setosa     setosa     setosa    
# [10] setosa     versicolor versicolor versicolor versicolor versicolor versicolor versicolor versicolor
# [19] versicolor versicolor versicolor versicolor virginica  virginica  virginica  virginica  versicolor
# [28] virginica  virginica  virginica  virginica  virginica  versicolor virginica  virginica  virginica 
# [37] virginica  virginica 
# Levels: setosa versicolor virginica


table(testPred, testData$Species)
# 
# testPred     setosa versicolor virginica
#   setosa         10          0         0
#   versicolor      0         12         2
#   virginica       0          0        14

# 決策樹預測及準確率
# 我們可以使用混淆矩陣(confusion matrix)及準確率(Accuracy)觀察模型表現

# 建立混淆矩陣(confusion matrix)觀察模型表現
cm <- table(testPred, testData$Species, dnn = c("實際", "預測"))
cm
#              預測
# 實際         setosa versicolor virginica
#   setosa         10          0         0
#   versicolor      0         12         2
#   virginica       0          0        14

#整體準確率(取出對角/總數)
accuracy <- sum(diag(cm)) / sum(cm)
accuracy
# [1] 0.9473684
2/(10+12+14)
# [1] 0.05555556

### ?ctree 原廠文件-------------------
?ctree  # ************************************************************************************
# Conditional Inference Trees
# 
# Description
# 
# Recursive partitioning for continuous, censored, ordered, nominal and multivariate response variables in a conditional inference framework.
# 
# Usage
# 
# ctree(formula, data, subset = NULL, weights = NULL, 
#       controls = ctree_control(), xtrafo = ptrafo, ytrafo = ptrafo, 
#       scores = NULL)

# examples


set.seed(290875)

### regression
airq <- subset(airquality, !is.na(Ozone))
airct <- ctree(Ozone ~ ., data = airq, 
               controls = ctree_control(maxsurrogate = 3))
airct
plot(airct)
mean((airq$Ozone - predict(airct))^2)
### extract terminal node ID, two ways
all.equal(predict(airct, type = "node"), where(airct))

### classification
irisct <- ctree(Species ~ .,data = iris)
irisct
plot(irisct)
table(predict(irisct), iris$Species)

### estimated class probabilities, a list
tr <- treeresponse(irisct, newdata = iris[1:10,])

### ordinal regression
data("mammoexp", package = "TH.data")
mammoct <- ctree(ME ~ ., data = mammoexp) 
plot(mammoct)

### estimated class probabilities
treeresponse(mammoct, newdata = mammoexp[1:10,])

### survival analysis
if (require("TH.data") && require("survival")) {
    data("GBSG2", package = "TH.data")
    GBSG2ct <- ctree(Surv(time, cens) ~ .,data = GBSG2)
    plot(GBSG2ct)
    treeresponse(GBSG2ct, newdata = GBSG2[1:2,])        
}
# End of ?ctree() ****************************************************************************

## ctree() 延伸閱讀:
# Conditional Inference Trees 
# https://www.rdocumentation.org/packages/partykit/versions/1.1-1/topics/ctree

### 4-2 使用package套件 rpart 建立決策樹 ------
# install.packages("rpart")
library(rpart)

### 4-2-1 鳶尾花(iris)資料集 使用package套件 rpart 建立決策樹  ------
data(iris)
head(iris)
pairs(iris, col = iris$Species)

# 4-2-1   1.查看資料集的資料結構: ----
str(iris)
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

# 4-2-1   2. 隨機種子設置為以下的固定值，以使結果可重現。-----
set.seed(1234)

# 4-2-1   3. 在建模之前，鳶尾花(iris)資料集被分成兩個子集：訓練（70％）和測試（30％）。-----
index <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
index

# 驗證取樣百分比!
sum(index == 1) / length(index)  # [1] 0.7466667
sum(index == 2) / length(index)  # [1] 0.2533333

# 訓練（70％）和測試（30％）
trainData <- iris[index==1, ]
testData <- iris[index==2, ]

###  4-2-1   4. rpart 建立模型 ---------
myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_rpart <- rpart(myFormula, data = trainData,
                       control = rpart.control(minsplit = 10))
iris_rpart
# n= 112 
# 
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
# 
# 1) root 112 72 setosa (0.35714286 0.33928571 0.30357143)  
#   2) Petal.Length< 2.45 40  0 setosa (1.00000000 0.00000000 0.00000000) *
#   3) Petal.Length>=2.45 72 34 versicolor (0.00000000 0.52777778 0.47222222)  
#     6) Petal.Width< 1.75 40  3 versicolor (0.00000000 0.92500000 0.07500000)  
#      12) Petal.Length< 5.05 37  1 versicolor (0.00000000 0.97297297 0.02702703) *
#      13) Petal.Length>=5.05 3  1 virginica (0.00000000 0.33333333 0.66666667) *
#     7) Petal.Width>=1.75 32  1 virginica (0.00000000 0.03125000 0.96875000) *

###  4-2-1   5. rpart 不同的參數設定? 結果不同---------
iris_rpart02 <- rpart(myFormula, data = trainData,
                    method = "class")
iris_rpart02
# n= 112 
# 
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
# 
# 1) root 112 72 setosa (0.3571429 0.3392857 0.3035714)  
#   2) Petal.Length< 2.45 40  0 setosa (1.0000000 0.0000000 0.0000000) *
#   3) Petal.Length>=2.45 72 34 versicolor (0.0000000 0.5277778 0.4722222)  
#     6) Petal.Width< 1.75 40  3 versicolor (0.0000000 0.9250000 0.0750000) *
#     7) Petal.Width>=1.75 32  1 virginica (0.0000000 0.0312500 0.9687500) *

attributes(iris_rpart)
# $names
# [1] "frame"               "where"               "call"                "terms"              
# [5] "cptable"             "method"              "parms"               "control"            
# [9] "functions"           "numresp"             "splits"              "variable.importance"
# [13] "y"                   "ordered"            
# 
# $xlevels
# named list()
# 
# $ylevels
# [1] "setosa"     "versicolor" "virginica" 
# 
# $class
# [1] "rpart"

###  4-2-1   6.  顯示決策樹的 cp 值，錯誤率及各節點的詳細資料： -----

summary(iris_rpart)
# Call:
#     rpart(formula = myFormula, data = trainData, control = rpart.control(minsplit = 10))
# n= 112 
# 
#           CP nsplit  rel error     xerror       xstd
# 1 0.52777778      0 1.00000000 1.15277778 0.06438675
# 2 0.41666667      1 0.47222222 0.55555556 0.07042952
# 3 0.01388889      2 0.05555556 0.08333333 0.03309688
# 4 0.01000000      3 0.04166667 0.08333333 0.03309688
# 
# Variable importance
# Petal.Width Petal.Length Sepal.Length  Sepal.Width 
#          33           32           20           15 
# 
# Node number 1: 112 observations,    complexity param=0.5277778
# predicted class=setosa      expected loss=0.6428571  P(node) =1
# class counts:    40    38    34
# probabilities: 0.357 0.339 0.304 
# left son=2 (40 obs) right son=3 (72 obs)
# Primary splits:
#     Petal.Length < 2.45 to the left,  improve=38.61111, (0 missing)
#     Petal.Width  < 0.8  to the left,  improve=38.61111, (0 missing)
#     Sepal.Length < 5.45 to the left,  improve=27.51111, (0 missing)
#     Sepal.Width  < 3.35 to the right, improve=17.45804, (0 missing)
# Surrogate splits:
#     Petal.Width  < 0.8  to the left,  agree=1.000, adj=1.000, (0 split)
#     Sepal.Length < 5.45 to the left,  agree=0.929, adj=0.800, (0 split)
#     Sepal.Width  < 3.35 to the right, agree=0.848, adj=0.575, (0 split)
# 
# Node number 2: 40 observations
# predicted class=setosa      expected loss=0  P(node) =0.3571429
#    class counts:    40     0     0
#   probabilities: 1.000 0.000 0.000 
# 
# Node number 3: 72 observations,    complexity param=0.4166667
# predicted class=versicolor  expected loss=0.4722222  P(node) =0.6428571
# class counts:     0    38    34
# probabilities: 0.000 0.528 0.472 
# left son=6 (40 obs) right son=7 (32 obs)
# Primary splits:
#     Petal.Width  < 1.75 to the left,  improve=28.401390, (0 missing)
# Petal.Length < 4.75 to the left,  improve=25.263500, (0 missing)
# Sepal.Length < 7.05 to the left,  improve= 6.469534, (0 missing)
# Sepal.Width  < 2.45 to the left,  improve= 2.919192, (0 missing)
# Surrogate splits:
#     Petal.Length < 4.75 to the left,  agree=0.917, adj=0.812, (0 split)
# Sepal.Length < 6.35 to the left,  agree=0.708, adj=0.344, (0 split)
# Sepal.Width  < 2.95 to the left,  agree=0.667, adj=0.250, (0 split)
# 
# Node number 6: 40 observations,    complexity param=0.01388889
# predicted class=versicolor  expected loss=0.075  P(node) =0.3571429
# class counts:     0    37     3
# probabilities: 0.000 0.925 0.075 
# left son=12 (37 obs) right son=13 (3 obs)
# Primary splits:
#     Petal.Length < 5.05 to the left,  improve=2.27072100, (0 missing)
# Petal.Width  < 1.55 to the left,  improve=1.20714300, (0 missing)
# Sepal.Length < 5.25 to the right, improve=0.43288290, (0 missing)
# Sepal.Width  < 2.45 to the left,  improve=0.07941176, (0 missing)
# 
# Node number 7: 32 observations
# predicted class=virginica   expected loss=0.03125  P(node) =0.2857143
# class counts:     0     1    31
# probabilities: 0.000 0.031 0.969 
# 
# Node number 12: 37 observations
# predicted class=versicolor  expected loss=0.02702703  P(node) =0.3303571
# class counts:     0    36     1
# probabilities: 0.000 0.973 0.027 
# 
# Node number 13: 3 observations
# predicted class=virginica   expected loss=0.3333333  P(node) =0.02678571
# class counts:     0     1     2
# probabilities: 0.000 0.333 0.667 


print(iris_rpart$cptable)
#           CP nsplit  rel error     xerror       xstd
# 1 0.52777778      0 1.00000000 1.15277778 0.06438675
# 2 0.41666667      1 0.47222222 0.55555556 0.07042952
# 3 0.01388889      2 0.05555556 0.08333333 0.03309688
# 4 0.01000000      3 0.04166667 0.08333333 0.03309688

print(iris_rpart)
# n= 112 
# 
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
# 
# 1) root 112 72 setosa (0.35714286 0.33928571 0.30357143)  
#   2) Petal.Length< 2.45 40  0 setosa (1.00000000 0.00000000 0.00000000) *
#   3) Petal.Length>=2.45 72 34 versicolor (0.00000000 0.52777778 0.47222222)  
#     6) Petal.Width< 1.75 40  3 versicolor (0.00000000 0.92500000 0.07500000)  
#      12) Petal.Length< 5.05 37  1 versicolor (0.00000000 0.97297297 0.02702703) *
#      13) Petal.Length>=5.05 3  1 virginica (0.00000000 0.33333333 0.66666667) *
#     7) Petal.Width>=1.75 32  1 virginica (0.00000000 0.03125000 0.96875000) *

###  4-2-1   7.  決策樹視覺化- 1.畫出決策樹並標示文字 -----
plot(iris_rpart)
text(iris_rpart, use.n = T)

### 決策樹視覺化- 2. rpart有專屬的繪圖套件rpart.plot，函式是prp()
# install.packages("rpart.plot")
require(rpart.plot) 

rpart.plot(iris_rpart,
           type=2, extra="auto",
           under=FALSE, fallen.leaves=TRUE,
           digits=2, varlen=0, faclen=0,
           cex=NULL, tweak=1,
           snip=FALSE,
           box.palette="auto", shadow.col= "blue")

rpart.plot(iris_rpart,
           type=0, extra="auto",
           under=FALSE, fallen.leaves=TRUE,
           digits=2, varlen=0, faclen=3,
           cex=NULL, tweak=1,
           snip=FALSE,
           box.palette="auto", shadow.col= "blue")

prp(iris_rpart,           # 模型
    faclen = 1,           # 呈現的變數不要縮寫
    fallen.leaves = TRUE, # 讓樹枝以垂直方式呈現
    shadow.col="blue",  # 最下面的節點塗上陰影
    # number of correct classifications / number of observations in that node
    extra = 2)  

?rpart.plot
# Plot an rpart model. A simplified interface to the prp function.

#                |	rpart.plot	 |	prp	 |
#type	         |	2	         |	0	 |
#extra	         |	"auto"	     |	0	 |
#fallen.leaves	 |	TRUE	     | FALSE |
#varlen	         |	0	         |	-8	 |
#faclen	         |	0	         |	3	 |
#box.palette	 |	"auto"  	 |	0	 |
    
### 決策樹視覺化- 3. rattle 套件 fancyRpartPlot 
#install.packages("rattle")
library(rattle)
fancyRpartPlot(iris_rpart)

# 至於輸出成規則，用rattle程序包裡面的asRules函數：
asRules(iris_rpart)
# Rule number: 2 [Species=setosa cover=40 (36%) prob=1.00]
# Petal.Length< 2.45
# 
# Rule number: 7 [Species=virginica cover=32 (29%) prob=0.00]
# Petal.Length>=2.45
# Petal.Width>=1.75
# 
# Rule number: 13 [Species=virginica cover=3 (3%) prob=0.00]
# Petal.Length>=2.45
# Petal.Width< 1.75
# Petal.Length>=5.05
# 
# Rule number: 12 [Species=versicolor cover=37 (33%) prob=0.00]
# Petal.Length>=2.45
# Petal.Width< 1.75
# Petal.Length< 5.05

###  4-2-1   8.  修剪樹的分支數量-------------
iris_rpart$cptable

opt <- which.min(iris_rpart$cptable[,"xerror"])
cp <- iris_rpart$cptable[opt, "CP"]
iris_prune <- prune(iris_rpart, cp = cp)
print(iris_prune)

plot(iris_prune)
text(iris_prune, use.n=T)

fancyRpartPlot(iris_prune)

###  4-2-1   9. 顯示訓練資料的正確性： --------
speciesTrainData <- iris$Species[ index == 1]  #show 出 訓練集種類
speciesTrainData

trainPredict <- factor(predict(iris_rpart, trainData, type = "class"), levels = levels(speciesTrainData))

tableTrainData <- table(speciesTrainData, trainPredict)
tableTrainData

#                  trainPredict
# speciesTrainData setosa versicolor virginica
#       setosa         40          0         0
#       versicolor      0         36         2
#       virginica       0          1        33

#以上得知 40 筆setosa分類正確
#         36 筆versicolor分類正確
#         33 筆virginica分類正確
##        1  筆virginica分類錯誤成 versicolor
##        2  筆versicolor分類錯誤成 virginica
### 所以正確率為 (40+36+33)/112 * 100% = 97.32143%
###                     109/112 * 100% = 97.32143%

correctTrainData <- sum(diag(tableTrainData))/sum(tableTrainData) * 100
correctTrainData
# [1] 97.32143    #訓練集正確率 97.32143%

diag(tableTrainData)        #傳回對角線元素值
# setosa versicolor  virginica 
#     40         36         33 
sum(diag(tableTrainData))   #加總(對角線元素值)  # [1] 109
sum(tableTrainData)         #加總(tableTrainData所有元素值)  # [1] 112


###  4-2-1   10.  顯示測試集的正確率 ---- 
speciesTestData <- iris$Species[ index == 2 ]
speciesTestData
# [1] setosa     setosa     setosa     setosa     setosa     setosa     setosa     setosa     setosa     setosa    
# [11] versicolor versicolor versicolor versicolor versicolor versicolor versicolor versicolor versicolor versicolor
# [21] versicolor versicolor virginica  virginica  virginica  virginica  virginica  virginica  virginica  virginica 
# [31] virginica  virginica  virginica  virginica  virginica  virginica  virginica  virginica 
# Levels: setosa versicolor virginica

testPredict <- factor(predict(iris_rpart, testData, type = "class"), levels = levels(speciesTestData))
tableTestData <- table(speciesTestData, testPredict)
tableTestData
#                 testPredict
# speciesTestData setosa versicolor virginica
#      setosa         10          0         0
#      versicolor      0         12         0
#      virginica       0          1        15

correctTestData <- sum(diag(tableTestData))/sum(tableTestData) * 100
correctTestData
# [1] 97.36842     #測試集正確率 97.36842%  ## 太神了


###  除錯!
testPred <- predict(iris_rpart, newdata = testData)
testPred
table(testPred, testData$Species)  ### error
# Error in table(testPred, testData$Species) : 
# all arguments must have the same length

### 4-2-1  *** 鳶尾花(iris)資料集 延伸  自行練習 ***------
### 監督式學習 決策樹
###
#  IRIS data ( 屬性: 5, 觀測值: 150) 

#  (C1) SepalLength : 花萼長度  --- 解釋變數 X1
#  (C2) SepalWidth :  花萼寬度  --- 解釋變數 X2
#  (C3) PetalLength : 花瓣長度  --- 解釋變數 X3
#  (C4) PetalWidth :  花瓣寬度  --- 解釋變數 X4
#  (C5) Species :     品種      --- 目標變數  Y
###

library(rpart)
data(iris)
str(iris)
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
head(iris)
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa
summary(iris)
#  Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  

#### 1. 使用sample()隨機抽取10% 的觀察值做測試集資料  
np <- ceiling(0.1 * nrow(iris)) # nrow(iris)傳回iris 資料筆數
np  # 15
irisTestIndex <- sample(1:nrow(iris), np)  #隨機抽取10% 的觀察值做測試集 15筆 Test Dataset
length(irisTestIndex)
# [1] 15
irisTestIndex
# [1] 133  96  91  37  90  72 128  95  92   2  46 114  89  41  10
irisTestData <- iris[irisTestIndex, ]     #測試資料 15筆
irisTestData
# Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
# 133          6.4         2.8          5.6         2.2  virginica
# 96           5.7         3.0          4.2         1.2 versicolor
# 91           5.5         2.6          4.4         1.2 versicolor
dim(irisTestData)  #[1] 15  5
irisTrainData <- iris[-irisTestIndex, ]     #訓練資料 除了-irisTestIndex以外的筆數 
dim(irisTrainData) #[1] 135   5
head(irisTrainData, n=3)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa

### 2. 使用rpart() 建立訓練集的決策樹 irisTree  
names(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"   
irisTree <- rpart(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, method = "class", data = irisTrainData)

irisTree02 <- rpart(Species ~ ., method = "class", data = irisTrainData)

irisTree
# n= 135 
# 
# node), split, n, loss, yval, (yprob)
#        * denotes terminal node
# 
# 1) root 135 88 virginica (0.33333333 0.31851852 0.34814815)  
#   2) Petal.Length< 2.45 45  0 setosa (1.00000000 0.00000000 0.00000000) *
#   3) Petal.Length>=2.45 90 43 virginica (0.00000000 0.47777778 0.52222222)  
#     6) Petal.Width< 1.75 47  5 versicolor (0.00000000 0.89361702 0.10638298) *
#     7) Petal.Width>=1.75 43  1 virginica (0.00000000 0.02325581 0.97674419) *

####3.  顯示決策樹的cp 值，錯誤率及各節點的詳細資料： 
summary(irisTree)
# Call:
# rpart(formula = Species ~ Sepal.Length + Sepal.Width + Petal.Length + 
#           Petal.Width, data = irisTrainData, method = "class")
# n= 135 
# 
#          CP nsplit  rel error     xerror       xstd
# 1 0.5113636      0 1.00000000 1.20454545 0.05422535
# 2 0.4204545      1 0.48863636 0.54545455 0.06320198
# 3 0.0100000      2 0.06818182 0.09090909 0.03117434
# 
# Variable importance
# Petal.Width Petal.Length Sepal.Length  Sepal.Width 
#          34           31           21           15 
# 
# Node number 1: 135 observations,    complexity param=0.5113636
# predicted class=virginica   expected loss=0.6518519  P(node) =1
#    class counts:    45    43    47
#    probabilities: 0.333 0.319 0.348 
# left son=2 (45 obs) right son=3 (90 obs)
# Primary splits:
#    Petal.Length < 2.45 to the left,  improve=45.02963, (0 missing)
#    Petal.Width  < 0.8  to the left,  improve=45.02963, (0 missing)
#    Sepal.Length < 5.45 to the left,  improve=30.97379, (0 missing)
#    Sepal.Width  < 3.35 to the right, improve=17.55217, (0 missing)
# Surrogate splits:
#    Petal.Width  < 0.8  to the left,  agree=1.000, adj=1.000, (0 split)
#    Sepal.Length < 5.45 to the left,  agree=0.919, adj=0.756, (0 split)
#    Sepal.Width  < 3.35 to the right, agree=0.837, adj=0.511, (0 split)
# 
# Node number 2: 45 observations
# predicted class=setosa      expected loss=0  P(node) =0.3333333
#   class counts:    45     0     0
# probabilities: 1.000 0.000 0.000 
# 
# Node number 3: 90 observations,    complexity param=0.4204545
#   predicted class=virginica   expected loss=0.4777778  P(node) =0.6666667
# class counts:     0    43    47
# probabilities: 0.000 0.478 0.522 
# left son=6 (47 obs) right son=7 (43 obs)
# Primary splits:
#    Petal.Width  < 1.75 to the left,  improve=34.021450, (0 missing)
#    Petal.Length < 4.75 to the left,  improve=32.348360, (0 missing)
#    Sepal.Length < 6.15 to the left,  improve= 8.892593, (0 missing)
#    Sepal.Width  < 2.45 to the left,  improve= 4.011111, (0 missing)
# Surrogate splits:
#    Petal.Length < 4.75 to the left,  agree=0.900, adj=0.791, (0 split)
#    Sepal.Length < 6.15 to the left,  agree=0.722, adj=0.419, (0 split)
#    Sepal.Width  < 2.95 to the left,  agree=0.689, adj=0.349, (0 split)
# 
# Node number 6: 47 observations
# predicted class=versicolor  expected loss=0.106383  P(node) =0.3481481
#   class counts:     0    42     5
# probabilities: 0.000 0.894 0.106 
# 
# Node number 7: 43 observations
# predicted class=virginica   expected loss=0.02325581  P(node) =0.3185185
#    class counts:     0     1    42
# probabilities: 0.000 0.023 0.977 

### 4. 畫出決策樹並標示文字 
plot(irisTree)
text(irisTree)

### 5. 顯示訓練資料的正確性： 
speciesTrainData <- iris$Species[ -irisTestIndex]  #show 出 訓練集種類
speciesTrainData

trainPredict <- factor(predict(irisTree, irisTrainData, type = "class"), levels = levels(speciesTrainData))

tableTrainData <- table(speciesTrainData, trainPredict)
tableTrainData

#                 trainPredict
# speciesTrainData setosa versicolor virginica
#       setosa         45          0         0
#       versicolor      0         42         1
#       virginica       0          5        42

#以上得知 45 筆setosa分類正確
#         42 筆versicolor分類正確
#         42 筆virginica分類正確
##        5  筆virginica分類錯誤成 versicolor
##        1  筆versicolor分類錯誤成 virginica
### 所以正確率為 (45+42+42)/135 * 100% = 95.55556%
###                     129/135 * 100% = 95.55556%

correctTrainData <- sum(diag(tableTrainData))/sum(tableTrainData) * 100
correctTrainData
# [1] 95.55556    #訓練集正確率 95.55556%

diag(tableTrainData)        #傳回對角線元素值
# setosa versicolor  virginica 
#     45         42         42 
sum(diag(tableTrainData))   #加總(對角線元素值)  # [1] 129
sum(tableTrainData)         #加總(tableTrainData所有元素值)  # [1] 135


### 6. 顯示測試集的正確率  
speciesTestData <- iris$Species[ irisTestIndex ]
speciesTestData
# [1] virginica  versicolor versicolor setosa     versicolor versicolor virginica 
# [8] versicolor versicolor setosa     setosa     virginica  versicolor setosa    
# [15] setosa    
# Levels: setosa versicolor virginica

testPredict <- factor(predict(irisTree, irisTestData, type = "class"), levels = levels(speciesTestData))
tableTestData <- table(speciesTestData, testPredict)
tableTestData
#                 testPredict
# speciesTestData setosa versicolor virginica
#      setosa          5          0         0
#      versicolor      0          7         0
#      virginica       0          0         3

correctTestData <- sum(diag(tableTestData))/sum(tableTestData) * 100
correctTestData
# [1] 100     #測試集正確率 100%  ## 太神了

### 7. 使用者可以設定適當 rpart.control() 來改善決策樹分類的成效 
#      例如: rpart.control(minisplit = 5, cp = 0.0001, maxdepth = 30)
irisTreeControl <- rpart(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, method = "class", data = irisTrainData, control =  rpart.control(minisplit = 5, cp = 0.0001, maxdepth = 30))
irisTreeControl
# n= 135 
#
# node), split, n, loss, yval, (yprob)
# * denotes terminal node
# 
# 1) root 135 88 virginica (0.33333333 0.31851852 0.34814815)  
#   2) Petal.Length< 2.45 45  0 setosa (1.00000000 0.00000000 0.00000000) *
#   3) Petal.Length>=2.45 90 43 virginica (0.00000000 0.47777778 0.52222222)  
#     6) Petal.Width< 1.75 47  5 versicolor (0.00000000 0.89361702 0.10638298) *
#     7) Petal.Width>=1.75 43  1 virginica (0.00000000 0.02325581 0.97674419) *
summary(irisTree)

plot(irisTree) ;text(irisTreeControl)

speciesTrainData <- iris$Species[ -irisTestIndex]  #show 出 訓練集種類
speciesTrainData

trainPredict <- factor(predict(irisTreeControl, irisTrainData, type = "class"), levels = levels(speciesTrainData))

tableTrainData <- table(speciesTrainData, trainPredict)
tableTrainData
#            trainPredict
# speciesTrainData setosa versicolor virginica
#       setosa         44          0         0
#       versicolor      0         45         1
#       virginica       0          5        40

correctTrainData <- sum(diag(tableTrainData))/sum(tableTrainData) * 100
correctTrainData
#[1] 95.55556

### 顯示測試集的正確率  
speciesTestData <- iris$Species[ irisTestIndex ]
speciesTestData
# [1] versicolor virginica  virginica  setosa     setosa     virginica  virginica 
# [8] versicolor setosa     setosa     versicolor virginica  setosa     versicolor
# [15] setosa    
# Levels: setosa versicolor virginica

testPredict <- factor(predict(irisTreeControl, irisTestData, type = "class"), levels = levels(speciesTestData))
tableTestData <- table(speciesTestData, testPredict)
tableTestData
#               testPredict
# speciesTestData setosa versicolor virginica
#      setosa          6          0         0
#      versicolor      0          4         0
#      virginica       0          0         5


correctTestData <- sum(diag(tableTestData))/sum(tableTestData) * 100
correctTestData
#[1] 100

### End of 延伸練習 

### 4-2-2 bodyfat 身體脂肪資料集 使用package套件 rpart 建立決策樹  ------
# 在本節中使用package套件 rpart 來構建 bodyfat 身體脂肪上的決策樹數據。 
# 函數rpart（）用於構建決策樹，並選擇具有最小預測誤差的樹。 
# 之後，它被應用於新的數據用函數 predict（）進行預測。
# 首先，我們加載 bodyfat 身體脂肪數據，並看看它。

data("bodyfat", package = "TH.data")
dim(bodyfat)
# [1] 71 10

attributes(bodyfat)
# $names
# [1] "age"          "DEXfat"       "waistcirc"    "hipcirc"      "elbowbreadth" "kneebreadth" 
# [7] "anthro3a"     "anthro3b"     "anthro3c"     "anthro4"     
# 
# $row.names
# [1] "47"  "48"  "49"  "50"  "51"  "52"  "53"  "54"  "55"  "56"  "57"  "58"  "59"  "60"  "61"  "62" 
# [17] "63"  "64"  "65"  "66"  "67"  "68"  "69"  "70"  "71"  "72"  "73"  "74"  "75"  "76"  "77"  "78" 
# [33] "79"  "80"  "81"  "82"  "83"  "84"  "85"  "86"  "87"  "88"  "89"  "90"  "91"  "92"  "93"  "94" 
# [49] "95"  "96"  "97"  "98"  "99"  "100" "101" "102" "103" "104" "105" "106" "107" "108" "109" "110"
# [65] "111" "112" "113" "114" "115" "116" "117"
# 
# $class
# [1] "data.frame"


bodyfat[1:5,]
#    age DEXfat waistcirc hipcirc elbowbreadth kneebreadth anthro3a anthro3b anthro3c anthro4
# 47  57  41.68     100.0   112.0          7.1         9.4     4.42     4.95     4.50    6.13
# 48  65  43.29      99.5   116.5          6.5         8.9     4.63     5.01     4.48    6.37
# 49  59  35.41      96.0   108.5          6.2         8.9     4.12     4.74     4.60    5.82
# 50  58  22.79      72.0    96.5          6.1         9.2     4.03     4.48     3.91    5.66
# 51  60  36.42      89.5   100.5          7.1        10.0     4.24     4.68     4.15    5.91

row.names(bodyfat)

# 接下來將數據分成訓練和測試子集，並且在訓練上構建決策樹數據。

set.seed(1234)
index <- sample(2, nrow(bodyfat), replace=TRUE, prob=c(0.7, 0.3))
bodyfat.train <- bodyfat[index == 1, ]
bodyfat.test <- bodyfat[index == 2, ]

# train a decision tree
library(rpart)
myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + kneebreadth
bodyfat_rpart <- rpart(myFormula, data = bodyfat.train,
                          control = rpart.control(minsplit = 10))
attributes(bodyfat_rpart)
# $names
# [1] "frame"               "where"               "call"                "terms"              
# [5] "cptable"             "method"              "parms"               "control"            
# [9] "functions"           "numresp"             "splits"              "variable.importance"
# [13] "y"                   "ordered"            
# 
# $xlevels
# named list()

print(bodyfat_rpart$cptable)
#           CP nsplit  rel error    xerror       xstd
# 1 0.67272638      0 1.00000000 1.0194546 0.18724382
# 2 0.09390665      1 0.32727362 0.4415438 0.10853044
# 3 0.06037503      2 0.23336696 0.4271241 0.09362895
# 4 0.03420446      3 0.17299193 0.3842206 0.09030539
# 5 0.01708278      4 0.13878747 0.3038187 0.07295556
# 6 0.01695763      5 0.12170469 0.2739808 0.06599642
# 7 0.01007079      6 0.10474706 0.2693702 0.06613618
# 8 0.01000000      7 0.09467627 0.2695358 0.06620732

print(bodyfat_rpart)
# n= 56 
# 
# node), split, n, deviance, yval
# * denotes terminal node
# 
# 1) root 56 7265.0290000 30.94589  
#   2) waistcirc< 88.4 31  960.5381000 22.55645  
#     4) hipcirc< 96.25 14  222.2648000 18.41143  
#       8) age< 60.5 9   66.8809600 16.19222 *
#       9) age>=60.5 5   31.2769200 22.40600 *
#     5) hipcirc>=96.25 17  299.6470000 25.97000  
#      10) waistcirc< 77.75 6   30.7345500 22.32500 *
#      11) waistcirc>=77.75 11  145.7148000 27.95818  
#        22) hipcirc< 99.5 3    0.2568667 23.74667 *
#        23) hipcirc>=99.5 8   72.2933500 29.53750 *
#   3) waistcirc>=88.4 25 1417.1140000 41.34880  
#     6) waistcirc< 104.75 18  330.5792000 38.09111  
#      12) hipcirc< 109.9 9   68.9996200 34.37556 *
#      13) hipcirc>=109.9 9   13.0832000 41.80667 *
#     7) waistcirc>=104.75 7  404.3004000 49.72571 *

plot(bodyfat_rpart)
text(bodyfat_rpart, use.n=T)

opt <- which.min(bodyfat_rpart$cptable[,"xerror"])
opt
# 7 
# 7
cp <- bodyfat_rpart$cptable[opt, "CP"]
cp
# [1] 0.01007079


bodyfat_prune <- prune(bodyfat_rpart, cp = cp)

print(bodyfat_prune)

plot(bodyfat_prune)
text(bodyfat_prune, use.n=T)

# 之後，使用選擇的樹進行預測，並對預測值進行比較
# 與實際的標籤。 在下面的代碼中，函數abline（）繪製一條對角線。 
# 預期一個好的模型與他們的實際值相等或非常接近，即大多數點應該在對角線上或靠近對角線。
DEXfat_pred <- predict(bodyfat_prune, newdata=bodyfat.test)

xlim <- range(bodyfat$DEXfat)

plot(DEXfat_pred ~ DEXfat, data=bodyfat.test, xlab="Observed",
       ylab="Predicted", ylim=xlim, xlim=xlim)

abline(a=0, b=1, col = "red")

### 4-2-3 R上的CART Package — rpart [參數篇]  補充篇-------
# https://c3h3notes.wordpress.com/
# 演衡學習筆記
# https://c3h3notes.wordpress.com/2010/10/25/r%E4%B8%8A%E7%9A%84cart-package-rpart-%E5%8F%83%E6%95%B8%E7%AF%87/
# 在 rpart model 中大概有幾個比較重要的參數：
# 
# weights： 用來給與data的weight，如果想加重某些data的權重時可使用。 
# method：分成 “anova”、”poisson”、”class”和”exp”。
# parms：splitting function的參數，會根據上面不同的方法給不同的參數。(例如：”anova”方法是不需要參數的)
# control： rpart.control object
# 以上是rpart的參數部分，大部份都是集中在選擇model和data的權重上。
# 一旦決定方法後，在model中的重要參數，大部分都是在control中用一個rpart.control的物件進行設定的。
#     
# 接下來我們來介紹 rpart.control中的幾個重要參數：
#     
#  minsplit：每一個node最少要幾個data
#  minbucket：在末端的node上最少要幾個data
#  cp：complexity parameter. (決定精度的參數)
#  maxdepth：Tree的深度

## 基礎篇
library(rpart)
library(MASS)    # MASS::cats

data(cats)
?cats
# Anatomical Data from Domestic Cats
# Description
# The heart and body weights of samples of male and female cats used for digital is experiments. The cats were all adult, over 2 kg body weight.
# 家貓的解剖數據
# 描述
# 用於數字化的雄性和雌性貓的樣本的心臟和體重是實驗。 這些貓都是成年人，體重超過2公斤。
dim(cats)
# [1] 144   3
names(cats)
# [1] "Sex" "Bwt" "Hwt"
# Sex  sex: Factor with evels "F" and "M".
# Bwt   body weight in kg.
# Hwt   heart weight in g

plot(cats[2:3], pch = 21, bg = c("red", "green3")[unclass(cats$Sex)])
# 這個Dataset只有兩個Feature (cats$Hwt和cats$Bwt); Label是性別 (cats$Sex = “M” or “F”)；
# 上圖中紅色為F, 綠色為M。

# 接下來，我們進行Train Model的動作
library(rpart)
cats_rpart_model <- rpart(Sex~., data = cats)
plot(cats_rpart_model)
text(cats_rpart_model)

# (補充1: plot其實是直行 plot.rpart這個函數)
# 
# (補充2: “Sex~.” 意思就是拿cats 的Sex以外的columns當作input來預測Sex這個Column；如果把 “Sex~.” 換成 “Sex~Hwt+Bwt” 也會得到一樣的效果)

# 接下來，我們進行Predict / Test的動作
cats_rpart_pred <- predict(cats_rpart_model, cats)

cats_rpart_pred_Class <- apply( cats_rpart_pred,1,function(one_row) return(colnames(cats_rpart_pred)[which(one_row == max(one_row))]))
cats_Class_temp <- unclass(cats$Sex)
cats_Class <- attr(cats_Class_temp ,"levels")[cats_Class_temp]
table(cats_rpart_pred_Class,cats_Class)
#                      cats_Class
# cats_rpart_pred_Class  F  M
#                     F 32 11
#                     M 15 86
# 和svm中一樣，這是一張非常非常要的Table，它告訴我們：有11個原本是M的被分到F、15個原本是F的被份到M

## 最後，我們在圖上畫出decision boundary。
x1 <- seq(min(cats$Bwt), max(cats$Bwt), length = 50)
x2 <- seq(min(cats$Hwt), max(cats$Hwt), length = 50)
Feature_x1_to_x2 <- expand.grid(Bwt = x1, Hwt = x2)
Feature_x1_to_x2_Class <- apply(predict(cats_rpart_model,Feature_x1_to_x2),1,
                                function(one_row) return(which(one_row == max(one_row))))
plot(cats[2:3], pch = 21, bg = c("red", "green3")[unclass(cats$Sex)])
contour(x1,x2,matrix(Feature_x1_to_x2_Class,length(x1)),add = T, levels = 1.5,labex = 0)


## R上的CART Package — rpart [參數篇]  補充篇
## ### 接下來，我們將使用cats data調整不同的cp和minsplit：

# 將前文中的這行
# cats_rpart_model <- rpart(Sex~., data = cats)

# 改成這行
# cats_rpart_model <- rpart(Sex~., data = cats, minsplit=1, cp=1e-3)

### 修正後
cats_rpart_model <- rpart(Sex~., data = cats, minsplit=1, cp=1e-3)
plot(cats_rpart_model)
text(cats_rpart_model)

# (補充1: plot其實是直行 plot.rpart這個函數)
# 
# (補充2: “Sex~.” 意思就是拿cats 的Sex以外的columns當作input來預測Sex這個Column；如果把 “Sex~.” 換成 “Sex~Hwt+Bwt” 也會得到一樣的效果)

# 接下來，我們進行Predict / Test的動作
cats_rpart_pred <- predict(cats_rpart_model, cats)

cats_rpart_pred_Class <- apply( cats_rpart_pred,1,function(one_row) return(colnames(cats_rpart_pred)[which(one_row == max(one_row))]))
cats_Class_temp <- unclass(cats$Sex)
cats_Class <- attr(cats_Class_temp ,"levels")[cats_Class_temp]
table(cats_rpart_pred_Class,cats_Class)
#                      cats_Class
# cats_rpart_pred_Class  F  M
#                     F 32 11
#                     M 15 86
# 和svm中一樣，這是一張非常非常要的Table，它告訴我們：有11個原本是M的被分到F、15個原本是F的被份到M

## 最後，我們在圖上畫出decision boundary。
x1 <- seq(min(cats$Bwt), max(cats$Bwt), length = 50)
x2 <- seq(min(cats$Hwt), max(cats$Hwt), length = 50)
Feature_x1_to_x2 <- expand.grid(Bwt = x1, Hwt = x2)
Feature_x1_to_x2_Class <- apply(predict(cats_rpart_model,Feature_x1_to_x2),1,
                                function(one_row) return(which(one_row == max(one_row))))
plot(cats[2:3], pch = 21, bg = c("red", "green3")[unclass(cats$Sex)])
contour(x1,x2,matrix(Feature_x1_to_x2_Class,length(x1)),add = T, levels = 1.5,labex = 0)



### 接下來我們測試iris data，只採用iris中的Petal.Length和Petal.Length兩個維度的Data。
# rm(list=ls(all=TRUE))
data(iris)
Iris_2D <- iris[,3:5]
plot(Iris_2D[1:2], pch = 21, bg = c("red", "green3", "blue")[unclass(Iris_2D$Species)])

library(rpart)
Iris_2D_rpart_model <- rpart(Species~., data = Iris_2D)
Iris_2D_rpart_pred <- predict(Iris_2D_rpart_model, Iris_2D)

Iris_2D_rpart_pred_ClassN <- apply( Iris_2D_rpart_pred,1,function(one_row) return(which(one_row == max(one_row))))
Iris_2D_rpart_pred_Class <- apply( Iris_2D_rpart_pred,1,function(one_row) return(colnames(Iris_2D_rpart_pred)[which(one_row == max(one_row))]))

Iris_2D_Class_temp <- unclass(Iris_2D$Species)
Iris_2D_Class <- attr(Iris_2D_Class_temp ,"levels")[Iris_2D_Class_temp]

table(Iris_2D_rpart_pred_Class,Iris_2D_Class)
#                         Iris_2D_Class
# Iris_2D_rpart_pred_Class setosa versicolor virginica
#               setosa         50          0         0
#               versicolor      0         49         5
#               virginica       0          1        45

plot(Iris_2D_rpart_model)
text(Iris_2D_rpart_model)

x1 <- seq(min(Iris_2D$Petal.Length), max(Iris_2D$Petal.Length), length = 50)
x2 <- seq(min(Iris_2D$Petal.Width), max(Iris_2D$Petal.Width), length = 50)
Feature_x1_to_x2 <- expand.grid(Petal.Length = x1, Petal.Width = x2)
Feature_x1_to_x2_Class <- apply(predict(Iris_2D_rpart_model,Feature_x1_to_x2),1,
                                function(one_row) return(which(one_row == max(one_row))))

plot(Iris_2D[1:2], pch = 21, bg = c("red", "green3", "blue")[unclass(Iris_2D$Species)])
contour(x1,x2,matrix(Feature_x1_to_x2_Class,length(x1)),add = T, levels = c(1.5,2.5),labex = 0)




### case 02
## 同樣的，我們可以把第6行的model換成下面這行在run一次
data(iris)
Iris_2D <- iris[,3:5]
plot(Iris_2D[1:2], pch = 21, bg = c("red", "green3", "blue")[unclass(Iris_2D$Species)])

library(rpart)
Iris_2D_rpart_model <- rpart(Species~., data = Iris_2D, minsplit=1, cp=1e-3)
Iris_2D_rpart_pred <- predict(Iris_2D_rpart_model, Iris_2D)

Iris_2D_rpart_pred_ClassN <- apply( Iris_2D_rpart_pred,1,function(one_row) return(which(one_row == max(one_row))))
Iris_2D_rpart_pred_Class <- apply( Iris_2D_rpart_pred,1,function(one_row) return(colnames(Iris_2D_rpart_pred)[which(one_row == max(one_row))]))

Iris_2D_Class_temp <- unclass(Iris_2D$Species)
Iris_2D_Class <- attr(Iris_2D_Class_temp ,"levels")[Iris_2D_Class_temp]

table(Iris_2D_rpart_pred_Class,Iris_2D_Class)
#                         Iris_2D_Class
# Iris_2D_rpart_pred_Class setosa versicolor virginica
#               setosa         50          0         0
#               versicolor      0         49         5
#               virginica       0          1        45

plot(Iris_2D_rpart_model)
text(Iris_2D_rpart_model)

x1 <- seq(min(Iris_2D$Petal.Length), max(Iris_2D$Petal.Length), length = 50)
x2 <- seq(min(Iris_2D$Petal.Width), max(Iris_2D$Petal.Width), length = 50)
Feature_x1_to_x2 <- expand.grid(Petal.Length = x1, Petal.Width = x2)
Feature_x1_to_x2_Class <- apply(predict(Iris_2D_rpart_model,Feature_x1_to_x2),1,
                                function(one_row) return(which(one_row == max(one_row))))

plot(Iris_2D[1:2], pch = 21, bg = c("red", "green3", "blue")[unclass(Iris_2D$Species)])
contour(x1,x2,matrix(Feature_x1_to_x2_Class,length(x1)),add = T, levels = c(1.5,2.5),labex = 0)


## 最後，在rpart中也有類似像svm中那個tune的設計。可以直接在圖上畫出各種cp所train出來的model的精度。如下：(延續使用上方的iris作為例子)

plotcp(Iris_2D_rpart_model)   # 會得到cp和error的一張圖
printcp(Iris_2D_rpart_model)
# Classification tree:
#     rpart(formula = Species ~ ., data = Iris_2D, minsplit = 1, cp = 0.001)
# 
# Variables actually used in tree construction:
#     [1] Petal.Length Petal.Width 
# 
# Root node error: 100/150 = 0.66667
# 
# n= 150 
# 
#      CP nsplit rel error xerror     xstd
# 1 0.500      0      1.00   1.24 0.046361
# 2 0.440      1      0.50   0.84 0.060795
# 3 0.020      2      0.06   0.08 0.027520
# 4 0.010      3      0.04   0.08 0.027520
# 5 0.001      6      0.01   0.06 0.024000

## 從圖上和訊息中，我們可以看出error隨著cp的縮小，而遞減的速度。

###end of iris

### ?rpart 原廠文件------------------------------
?rpart
# Recursive Partitioning and Regression Trees *********************************************
fit <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis)
fit2 <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
              parms = list(prior = c(.65,.35), split = "information"))
fit3 <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
              control = rpart.control(cp = 0.05))
par(mfrow = c(1,2), xpd = NA) # otherwise on some devices the text is clipped
plot(fit)
text(fit, use.n = TRUE)
plot(fit2)
text(fit2, use.n = TRUE)
# End of Recursive Partitioning and Regression Trees **************************************

# 延伸閱讀:
# http://www.cc.ntu.edu.tw/chinese/epaper/0031/20141220_3105.html


### 4-3 使用  C50 套件 -----------------
# install.packages("C50")
library(C50)

### 鳶尾花(iris)資料集 使用package套件 C50 建立決策樹  
data(iris)
head(iris)
pairs(iris, col = iris$Species)

# 1.查看資料集的資料結構: 
str(iris)
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

# 2. 隨機種子設置為以下的固定值，以使結果可重現。
set.seed(1234)

# 3. 在建模之前，鳶尾花(iris)資料集被分成兩個子集：訓練（70％）和測試（30％）。
index <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
index

# 4. 驗證取樣百分比!
sum(index == 1) / length(index)  # [1] 0.7466667
sum(index == 2) / length(index)  # [1] 0.2533333

# 5. 訓練（70％）和測試（30％）
trainData <- iris[index==1, ]
testData <- iris[index==2, ]

# 6. 設定C5.0 相關引數
c <- C5.0Control(subset = FALSE,
                bands = 0,
                winnow = FALSE,
                noGlobalPruning = FALSE,
                CF = 0.25,
                minCases = 2,
                fuzzyThreshold = FALSE,
                sample = 0,
                seed = sample.int(4096, size = 1) - 1L,
                earlyStopping = TRUE
) 

?C5.0
# x	a data frame or matrix of predictors.
# y	a factor vector with 2 or more levels

iris_treeModel <- C5.0(x = trainData[, -5], y = trainData$Species, control = c)

# 7. 顯示C50 的規則與訓練集的錯誤率
summary(iris_treeModel)
# Call:
# C5.0.default(x = trainData[, -5], y = trainData$Species, control = c)
# 
# 
# C5.0 [Release 2.07 GPL Edition]  	Mon Dec 25 13:27:50 2017
# 
#     
# Class specified by attribute `outcome'
# 
# Read 112 cases (5 attributes) from undefined.data
# 
# Decision tree:
# 
# Petal.Length <= 1.9: setosa (40)
# Petal.Length > 1.9:
# :...Petal.Width <= 1.7: versicolor (40/3)
#     Petal.Width > 1.7: virginica (32/1)
# 
# 
# Evaluation on training data (112 cases):
# 
# Decision Tree   
#  
# Size      Errors  
# 
#    3    4( 3.6%)   <<
# 
# 
#  (a)   (b)   (c)    <-classified as
#  ==     ==   ===
#   40                (a): class setosa
#         37     1    (b): class versicolor
#          3    31    (c): class virginica
# 
# 
# Attribute usage:
# 
# 100.00%	Petal.Length
# 64.29%	Petal.Width
# 
# 
# Time: 0.0 secs

plot(iris_treeModel)

# 7. 顯示C50 的規則與測試集的錯誤率
test.output <- predict(iris_treeModel, testData[, -5], type = "class")

test.output

table(test.output, testData$Species)
# test.output  setosa versicolor virginica
#   setosa         10          0         0
#   versicolor      0         12         2
#   virginica       0          0        14

length <- length(test.output)
count <- 0
for( i in 1:length)
{
    if (test.output[i] != testData[i,5])
    {
        count = count + 1
    }
}
test.errorRate <- (count / length) * 100
test.errorRate
# [1] 5.263158%

### 4-4 隨機森林 Random Forest -----------------

# 何謂Random Forest
# Random Forest的基本原理是，結合多顆CART樹（CART樹為使用GINI算法的決策樹），並加入隨機分配的訓練資料，以大幅增進最終的運算結果。
# 如果單個分類器表現OK，那麼將多個分類器組合起來，其表現會優於單個分類器。也就是論基於「人多力量大，三個臭皮匠勝過一個諸葛亮。」

# Bagging
# 這是1996年由Breiman提出（Bagging是Bootstrap aggregating的縮寫），透過Bagging，可讓我們的模型從資料本身的差異中得到更好的訓練。此種方法會從Training dataset中取出K個樣本，再從這K個樣本訓練出K個分類器（在此為tree）。每次取出的K個樣本皆會再放回母體，因此這個K個樣本之間會有部份資料重複，不過由於每顆樹的樣本還是不同，因此訓練出的分類器（樹）之間是具有差異性的。
#Boosting
# 與Bagging類似，但更強調針對錯誤部份加強學習以提昇整體的效率，重點是將大量弱學習的分類器（效率比較沒那麼好）逐步訓練成一個較強的分類器。
# https://chtseng.wordpress.com/2017/02/24/%E9%9A%A8%E6%A9%9F%E6%A3%AE%E6%9E%97random-forest/

# 隨機森林（random forest）顧名思義，是用隨機的方式建立一個森林，森林裡面有很多的決策樹組成，隨機森林的每一棵決策樹之間是沒有關聯的。在得到森林之後，當有一個新的輸入樣本進入的時候，就讓森林中的每一棵決策樹分別進行一下判斷，看看這個樣本應該屬於哪一類（對於分類算法），然後看看哪一類被選擇最多，就預測這個樣本為那一類。
# 在隨機森林中，我們將生成很多的決策樹，並不像在CART模型里一樣只生成唯一的樹。當在基於某些屬性對一個新的對象進行分類判別時，隨機森林中的每一棵樹都會給出自己的分類選擇，並由此進行「投票」，森林整體的輸出結果將會是票數最多的分類選項；而在回歸問題中，隨機森林的輸出將會是所有決策樹輸出的平均值。
# 原文網址：https://kknews.cc/zh-tw/news/brzmvj.html


# 套件 randomForest [Liaw和Wiener]用於構建一個預測模型
# 功能有兩個限制
# randomForest（）。 首先，它不能處理缺少值的數據，用戶必須對數據進行歸併
# 然後餵給他們進入功能。 其次，最多有32個的限制
# 每個分類屬性的級別。 超過32個級別的屬性必須進行轉換
# 先使用randomForest（）。
# 構建隨機森林的另一種方法是使用package party中的函數cforest（）
# 這不限於上述的最高水平。 但是，一般來說，是絕對的
# 具有更多級別的變量將使其需要更多的內存，並花費更長的時間來構建一個
# 隨機森林。
# 再次，IRIS數據首先被分成兩個子集：訓練（70％）和測試（30％）。

index <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData <- iris[index == 1, ]
testData <- iris[index == 2, ]

library(randomForest)

# \Species ~ .", which means to predict Species with all other variables in the data.

rf <- randomForest(Species ~ ., data=trainData, ntree=100, proximity=TRUE)
table(predict(rf), trainData$Species)
#            setosa versicolor virginica
# setosa         31          0         0
# versicolor      0         31         2
# virginica       0          1        40

print(rf)
# Call:
#     randomForest(formula = Species ~ ., data = trainData, ntree = 100,      proximity = TRUE) 
# Type of random forest: classification
# Number of trees: 100
# No. of variables tried at each split: 2
# 
# OOB estimate of  error rate: 2.86%
# Confusion matrix:
#            setosa versicolor virginica class.error
# setosa         31          0         0  0.00000000
# versicolor      0         31         1  0.03125000
# virginica       0          2        40  0.04761905

attributes(rf)
# $names
# [1] "call"            "type"            "predicted"       "err.rate"        "confusion"       "votes"          
# [7] "oob.times"       "classes"         "importance"      "importanceSD"    "localImportance" "proximity"      
# [13] "ntree"           "mtry"            "forest"          "y"               "test"            "inbag"          
# [19] "terms"          
# 
# $class
# [1] "randomForest.formula" "randomForest" 

# 之後，我們繪製出各種樹的錯誤率。
plot(rf)

# 重要的變數
#The importance of variables can be obtained with functions importance() and varImpPlot().
importance(rf)
# MeanDecreaseGini
# Sepal.Length         8.585560
# Sepal.Width          1.246064
# Petal.Length        28.442050
# Petal.Width         30.425898

varImpPlot(rf)

# Finally, the built random forest is tested on test data, and the result is checked with functions
# table() and margin(). The margin of a data point is as the proportion of votes for the correct
# class minus maximum proportion of votes for other classes. Generally speaking, positive margin means correct classification.
# 最後，在測試數據上測試構建的隨機森林，並使用函數table（）和margin（）檢查結果。 數據點的邊際是正確類別的投票的比例減去其他類別的最大比例。 一般來說，積極的意味著正確的分類。

irisPred <- predict(rf, newdata=testData)
table(irisPred, testData$Species)
# irisPred     setosa versicolor virginica
#   setosa         19          0         0
#   versicolor      0         16         1
#   virginica       0          2         7

plot(margin(rf, testData$Species))

## 第四章作業 04- 巨量資料分析與應用 Using - R - 機器學習-決策樹與隨機森林--------
# 請利用 UCI 資料集: 
# https://archive.ics.uci.edu/ml/datasets.html  中的 Abalone 資料集 重新使用
# 老師所使用過的四中方法:
# party (ctree)，rpart 與 C50 和 randomForest構建預測 Abalone 年齡模型

### 自我練習作業(不用繳交) ------
# 決策樹(分析鐵達尼號資料) http://www.rpubs.com/skydome20/R-Note6-Apriori-DecisionTree
# R軟體資料探勘實務(上)--分類模型 https://www.cc.ntu.edu.tw/chinese/epaper/0034/20150920_3410.html
# R語言機器學習之決策樹與隨機森林 https://ithelp.ithome.com.tw/articles/10187561
# R_programming - (8)決策樹(Decision Tree) https://rstudio-pubs-static.s3.amazonaws.com/275285_90aaf9a2a64d43a5846a86dbcde8eba9.html
# R語言的決策樹應用 https://blog.stranity.com.tw/2016/10/17/r%E8%AA%9E%E8%A8%80%E7%9A%84%E6%B1%BA%E7%AD%96%E6%A8%B9%E6%87%89%E7%94%A8/
# R 軟體裡的多變量決策樹: 預測多個反應變數 http://steve-chen.tw/?p=619
# R統計分析與資料探勘入門—以鳶尾花資料集為例 http://www.cc.ntu.edu.tw/chinese/epaper/0031/20141220_3105.html

# R上的CART Package — rpart [參數篇] https://c3h3notes.wordpress.com/2010/10/25/r%E4%B8%8A%E7%9A%84cart-package-rpart-%E5%8F%83%E6%95%B8%E7%AF%87/
# R上的CART Package — rpart [入門篇] https://c3h3notes.wordpress.com/2010/10/22/r%E4%B8%8A%E7%9A%84cart-package-rpart/
# 决策树——CART——之R语言rpart包 http://blog.csdn.net/learneraiqi/article/details/44700549
# rpart包和party包的简单比较 http://xccds1977.blogspot.tw/2012/05/rpartparty.html
# R决策树 http://danzhuibing.github.io/r_decision_tree.html

### 隨機森林入門攻略 https://read01.com/zh-tw/OA5B2A.html#.WkDqxd_XaMo
# 就是要學R #15：機器學習之決策樹、隨機森林實作篇 http://psop-blog.logdown.com/posts/2689845-r-decision-tree-random-forest-machine-learning
# 用随机森林模型替代常用的回归和分类模型 http://blog.sciencenet.cn/blog-661364-728330.html
# R语言之Random Forest随机森林 http://www.cnblogs.com/nxld/p/6374945.html
# R语言实现随机森林 https://zhuanlan.zhihu.com/p/27303988
# R語言數據挖掘實踐——使用randomForest包構建隨機森林 https://kknews.cc/zh-tw/other/yyv689j.html
# [Machine Learning] Random Forest 隨機森林 原文網址：https://read01.com/mEjD8O.html

