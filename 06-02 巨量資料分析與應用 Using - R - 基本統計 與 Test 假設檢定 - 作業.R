# 06-02 巨量資料分析與應用 Using - R - 基本統計 與 Test 假設檢定 - 作業

# Machine Learning with the UCI Wine Quality Dataset
# 用UCI葡萄酒質量數據集進行機器學習

# UCI 資料集如下:
# https://archive.ics.uci.edu/ml/datasets/wine+quality

white.url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv"

red.url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"

white <- read.csv(white.url, header = TRUE, sep = ";")
red <- read.csv(red.url, header = TRUE, sep = ";")

names(white)
# [1] "fixed.acidity"    "volatile.acidity"     "citric.acid"          "residual.sugar"      
# [5] "chlorides"        "free.sulfur.dioxide"  "total.sulfur.dioxide" "density"             
# [9] "pH"               "sulphates"            "alcohol"              "quality"   <<<<
# [1] “固定酸度”         “揮發性酸度”           “檸檬酸”               “殘糖”
# [5] “氯化物”           “游離二氧化硫”         “總二氧化硫”           “密度”
# [9] “酸鹼值”            “硫酸鹽”               “酒精”                 “質量”     <<<<

whiteChinese <- white
names(whiteChinese) <- c("固定酸度", "揮發性酸度", "檸檬酸", "殘糖", "氯化物", "游離二氧化硫", "總二氧化硫", "密度", "酸鹼值", "硫酸鹽", "酒精", "質量" )

names(whiteChinese)

# summary  函數可以同時計算平均值、極小值、極大值和中位數。對此函數，若資料包含  NA  值會自動被移除掉。
summary(whiteChinese)

str(whiteChinese)

# 相關係數(correlation)和共變異數(covariace) ------
# 相關係數(correlation): 
cor(whiteChinese)


# 我們用  GGally  套件中的  ggpairs  函數來繪圖，如圖   顯示，該圖顯示的是兩兩變數的散佈圖。由於載入  GGally  同時會載入  reshape 套件，造成一些 namespace 的問題。因此我們是用::運算子來呼叫它的函數。
#GGally::ggpairs(economics[, c(2, 4:6)], params = list(labelSize = 8))
install.packages("GGally")
library(GGally)

## 圖形顯示時間 較長 請等待!!!!
ggpairs(whiteChinese)
# ggpairs(white)

lm(質量 ~ ., data = whiteChinese)

lm(quality ~ ., data = white)

unique(white$quality)

class(white$quality)

white$quality <- as.factor(white$quality)
class(white$quality)

lm(quality ~ ., data = white)

glm(質量 ~ ., data = whiteChinese)

library(rpart)

fit <- rpart(質量 ~ ., data = whiteChinese)
plot(fit)
text(fit, use.n = TRUE)

fit2 <- rpart(quality ~ ., data = white)
plot(fit2)
text(fit2, use.n = TRUE)

class(white$quality)

table(white$quality)

(cl <- kmeans(whiteChinese[ ,-12], 5, nstart = 25))

(cl <- kmeans(whiteChinese[ ,-12], 7, nstart = 25))

fit2 <- rpart(quality ~ ., data = red)
plot(fit2)
text(fit2, use.n = TRUE)

fit3 <- rpart(density ~ ., data = red)
plot(fit3)
text(fit3, use.n = TRUE)

fit4 <- rpart(pH ~ ., data = red)
plot(fit4)
text(fit4, use.n = TRUE)

fit5 <- rpart(sulphates ~ ., data = red)
plot(fit5)
text(fit5, use.n = TRUE)

