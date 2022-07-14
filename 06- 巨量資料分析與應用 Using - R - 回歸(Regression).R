# ---
# title: "『06- 巨量資料分析與應用 Using - R - 回歸(Regression)』"
# author: <p align="right">東海大學資訊管理系（所）姜自強助理教授</p>
# ---

# 回歸是建立一個獨立變量（也稱為預測變量）的函數來預測一個因變量（也稱為響應）。 
# 例如，銀行根據他們的年齡，收入，支出，職業，家屬人數，總信用額度等來
# 評估住房貸款申請人的風險。
# 本章介紹基本概念並介紹各種回歸技術的例子。 
# 首先，它展示了一個建立線性回歸模型來預測 women數據的例子。 
# 之後，它引入邏輯回歸。 然後介紹廣義線性模型（GLM），然後簡要介紹非線性回歸。
# 
# 用lm擬合回歸模型
?lm
# * 擬合線性模型最基本的函數就是lm，格式為：
# * myfit <- lm(formula, data)
# * formula 指要擬合的模型形式，data是一個數據框，包含了用於擬合模型的數據
# * formula 形式如下：Y ~ X1 + X2 +……+ Xk 
#           （~左邊為響應變量，右邊為各個預測變量，預測變量之間用+符號分隔）

# 對擬合線性模型非常有用的其他函數
# 函數          | 用途
# ___________________________________________________________
# Summary    	  |展示擬合的詳細結果
# Coefficients	|列出擬合模型的模型參數（截距項和斜率）
# Cofint    	  |提供模型參數的置信區間（默認95%）
# Fitted	      |列出擬合模型的預測值
# Residuals	    |列出擬合模型的殘差值
# Anova	        |生成一個擬合模型的方差分析，或者比較兩個或更多擬合模型的方差分析表
# Vcov	        |列出模型參數的協方差矩陣
# AIC	          |輸出赤池信息統計量
#               |(是評估統計模型的複雜度和衡量統計模型「擬合」資料之優良性)
# Plot	        |生成評價擬合模型的診斷圖
# Predict	      |用擬合模型對新的數據集預測響應變量值

## 1.1 簡單線性回歸 ------------
## women 資料集為例：

# * Average Heights and Weights for American Women
# * This data set gives the average heights and weights for American women aged 30–39.
# * Format
# * A data frame with 15 observations on 2 variables.
# 1. height	numeric	Height (in)
# 2. weight	numeric	Weight (lbs)

data("women")
?women

dim(women)
# [1] 15  2

str(women)
# 'data.frame':	15 obs. of  2 variables:
# $ height: num  58 59 60 61 62 63 64 65 66 67 ...
# $ weight: num  115 117 120 123 126 129 132 135 139 142 ...

summary(women)
#     height         weight     
# Min.   :58.0   Min.   :115.0  
# 1st Qu.:61.5   1st Qu.:124.5  
# Median :65.0   Median :135.0  
# Mean   :65.0   Mean   :136.7  
# 3rd Qu.:68.5   3rd Qu.:148.0  

head(women)
#   height weight
# 1     58    115
# 2     59    117
# 3     60    120
# 4     61    123
# 5     62    126
# 6     63    129

# 視覺化資料
library(ggplot2)
require(graphics)
plot(women, xlab = "Height (in)", ylab = "Weight (lb)", col = "blue",
     main = "視覺化資料 women data: American women aged 30-39")

# 用lm擬合回歸模型
fit <- lm(weight ~ height, data = women)

summary(fit)
# Call:
#     lm(formula = weight ~ height, data = women)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -1.7333 -1.1333 -0.3833  0.7417  3.1167 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -87.51667    5.93694  -14.74 1.71e-09 ***
# height        3.45000    0.09114   37.85 1.09e-14 *** <<< 
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 1.525 on 13 degrees of freedom
# Multiple R-squared:  0.991,	Adjusted R-squared:  0.9903 
# F-statistic:  1433 on 1 and 13 DF,  p-value: 1.091e-14

cor(women)
#           height    weight
# height 1.0000000 0.9954948
# weight 0.9954948 1.0000000

## 回歸資料解釋 -----
# 1. 在Pr(>|t|)欄可以看到回歸height係數（3.45）顯著不為0（p<0.001），
#    表明身高每增加1英寸，體重將預期地增加3.45磅
#    weight = -87.51667 + 3.45 * height
# 2. Multiple R-squared: R平方項（0.991）表明模型可以解釋體重99.1%的方差，
#    它也是實際和預測值之間的相關係數（R^2=r^2）
# 3. Residual standard error:殘差的標準誤（1.53lbs）
#    則可認為模型用身高預測體重的平均誤差
# 4. F統計量檢驗所有的預測變量預測響應變量是否都在某個幾率水平之上
# 5. 由summary(fit)的結果 coefficients 可看出，
#    預測模型為：weight = -81.52 + 3.45 * height。

class(fit)
# [1] "lm"

typeof(fit)
#[1] "list"

names(fit)
# [1] "coefficients"  "residuals"     "effects"       "rank"          "fitted.values"
# [6] "assign"        "qr"            "df.residual"   "xlevels"       "call"         
# [11] "terms"         "model"  

## 擬合 fit 模型的預測值 -----
fitted(fit)
#        1        2        3        4        5        6        7        8        9       10       11       12 
# 112.5833 116.0333 119.4833 122.9333 126.3833 129.8333 133.2833 136.7333 140.1833 143.6333 147.0833 150.5333 
#       13       14       15 
# 153.9833 157.4333 160.8833 

women
#    height weight
# 1      58    115
# 2      59    117
# 3      60    120
# 4      61    123

## 擬合模型的殘差值 -----
residuals(fit)
#          1           2           3           4           5           6           7           8           9 
# 2.41666667  0.96666667  0.51666667  0.06666667 -0.38333333 -0.83333333 -1.28333333 -1.73333333 -1.18333333 
#          10          11          12          13          14          15 
# -1.63333333 -1.08333333 -0.53333333  0.01666667  1.56666667  3.11666667 

plot(women$height, women$weight, xlab="Height （in inches）", 
          ylab= "Weight（in pounds）", col = "blue")
abline(fit, col = "red")

women$fit <- fit$fitted.values
points(women$height, women$fit, col = "red")

# QQ plot(Quantile-Quantile Plot)常態機率圖
# 常態機率圖(normal quantile-quantile plot,簡稱normal Q-Q plot),
# 是一種能看出資料分布情形,是否符合常態分配的圖.
# 橫軸顯示的是理論分位數,縱軸則是樣本分位數,資料點散佈於圖上,並有一條虛擬的常態線通過.

# 一張一張圖看
plot(fit)

#一次看四圖
opar <- par(mfrow = c(2, 2), oma = c(0, 0, 1.1, 0))
plot(fit)
par(opar)

## 圖形解釋：

# 1. QQ plot(Quantile-Quantile Plot)常態機率圖 
# 當「樣本直線」與此常態直線重合時，表示符合常態分配。
# 什麼是殘差圖
# 進行回歸診斷，通常可用殘差圖進行。
# 所謂殘差圖，就是以因變數的觀測值yj或自變數值x1j、x2j、…、xkj或因變數回歸值等為橫坐標，且以殘差或其標準化數值為縱坐標所作出的散點圖。

### 談談常態分佈----
## 繪出上面的常態分佈圖,包含常態曲線圖(左邊)與常態分佈直方圖(右邊)
opar <- par(mfrow = c(1, 2), oma = c(0, 0, 1.1, 0))
curve(dnorm(x),from = -3.5, to = 3.5, ylab="p.d.f", 
      main="normal distribution plot - n(0.1)")
x=rnorm(1000)
hist(x, nclass=50)
par(opar)

## 跳出視窗
windows()
split.screen(c(1,2))
screen(1)
curve(dnorm(x),from = -3.5, to = 3.5, ylab="p.d.f", main="normal distribution plot - n(0.1)")
screen(2)
x=rnorm(1000)
hist(x, nclass=50)
close.screen(all=T)

## end of 跳出視窗

# 常態機率圖(normal quantile-quantile plot,簡稱normal Q-Q plot),是一種能看出資料分布情形,是否符合常態分配的圖.
# 橫軸顯示的是理論分位數,縱軸則是樣本分位數,資料點散佈於圖上,並有一條虛擬的常態線通過.
# 繪製的一張圖表裡面包含了常態分配(normal),正偏(positive),負偏(negative)和高狹峰(leptokurtic),
# 共四種資料分佈型態的直方圖與QQ圖.讀者可由兩兩對照的直方圖(左)和QQ圖(右),來了解不同資料型態的呈現情形.

# 以下一起執行
windows()
normal = c(0,1,1,2,2,2,2,3,3,3,3,3,3,4,4,4,4,5,5,6)
nn = 5000
rnor = rnorm(nn, 0, 1); 
hist(rnor)
leptokurtic = c(0,1,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,5,6)
positive = c(0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,4,4,5,6)
negative = c(0,1,2,3,3,4,4,4,4,4,4,5,5,5,5,5,5,5,5,6)
split.screen(c(2,1))
split.screen(c(1,4), screen = 1)
split.screen(c(1,4), screen = 2)
screen(3)
hist(normal)
screen(4)
qqnorm(normal)
qqline(normal)
screen(5)
hist(leptokurtic)
screen(6)
qqnorm(leptokurtic)
qqline(leptokurtic)
screen(7)
hist(positive)
screen(8)
qqnorm(positive)
qqline(positive)
screen(9)
hist(negative)
screen(10)
qqnorm(negative)
qqline(negative)
close.screen(all=T)
# end of  以下一起執行

## 圖形解釋: 
# 由上圖可以了解,當資料服膺常態分配時,資料點大致會分佈在虛擬的常態線附近.
# 
# 當資料為正偏分佈,也就是落在左側低分區的人數較多時,QQ圖的資料點就會往左側內凹;
# 
# 當資料為負偏分佈,也就是落在右側高分區的人數較多時,QQ圖的資料點就會往右側外凸;
# 
# 當資料為高狹分佈,也就是落在中間中分區的人數較多時,QQ圖的資料點就會呈現S型曲線.


## 1.2 簡單線性回歸: 案例02 ------------
library(ggplot2)
install.packages("UsingR")
library(UsingR)
data(father.son)
?father.son
# Pearson's data set on heights of fathers and their sons

dim(father.son)
# [1] 1078    2
View(father.son)

cor(father.son)
#           fheight   sheight
# fheight 1.0000000 0.5013383
# sheight 0.5013383 1.0000000

# 相關係數希望 0.6 以下越低越好 跑迴歸． ０．５ok

ggplot(father.son, aes(x=fheight, y=sheight)) + geom_point( col = "blue") +
          labs(x="父親身高", y="兒子身高")

ggplot(father.son, aes(x=fheight, y=sheight)) + geom_point( col = "blue") +
            geom_smooth(method="lm", col = "red") + labs(x="父親身高", y="兒子身高")

?geom_smooth
# geom_smooth()：這個函數就是為散點圖添加一條平滑的曲線（包含直線），它有個參數method, 指定曲線平滑方法，可選"lm", "glm", "gam", "loess", "rlm"，這幾個具體表示什麼意思，大家動動手，，默認會使用"loess"。
ggplot(father.son, aes(x=fheight, y=sheight)) + geom_point( col = "blue") +
  geom_smooth(method="loess", col = "red") + labs(x="父親身高", y="兒子身高")

## 看看資料分布是否常態?
hist(father.son$fheight)
hist(father.son$sheight)

# 線性回歸 ------
# 
fit <- lm(sheight ~ fheight, data = father.son)
fit

# Call:
#   lm(formula = sheight ~ fheight, data = father.son)
# 
# Coefficients:
#   (Intercept)      fheight  
#       33.8866       0.5141 

summary(fit)
# Call:
#   lm(formula = sheight ~ fheight, data = father.son)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -8.8772 -1.5144 -0.0079  1.6285  8.9685 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 33.88660    1.83235   18.49   <2e-16 ***
# fheight      0.51409    0.02705   19.01   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 2.437 on 1076 degrees of freedom
# Multiple R-squared:  0.2513,	Adjusted R-squared:  0.2506 
# F-statistic: 361.2 on 1 and 1076 DF,  p-value: < 2.2e-16

# 一張一張圖看
plot(fit)

#一次看四圖
opar <- par(mfrow = c(2, 2), oma = c(0, 0, 1.1, 0))
plot(fit)
par(opar)

### 1.3 變異數分析(ANOVA)連續型資料型態之應變數 與 類別型資料型態之自變數關係 -----
library(reshape2)
data(tips)
dim(tips)
# [1] 244   7
?tips
# One waiter recorded information about each tip he received over a period of a few months working in one restaurant. He collected several variables:

names(tips)
# [1] "total_bill" "tip"    "sex"     "smoker"    "day"   "time"      
# [7] "size"  

# A data frame with 244 rows and 7 variables
# # Details
# # tip     in dollars,
# # bill    in dollars,
# # sex     of the bill payer,
# # smoker  whether there were smokers in the party,
# # day     of the week,
# # time    of day,
# # size    of the party.

head(tips, n =10)

## 變異數分析或變方分析（Analysis of variance，簡稱ANOVA）為資料分析中常見的統計模型，主要為探討連續型（Continuous）資料型態之應變數（Dependent variable）與類別型資料型態之自變數（Independent variable）的關係

tipsAnova <- aov(tip ~ day - 1, data = tips)

# 把-1放在formula?堿O不要讓截距項涵蓋在模型??;
# 類別變數將自動地被設定成每個level都會有一個迴歸係數

summary(tipsAnova)
#            Df Sum Sq Mean Sq F value Pr(>F)    
# day         4 2203.0   550.8   290.1 <2e-16 ***
# Residuals 240  455.7     1.9                   
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# 可以看到在分析結果中，Pr(>F) < 2e-16 ，並低於 (1-95%) 的 0.05 範圍，
# 因此各組的平均值間是有明顯差異!

plot(tips$tip ~ tips$day, col = 2:5) # 繪出 tip 小費~ day 星期  的盒狀圖

### 反例-各組的平均值間沒有明顯差異
X = rnorm(40, 5, 1) # 產生四十個樣本 (平均值 5，標準差 1)
X
# [1] 4.459407 6.682351 3.858117 6.091471 5.329439 4.722386 2.660932 5.675958 5.650403
# [10] 5.492520 3.796970 6.869848 5.809412 4.452634 4.910614 5.291173 4.033651 4.568666
# [19] 5.620230 2.811219 3.092131 6.538792 5.120287 3.177582 4.747420 4.798069 3.085815
# [28] 3.728057 5.276745 5.488956 6.249709 6.549106 5.898221 6.230642 5.619715 5.336340
# [37] 4.862214 4.930167 6.847763 4.199532

A = factor(rep(1:4, each=10)) # 產生標記 1, 2, 3, 4 各 10 份(分成四組)
A
# [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 4 4 4
# Levels: 1 2 3 4

XA = data.frame(X, A) # 建立框架變數 XA，為每個 X 樣本分別標上 1, 2, 3, 4 等標記。
aov.XA = aov(X ~ A, data = XA) # 進行「變異數分析」，看看 X 與 A 之間是否有相關。
summary(aov.XA) # 印出「變異數分析」的結果報表
#             Df Sum Sq Mean Sq F value Pr(>F)
# A            3   7.33   2.445   2.035  0.126
# Residuals   36  43.25   1.201  

# 在分析結果中，Pr(>F) = 0.126 ，並沒有低於 (1-95%) 的 0.05 範圍，因此各組的平均值間沒有明顯差異，我們無法否認 H0。

# 在上述操作中，我們用 X = rnorm(40, 5, 1) 產生四十個樣本，
# 然後用 A = factor(rep(1:4, each=10)) 與 XA = data.frame(X, A) 
# 這個指令將這四十個樣本分為四群，每群 10 個，分別標以 1, 2, 3, 4 的標記，
# 成為 XA 這個框架 (frame) 變數，
# 然後利用 `aov.XA = aov(X~A, data=XA)' 這個指令進行「變異數分析」，並用 
# summary(aov.XA) 指令印出分析結果。
# 
# 在分析結果中，Pr(>F) = 0.115 ，並沒有低於 (1-95%) 的 0.05 範圍，
# 因此各組的平均值間沒有明顯差異，我們無法否認 H0。
# 
# 最後我們用 plot(XA$X~XA$A) 這個指令匯出盒狀圖，就可以大致看到四組分佈的情況。

plot(XA$X~XA$A, col = 2:5) # 繪出 X~A 的盒狀圖

## end of 反例

tipsLM <- lm(tip ~ day - 1, data = tips)


summary(tipsLM)
# 
# Call:
#   lm(formula = tip ~ day - 1, data = tips)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -2.2451 -0.9931 -0.2347  0.5382  7.0069 
# 
# Coefficients:
#         Estimate Std. Error t value Pr(>|t|)    
# dayFri    2.7347     0.3161   8.651 7.46e-16 ***
# daySat    2.9931     0.1477  20.261  < 2e-16 ***
# daySun    3.2551     0.1581  20.594  < 2e-16 ***
# dayThur   2.7715     0.1750  15.837  < 2e-16 ***
#   ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 1.378 on 240 degrees of freedom
# Multiple R-squared:  0.8286,	Adjusted R-squared:  0.8257 
# F-statistic: 290.1 on 4 and 240 DF,  p-value: < 2.2e-16

# ---------------------------------------------------------- #
# 首先手動計算平均數和信賴區間(CI)
library(plyr)
tipsByDay <- ddply(tips, "day", summarize,
                   tip.mean=mean(tip), tip.sd=sd(tip),
                   Length=NROW(tip),
                   tfrac=qt(p=.90, df=Length-1),
                   Lower=tip.mean - tfrac*tip.sd/sqrt(Length),
                   Upper=tip.mean + tfrac*tip.sd/sqrt(Length)
)

# 現在從tipsLM的摘要表(summary)把它們抽取出來
tipsInfo <- summary(tipsLM)
tipsCoef <- as.data.frame(tipsInfo$coefficients[, 1:2])
tipsCoef <- within(tipsCoef, {
  Lower <- Estimate - qt(p=0.90, df=tipsInfo$df[2]) * `Std. Error`
  Upper <- Estimate + qt(p=0.90, df=tipsInfo$df[2]) * `Std. Error`
  day <- rownames(tipsCoef)
})

# 把它們繪製出來
ggplot(tipsByDay, aes(x=tip.mean, y=day)) + geom_point() +
  geom_errorbarh(aes(xmin=Lower, xmax=Upper), height=.3) +
  ggtitle("Tips by day calculated manually")

ggplot(tipsCoef, aes(x=Estimate, y=day)) + geom_point() +
  geom_errorbarh(aes(xmin=Lower, xmax=Upper), height=.3) +
  ggtitle("Tips by day calculated from regression model")



# 2. 多項式回歸 ------
# 含有x和y這兩個變量的線性回歸是所有回歸分析中最常見的一種；
# 而且，在描述它們關係的時候，也是最有效、最容易假設的一種模型。

# 然而，有些時候，它的實際情況下某些潛在的關係是非常複雜的，不是二元分析所能解決的，
# 而這時，我們需要多項式回歸分析來找到這種隱藏的關係。

# 讓我們看一下經濟學裡的一個例子：假設你要買一個具體的產品，而你要買的個數是q。
# 如果產品的單價是p，然後，你要給y元。其實，這就是一個很典型的線性關係。
# 而總價和產品數量呈正比例關係。下面，根據這個實例，我們敲擊行代碼來作它們的線性關係圖

p <- 0.5
q <- seq(0,100,1)
y <- p * q
# 線性關係圖：
plot(q,y,type='b',col='red',main='線性回歸')
plot(q,y,type='l',col='blue',main='線性回歸')

# 現在，我們看到這確實是一個不錯的估計，這個圖很好的模擬成q和y的線性關係。

#然而，當我們在做買賣要考慮別的因素的時候，諸如這種商品要買多少，很有可能，
# 我們可以通過詢問和討價賺得折扣，或者，當我們越來越多的買一種具體的商品的時候，
# 我們也可能讓這種商品升價了。
# 這樣我們根據上面的條件，我們在寫腳本的時候，我們要注意，

# 總價與產品的數量不再具有線性關係了：
y <- 450 + p * ( q - 10) ^ 3
plot(q, y, type='l',col='navy',main='非線性關係',lwd=3)


## 一般來說，n 次多項式生成一個n-1個彎曲的曲線
## 以前例 women 
plot(women$weight, I(women$height ^ 2))

fit2 <- lm( weight ~ height + I(height ^ 2), data=women)

summary(fit2)
# Call:
#     lm(formula = weight ~ height + I(height^2), data = women)
# 
# Residuals:
#     Min       1Q   Median       3Q      Max 
# -0.50941 -0.29611 -0.00941  0.28615  0.59706 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 261.87818   25.19677  10.393 2.36e-07 ***
# height       -7.34832    0.77769  -9.449 6.58e-07 ***
# I(height^2)   0.08306    0.00598  13.891 9.32e-09 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.3841 on 12 degrees of freedom
# Multiple R-squared:  0.9995,	Adjusted R-squared:  0.9994 
# F-statistic: 1.139e+04 on 2 and 12 DF,  p-value: < 2.2e-16


plot(women$height,women$weight, xlab="Height（in inches）",
           ylab="Weight（in lbs）", col = "blue")
lines(women$height,fitted(fit2), col = "red")

opar <- par(mfrow = c(1, 2))
plot(women$height,women$weight, xlab="Height （in inches）", 
     ylab= "Weight（in pounds）", col = "blue",
     main = "線性 fit ")
abline(fit, col = "red")
plot(women$height,women$weight, xlab="Height（in inches）",
     ylab="Weight（in lbs）", col = "blue",
     main = "多項式線性 fit ")
lines(women$height,fitted(fit2), col = "red")
par(opar)

opar <- par(mfrow = c(2, 2), oma = c(0, 0, 1.1, 0))
plot(fit2)
par(opar)

# 1. 由summary(fit2)的結果coefficients可看出預測模型為：

#    weight=261.88 - 7.35*height + 0.083* height* height。

# 2. 在p < 0.001水平下，回歸係數都非常顯著。  << p-value: < 2.2e-16
# 3. 模型的方差解釋率已經增加到了99.9%。      << R-squared:  0.9995
# 4. 二次項的顯著性（t = 13.89，p<0.001）表明包含二次項提高了模型的擬合度。
# 5. 從圖中也能看出來，預測值和觀測值的擬合程度更好了。

## 補充 
# R表達式中常用的符號
# 符號類型      | 用途
#______________________________________________________________________________________________
# ~	          | 分隔符號左邊為響應變量，右邊為解釋變量，eg：要通過x、z和w預測y，代碼為y~x+z+w
# +	          | 分隔預測變量
# ：	        | 表示預測變量的交互項 eg：要通過x、z及x與z的交互項預測y，代碼為y~x+z+x:z
# *		        | 表示所有可能交互項的簡潔方式，代碼y~x*z*w可展開為y~x+z+w+x:z+x:w+z:w+x:z:w
# ^		        | 表示交互項達到某個次數，代碼y~(x+z+w)^2可展開為y~x+z+w+x:z+x:w+z:w 表示包含除因變量外的所
#               有變量，eg：若一個數據框包含變量x、y、z和w，代碼y~.可展開為y~x+z+w
# –		        | 減號，表示從等式中移除某個變量，eg：y~(x+z+w)^2-x:w可展開為y~x+z+w+x:z+z:w
# -1		      | 刪除截距項，eg：表示y~x-1擬合y在x上的回歸，並強制直線通過原點
# I		        | 從算術的角度來解釋括號中的元素。Eg：y~x+(z+w)^2將展開為y~x+z+w+z:w。
#               相反，代碼y~x+I((z+w)^2)將展開為y~x+h，h是一個由z和w的平方和創建的新變量
# function		|可以在表達式中用的數學函數，例如log(y)~x+z+w表示通過x、z和w來預測log(y)

# 3. 使用 scatterplot 函數 -------
### car package 中的scatterplot函數，可以很容易、方便地繪製二元關係圖
library(car)
scatterplot(weight ~ height, data = women, 
            spread = FALSE, lty=1, smooth=TRUE, pch=19, 
            main="Women Age 30-39",
            xlab="Height (inches)",
            ylab="Weight(lbs.)")
### 如上是scatterplot對women數據所繪的身高與體重的散點圖。直線為線性擬合，虛線為曲線平滑擬合，邊界為箱線圖。

?scatterplot
# Makes enhanced scatterplots, with boxplots in the margins, a nonparametric regression smooth, smoothed conditional spread, outlier identification, and a regression line; sp is an abbreviation for scatterplot.
# 使用邊界盒形圖，非參數回歸平滑，平滑條件擴展，異常值識別和回歸線進行增強散點圖; sp是散點圖的縮寫。
# scatterplot 圖形解釋:

## 4. 多元線性回歸 -------
### 採用的數據集：state.x77
# 這裡以基礎包中的state.x77數據集為例，探究一個州的犯罪率和其他因素的關係，包括人口、文盲率、平均收入和結霜天數（溫度在冰點以下的平均天數）。
?state.x77
# US State Facts and Figures
# Description
# Data sets related to the 50 states of the United States of America.
# Usage
# 
# 1. state.abb
# 2. state.area
# 3. state.center
# 4. state.division
# 5. state.name
# 6. state.region
# 7. state.x77

### state.x77:
# * matrix with 50 rows and 8 columns giving the following statistics in the respective columns.
data(state.x77)
# 變數          | 說明
# _______________________________________________________________
# Population人口  | population estimate as of July 1, 1975
# Income收入水平  | per capita income (1974)
# Illiteracy文盲率| illiteracy (1970, percent of population)
# Life Exp生活開銷| life expectancy in years (1969–71)
# Murder謀殺率    | murder and non-negligent manslaughter rate per 100,000 population (1976)
# HS Grad高中畢業%| percent high-school graduates (1970)
# Frost結霜天數   | mean number of days with minimum temperature below freezing (1931–1960) in capital
# Area面積        | land area in square miles


head(state.x77)
#            Population Income Illiteracy Life Exp Murder HS Grad Frost   Area
# Alabama          3615   3624        2.1    69.05   15.1    41.3    20  50708
# Alaska            365   6315        1.5    69.31   11.3    66.7   152 566432
# Arizona          2212   4530        1.8    70.55    7.8    58.1    15 113417
# Arkansas         2110   3378        1.9    70.66   10.1    39.9    65  51945
# California      21198   5114        1.1    71.71   10.3    62.6    20 156361
# Colorado         2541   4884        0.7    72.06    6.8    63.9   166 103766

str(state.x77)
# num [1:50, 1:8] 3615 365 2212 2110 21198 ...
# - attr(*, "dimnames")=List of 2
#  ..$ : chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
#  ..$ : chr [1:8] "Population" "Income" "Illiteracy" "Life Exp" ...
class(state.x77)
# [1] "matrix"
dim(state.x77)
# [1] 50  8
summary(state.x77)

states <- as.data.frame(state.x77[ ,c("Murder","Population","Illiteracy","Income","Frost")])
head(states)
#            Murder Population Illiteracy Income Frost
# Alabama      15.1       3615        2.1   3624    20
# Alaska       11.3        365        1.5   6315   152
# Arizona       7.8       2212        1.8   4530    15
# Arkansas     10.1       2110        1.9   3378    65
# California   10.3      21198        1.1   5114    20
# Colorado      6.8       2541        0.7   4884   166

# colnames(states) <- c("謀殺率", "人口","文盲率", "收入水平", "結霜天數") 

# 檢測二變量關係
cor(states)
#                Murder Population Illiteracy     Income      Frost
# Murder      1.0000000  0.3436428  0.7029752 -0.2300776 -0.5388834
# Population  0.3436428  1.0000000  0.1076224  0.2082276 -0.3321525
# Illiteracy  0.7029752  0.1076224  1.0000000 -0.4370752 -0.6719470
# Income     -0.2300776  0.2082276 -0.4370752  1.0000000  0.2262822
# Frost      -0.5388834 -0.3321525 -0.6719470  0.2262822  1.0000000
#### cor函數顯示兩個變量之間的相關係數

## 各變量關係 ggpairs  繪圖
library(GGally)
ggpairs(states) # 該圖顯示的是兩兩變數的散佈圖

###  從ggpairs圖中可以看到，謀殺率是雙峰的曲線，每個預測變量都一定程度上出現了偏斜。謀殺率隨著人口和文盲率的增加而增加，隨著收入水平和結霜天數增加而下降。同時，越冷的州文盲率越低，收入水平越高。

## 各變量關係 scatterplotMatrix 繪圖
library(car)
scatterplotMatrix(states,spread=FALSE, lty=1, smooth=TRUE,main= "Scatter Plot Matrix")

### scatterplotMatrix函數默認在非對角線區域繪製變量間的散點圖，並添加平滑（loess）和線性擬合曲線

## 作業： 若要看相關性，我們可用它們的相關係數來繪製一個熱力圖(heatmap) 

# 多元線性回歸
statesFit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
summary(statesFit)
# 
# Call:
#     lm(formula = Murder ~ Population + Illiteracy + Income + Frost, 
#        data = states)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -4.7960 -1.6495 -0.0811  1.4815  7.6210 
# 
# Coefficients:
#     Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 1.235e+00  3.866e+00   0.319   0.7510    
# Population  2.237e-04  9.052e-05   2.471   0.0173 *  
# Illiteracy  4.143e+00  8.744e-01   4.738 2.19e-05 ***
# Income      6.442e-05  6.837e-04   0.094   0.9253    
# Frost       5.813e-04  1.005e-02   0.058   0.9541    
# ---
#     Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 2.535 on 45 degrees of freedom
# Multiple R-squared:  0.567,	Adjusted R-squared:  0.5285 
# F-statistic: 14.73 on 4 and 45 DF,  p-value: 9.133e-08

## Illiteracy  4.143e+00  8.744e-01   4.738 2.19e-05 *** <<< 代表什麼意義???

fitted(statesFit)

residuals(statesFit)

## 註: plots 頁籤要大一些!!
opar <- par(mfrow = c(2, 2), oma = c(0, 0, 1.1, 0))
plot(statesFit)
par(opar)
#### 對states數據做多項線性擬合，看人口、文盲率、收入水平、結霜天數對謀殺率的影響水平。
#### 從結果可以看出，文盲率和人口的係數是顯著的，結霜率和收入水平係數不顯著，這兩者對謀殺率的影響不是線性的。

## ## 作業：-----

### 4.2 多元回歸 案例二 -------
# housing <- read.table("http://www.jaredlander.com/data/housing.csv",
#                       sep = ",", header = TRUE,
#                       stringsAsFactors = FALSE)
housing <- read.csv("housing.csv")

names(housing) <- c("Neighborhood", "Class", "Units", "YearBuilt",
                    "SqFt", "Income", "IncomePerSqFt", "Expense",
                    "ExpensePerSqFt", "NetIncome", "Value",
                    "ValuePerSqFt", "Boro")

head(housing)

# ---------------------------------------------------------- #

ggplot(housing, aes(x=ValuePerSqFt)) +
  geom_histogram(binwidth=10) + labs(x="Value per Square Foot")

# ---------------------------------------------------------- #

ggplot(housing, aes(x=ValuePerSqFt, fill=Boro)) +
  geom_histogram(binwidth=10) + labs(x="Value per Square Foot")
ggplot(housing, aes(x=ValuePerSqFt, fill=Boro)) +
  geom_histogram(binwidth=10) + labs(x="Value per Square Foot") +
  facet_wrap(~Boro)

# ---------------------------------------------------------- #

ggplot(housing, aes(x=SqFt)) + geom_histogram()
ggplot(housing, aes(x=Units)) + geom_histogram()
ggplot(housing[housing$Units < 1000, ],
       aes(x=SqFt)) + geom_histogram()
ggplot(housing[housing$Units < 1000, ],
       aes(x=Units)) + geom_histogram()

# ---------------------------------------------------------- #

ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = Units, y = ValuePerSqFt)) + geom_point()
ggplot(housing[housing$Units < 1000, ], aes(x = SqFt,
                                            y = ValuePerSqFt)) + geom_point()
ggplot(housing[housing$Units < 1000, ], aes(x = Units,
                                            y = ValuePerSqFt)) + geom_point()

# 有多少種建築是要被移除的?
sum(housing$Units >= 1000)
##答案 : 6
# ---------------------------------------------------------- #

# 把它們(單位個數超過1000的建築)移除掉
housing <- housing[housing$Units < 1000, ]

# ---------------------------------------------------------- #

# 繪製ValuePerSqFt對SqFt的散佈圖
ggplot(housing, aes(x=SqFt, y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=log(SqFt), y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=SqFt, y=log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x=log(SqFt), y=log(ValuePerSqFt))) +
  geom_point()

# ---------------------------------------------------------- #

# 繪製ValuePerSqFt對Units的散佈圖
ggplot(housing, aes(x=Units, y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=log(Units), y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=Units, y=log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x=log(Units), y=log(ValuePerSqFt))) +
  geom_point()

# ---------------------------------------------------------- #

house1 <- lm(ValuePerSqFt ~ Units + SqFt + Boro, data = housing)
summary(house1)
#########################答案answer:
## Call:
##  lm(formula = ValuePerSqFt ~ Units + SqFt + Boro, data = housing)

##Residuals:
##  Min       1Q   Median       3Q      Max 
##-168.458  -22.680    1.493   26.290  261.761 

##Coefficients:
##  Estimate Std. Error t value Pr(>|t|)    
##(Intercept)        4.430e+01  5.342e+00   8.293  < 2e-16 ***
##  Units             -1.532e-01  2.421e-02  -6.330 2.88e-10 ***
##  SqFt               2.070e-04  2.129e-05   9.723  < 2e-16 ***
##  BoroBrooklyn       3.258e+01  5.561e+00   5.858 5.28e-09 ***
##  BoroManhattan      1.274e+02  5.459e+00  23.343  < 2e-16 ***
##BoroQueens         3.011e+01  5.711e+00   5.272 1.46e-07 ***
## BoroStaten Island -7.114e+00  1.001e+01  -0.711    0.477    
# ---------------------------------------------------------- #

house1$coefficients
coef(house1)

# 跟使用coef的結果一樣
coefficients(house1)

install.packages("coefplot")
require(coefplot)
coefplot(house1)
house2 <- lm(ValuePerSqFt ~ Units * SqFt + Boro, data = housing)
house3 <- lm(ValuePerSqFt ~ Units:SqFt + Boro, data = housing)
house2$coefficients
house3$coefficients
coefplot(house2)
coefplot(house3)

# ---------------------------------------------------------- #

house4 <- lm(ValuePerSqFt ~ SqFt * Units * Income, housing)
house4$coefficients

# ---------------------------------------------------------- #

house5 <- lm(ValuePerSqFt ~ Class * Boro, housing)
house5$coefficients

# ---------------------------------------------------------- #

coefplot(house1, sort='mag') + scale_x_continuous(limits=c(-.25, .1))
coefplot(house1, sort='mag') + scale_x_continuous(limits=c(-.0005, .0005))

# ---------------------------------------------------------- #

house1.b <- lm(ValuePerSqFt ~ scale(Units) + scale(SqFt) + Boro,
               data=housing)
coefplot(house1.b, sort='mag')

# ---------------------------------------------------------- #

house6 <- lm(ValuePerSqFt ~ I(SqFt/Units) + Boro, housing)
house6$coefficients

# ---------------------------------------------------------- #

house7 <- lm(ValuePerSqFt ~ (Units + SqFt)^2, housing)
house7$coefficients

house8 <- lm(ValuePerSqFt ~ Units * SqFt, housing)
identical(house7$coefficients, house8$coefficients)

house9 <- lm(ValuePerSqFt ~ I(Units + SqFt)^2, housing)
house9$coefficients

# ---------------------------------------------------------- #

# 也是從coefplot套件
multiplot(house1, house2, house3)

# ---------------------------------------------------------- #

housingNew <- read.table("http://www.jaredlander.com/data/housingNew.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)

# ---------------------------------------------------------- #

# 用新資料來做預測和建立95%信賴區間
housePredict <- predict(house1, newdata = housingNew, se.fit = TRUE,
                        interval = "prediction", level = .95)

# 顯示預測值和根據標準誤差建立的信賴區間上界和下界
head(housePredict$fit)

# 顯示預測值的標準誤差
head(housePredict$se.fit)

# End of 多元回歸 範例二

# 5.有交互項的多元線性回歸 ------
### 上面的例子是自變量之間相互獨立的，下面看一個有交互項的多元線性回歸的案例。
# * 有交互項的多元線性回歸
# * (http://biostatdept.cmu.edu.tw/doc/epaper_a/paper/teaching_corner_036-1.pdf)

data(mtcars)
head(mtcars)
#                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
# Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
# Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
# Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
# Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
# Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
# Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

mpgFit00 <- lm(mpg ~ hp+wt+hp+wt, data=mtcars)
summary(mpgFit00)
# Call:
#     lm(formula = mpg ~ hp + wt + hp + wt, data = mtcars)
# 
# Residuals:
#     Min     1Q Median     3Q    Max 
# -3.941 -1.600 -0.182  1.050  5.854 
# 
# Coefficients:
#     Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 37.22727    1.59879  23.285  < 2e-16 ***
# hp          -0.03177    0.00903  -3.519  0.00145 ** 
# wt          -3.87783    0.63273  -6.129 1.12e-06 ***

mpgFit <- lm(mpg ~ hp+wt+hp:wt, data=mtcars)
summary(mpgFit)
# Call:
#     lm(formula = mpg ~ hp + wt + hp:wt, data = mtcars)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -3.0632 -1.6491 -0.7362  1.4211  4.5513 
# 
# Coefficients:
#     Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 49.80842    3.60516  13.816 5.01e-14 ***
# hp          -0.12010    0.02470  -4.863 4.04e-05 ***
# wt          -8.21662    1.26971  -6.471 5.20e-07 ***
# hp:wt        0.02785    0.00742   3.753 0.000811 ***
#     ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 2.153 on 28 degrees of freedom
# Multiple R-squared:  0.8848,	Adjusted R-squared:  0.8724 
# F-statistic: 71.66 on 3 and 28 DF,  p-value: 2.981e-13

### 從summary(fit)的Pr(>|t|)欄中能看出，hp:wt項是顯著的，說明汽車的馬力和車重不是相互獨立的，兩者對每英里的耗油量的影響也都是顯著的。
### 汽車每英里耗油量mpg的模型為mpg = 49.81 - 0.12×hp - 8.21 × wt + 0.03 ×hp×wt。
 
opar <- par(mfrow = c(2, 2), oma = c(0, 0, 1.1, 0))
plot(mpgFit)
par(opar)

#補充: 通過effects包中的effect函數，可以用圖形展示交互項的結果 -------

mpgFit2<-lm(mpg ~ hp+wt+hp:wt,data=mtcars)
summary(mpgFit2)
# install.packages("effects")
library(effects)
#plot(effect("hp:wt",mpgFit2, list(wt=c(2.2,3.2,4.2))), multiline=TRUE)
plot(effect("hp:wt", mpgFit2, xlevels = list(wt = c(2.2, 3.2,4.2))), multiline = TRUE)

### effects包可以用來分析不同wt下，mpg與hp之間的線性關係。
# 如圖中能看出，當wt分別為2.2,3.2,4.2時mpg與hp之間的線性關係，差異還是很明顯的。

### 6.1 回歸診斷 ----------------
### summary方法能獲取模型的參數和相關統計量，要進一步診斷模型是否合適，還需要另外的工作。
### R中有許多檢驗回歸分析中統計假設的方法。
### plot方法可以生成評價模型擬合情況的四幅圖形。用women數據集的回歸模型為例：

fit <- lm(weight ~ height, data = women) 
par(mfrow = c(2, 2)) 
plot(fit) 
par(opar)

# 
# * 常態性：當預測變量值固定時，因變量成正態頒，則殘差圖也應是一個均值為0的正態頒。正態Q-Q圖是在正態頒對應的值上，標準化殘差的機率圖，若滿足正態假設，則圖上的點應該落在  45度角的直線上，若不是，則違反了正態性假設。
# * 獨立性：只能從收集的數據中來驗證。
# * 線性：若因變量與自變量線性相關，則殘差值與預測（擬合）值就沒有任務系統關聯，若存在關係，則說明可能城要對回歸模型進行調整。
# 同方差性：若滿足不變方差假設則在位置尺度圖（Scale-Location Graph）中，水平線周圍的點應隨機分布。
# 
# 1. 正態性當預測變量值固定時，因變量成正態分布，則殘差值也應該是一個均值為0的正態分布。正態Q-Q圖（Normal Q-Q，右上）是在正態分布對應的值下，標準化殘差的機率圖。若滿足正態假設，那麼圖上的點應該落在呈45度角的直線上；若不是如此，那麼就違反了正態性的假設。
# 2. 獨立性你無法從這些圖中分辨出因變量值是否相互獨立，只能從收集的數據中來驗證。上面的例子中，沒有任何先驗的理由去相信一位女性的體重會影響另外一位女性的體重。假若你發現數據是從一個家庭抽樣得來的，那麼可能必須要調整模型獨立性的假設。
# 3. 線性若因變量與自變量線性相關，那麼殘差值與預測（擬合）值就沒有任何系統關聯。換句話說，除了白噪聲，模型應該包含數據中所有的系統方差。在「殘差圖與擬合圖」（Residuals vs Fitted，左上）中可以清楚的看到"一個曲線關係"，這暗示著你可能需要對回歸模型加上一個二次項。
# 4. 同方差性若滿足不變方差假設，那麼在位置尺度圖（Scale-Location Graph，左下）中，水平線周圍的點應該隨機分布。該圖似乎滿足此假設。
# 5. 最後一幅「殘差與槓桿圖」（Residualsvs Leverage，右下）提供了你可能需要關注的單個觀測點的信息。從圖形可以鑑別出離群點、高槓桿值點和強影響點。
# * 一個觀測點是離群點，表明擬合回歸模型對其預測效果不佳（產生了巨大的或正或負的殘差）。
# * 一個觀測點有很高的槓桿值，表明它是一個異常的預測變量值的組合。也就是說，在預測變量空間中，它是一個離群點。因變量值不參與計算一個觀測點的槓桿值。
# * 一個觀測點是強影響點（influentialobservation），表明它對模型參數的估計產生的影響過大，非常不成比例。強影響點可以通過Cook距離即Cook’s D統計量來鑑別。

### 6.2 回歸診斷  再來看二次擬合的診斷圖-------------

newfit <- lm(weight ~ height + I(height^2), data = women) 
par(mfrow = c(2, 2)) 
plot(newfit) 
par(opar)

# 圖中有兩個比較明顯的離群點，13和15，可以刪除這兩個點後再做回歸，效果會更好。
newfit <- lm(weight ~ height + I(height^2), data = women[-c(13,15), ]) 
par(mfrow = c(2, 2)) 
plot(newfit) 
par(opar) 

# 另外car包中提供了許多方法可以增強擬合和評價回歸模型的能力# 回歸診斷

### 7.1 線性回歸 Linear Regression ----
# Linear regression is to predict response with a linear function of predictors as follows:
#   y = c0 + c1x1 + c2x2 +···+ ckxk,

# where x1, x2, · · · , xk are predictors and y is the response to predict.

# 下面用澳大利亞CPI（消費者價格指數）數據的函數lm（）來表示線性回歸，該數據是2008年至2010年的季度CPI
# Linear regression is demonstrated below with function lm() on the Australian CPI (Consumer Price Index) data, which are quarterly CPIs from 2008 to 2010 
# From Australian Bureau of Statistics <http://www.abs.gov.au>

year <- rep(2008:2010, each = 4)
year
# [1] 2008 2008 2008 2008 2009 2009 2009 2009 2010 2010 2010 2010

quarter <- rep(1:4, 3)
quarter
# [1] 1 2 3 4 1 2 3 4 1 2 3 4

cpi <- c(162.2, 164.6, 166.5, 166.0,
         166.2, 167.0, 168.6, 169.5,
         171.0, 172.1, 173.3, 174.0)
cpi
# [1] 162.2 164.6 166.5 166.0 166.2 167.0 168.6 169.5 171.0 172.1 173.3 174.0

plot(cpi, xaxt="n", ylab="CPI", xlab="", col = "red")
# draw x-axis >> las=3 文字直立
axis(1, labels = paste(year, quarter, sep="Q"), at=1:12, las=3)


# 我們檢查CPI和其他變量，年份和季度之間的相關性。
# We then check the correlation between CPI and the other variables, year and quarter.
cor(year, cpi)
# [1] 0.9096316
# 0.9 代表什麼意義呢?
cor(quarter, cpi)
# [1] 0.3738028

# 然後用上述數據的函數lm（）建立線性回歸模型，以年和季度為預測變量，以CPI為響應。
# Then a linear regression model is built with function lm() on the above data, using year and quarter as predictors and CPI as response. 

fit <- lm(cpi ~ year + quarter)
fit

# Call:
#   lm(formula = cpi ~ year + quarter)
# 
# Coefficients:
#   (Intercept)         year      quarter  
#     -7644.488        3.888        1.167

# With the above linear model, CPI is calculated as
#      cpi = c0 + c1 * year+ c2 * quarter
#      cpi = -7644.488 + 3.888 * year+ 1.167 * quarter

# where c0, c1 and c2 are coefficients from model fit. Therefore, the CPIs in 2011 can be get as follows. An easier way for this is using function predict(), which will be demonstrated at the end of this subsection.

names(fit) 
# [1] "coefficients"  "residuals"     "effects"       "rank"          "fitted.values"
# [6] "assign"        "qr"            "df.residual"   "xlevels"       "call"         
# [11] "terms"         "model" 

fit$coefficients
#  (Intercept)         year      quarter 
# -7644.487500     3.887500     1.166667 

fit$coefficients[1]
fit$coefficients[2]
fit$coefficients[3]
#  quarter 
# 1.166667
class(fit$coefficients[2])
typeof(fit$coefficients[2])

fit$coefficients[[3]]
# [1] 1.166667
class(fit$coefficients[[3]])

## 簡單預測 2011 年的 cpi 走勢  >> 套用公式
(cpi2011 <- fit$coefficients[[1]] + fit$coefficients[[2]]*2011 +
                   fit$coefficients[[3]]*(1:4))
# [1] 174.4417 175.6083 176.7750 177.9417

(cpiAll <- c(cpi, cpi2011))
#  [1] 162.2000 164.6000 166.5000 166.0000 166.2000 167.0000 168.6000 169.5000 171.0000 172.1000 173.3000
# [12] 174.0000 174.4417 175.6083 176.7750 177.9417

plot(cpiAll, xaxt="n", ylab="CPI", xlab="", col = "red")
# draw x-axis >> las=3 文字直立
year01 <- rep(2008:2011, each = 4)
quarter01 <- rep(1:4, 4)
axis(1, labels = paste(year01, quarter01, sep="Q"), at=1:16, las=3)

attributes(fit)
# $names
# [1] "coefficients"  "residuals"     "effects"       "rank"          "fitted.values"
# [6] "assign"        "qr"            "df.residual"   "xlevels"       "call"         
# [11] "terms"         "model"        
# 
# $class
# [1] "lm"

fit$coefficients
#  (Intercept)         year      quarter 
# -7644.487500     3.887500     1.166667 

# 觀測值與擬合值之間的差異可以用函數殘差（）來獲得。 觀測值與擬合值之間的差異
# The differences between observed values and fitted values can be obtained with function residuals().
# differences between observed values and fitted values3

# 觀測值與擬合值之間的差異(殘差)
residuals(fit)
#           1           2           3           4           5           6           7 
# -0.57916667  0.65416667  1.38750000 -0.27916667 -0.46666667 -0.83333333 -0.40000000 
#           8           9          10          11          12 
# -0.66666667  0.44583333  0.37916667  0.41250000 -0.05416667 

summary(fit)
# Call:
#   lm(formula = cpi ~ year + quarter)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -0.8333 -0.4948 -0.1667  0.4208  1.3875 
# 
# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -7644.4875   518.6543 -14.739 1.31e-07 ***
# year            3.8875     0.2582  15.058 1.09e-07 ***
# quarter         1.1667     0.1885   6.188 0.000161 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.7302 on 9 degrees of freedom 
# (殘差的標準差(standard error of residual)：表示樣本點與樣本迴歸線間的離散度。 )
# Multiple R-squared:  0.9672,	Adjusted R-squared:  0.9599 (表示模型預測能力不錯。) 
# F-statistic: 132.5 on 2 and 9 DF,  p-value: 2.108e-07

# We then plot the fitted model as below.
# 一次顯示一張圖
plot(fit)

par(mfrow=c(2,2))
plot(fit)
par(mfrow=c(1,1))

# 我們還可以在3D圖中繪製模型，如下所示，其中函數scatterplot3d（）創建3D散點圖，plane3d（）繪製擬合的平面。 參數實驗室指定x軸和y軸上的標記數量。
# We can also plot the model in a 3D plot as below, where function scatterplot3d() creates a 3D scatter plot and plane3d() draws the fitted plane. Parameter lab specifies the number of tickmarks on the x- and y-axes.

library(scatterplot3d)
s3d <- scatterplot3d(year, quarter, cpi, highlight.3d=T, type="h", lab=c(2,3))
s3d$plane3d(fit)

# 通過該模型，2011年的CPI可以預測如下，預測值在圖中以紅色三角形顯示。
# With the model, the CPIs in year 2011 can be predicted as follows, and the predicted values are shown as red triangles in Figure.

# Prediction of CPIs in 2011 with Linear Regression Model
data2011 <- data.frame(year=2011, quarter=1:4)
cpi2011 <- predict(fit, newdata=data2011)
style <- c(rep(1,12), rep(2,4))  # << 知道什麼意義?
plot(c(cpi, cpi2011), xaxt="n", ylab="CPI", xlab="", pch=style, col=style)
axis(1, at=1:16, las=3,
     labels=c(paste(year,quarter,sep="Q"), 
              "2011Q1", "2011Q2", "2011Q3", "2011Q4"))

### 7.2 Logistic Regression ------
# Logistic regression is used to predict the probability of occurrence of an event by fitting data to a logistic curve. A logistic regression model is built as the following equation:
#   logit(y)=c0 +c1x1 +c2x2 +···+ckxk,
# where x1, x2, · · · , xk are predictors, y is a response to predict, and logit(y) = ln( y ). The above equation can also be written as
# y=1 / (1+e (c0+c1x1+c2x2+···+ckxk))

# Logistic regression can be built with function glm()

# Detailed introductions on logistic regression can be found at the following links.
# ‧ R Data Analysis Examples - Logit Regression http://www.ats.ucla.edu/stat/r/dae/logit.htm
# ‧ Logistic Regression (with R) http://nlp.stanford.edu/~manning/courses/ling289/logistic.pdf


### 7.3 廣義線性 Generalized Linear Regression -----
# The generalized linear model (GLM) generalizes linear regression by allowing the linear model to be related to the response variable via a link function and allowing the magnitude of the variance of each measurement to be a function of its predicted value. It unifies various other statistical models, including linear regression, logistic regression and Poisson regression. Function glm() is used to fit generalized linear models, specified by giving a symbolic description of the linear predictor and a description of the error distribution.
# A generalized linear model is built below with glm() on the bodyfat data (see Section 1.3.2 for details of the data).

??bodyfat

# Prediction of Body Fat by Skinfold Thickness, Circumferences, and Bone Breadths
# 通過皮褶厚度，周長和骨寬度預測體脂
# the women's body composition was measured by Dual Energy X-Ray Absorptiometry (DXA)
# 通過雙能量X射線吸收測定法（DXA）測量女性的身體組成，
# Bodyfat is a dataset available in package TH.data [Hothorn, 2015]. 
# It has 71 rows, and each row contains information of one person. 
# It contains the following 10 numeric columns.

# ‧ age: age in years.年齡。
# ‧ DEXfat: body fat measured by DXA, response variable.由DXA測量的身體脂肪，反應變量。
# ‧ waistcirc: waist circumference.腰圍。
# ‧ hipcirc: hip circumference.臀圍。
# ‧ elbowbreadth: breadth of the elbow.手肘部的寬度。
# ‧ kneebreadth: breadth of the knee.膝蓋的寬度。
# ‧ anthro3a: sum of logarithm of three anthropometric measurements. 
# ‧ anthro3b: sum of logarithm of three anthropometric measurements. 
# ‧ anthro3c: sum of logarithm of three anthropometric measurements.
# ‧ anthro4: sum of logarithm of three anthropometric measurements.

data("bodyfat", package="TH.data")
str(bodyfat)

myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + kneebreadth

bodyfat.glm <- glm(myFormula, family = gaussian("log"), data = bodyfat)

summary(bodyfat.glm)

# Call:
# glm(formula = myFormula, family = gaussian("log"), data = bodyfat)
# 
# Deviance Residuals: 
#      Min        1Q    Median        3Q       Max  
# -11.5688   -3.0065    0.1266    2.8310   10.0966  
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  0.734293   0.308949   2.377  0.02042 *  
# age          0.002129   0.001446   1.473  0.14560    
# waistcirc    0.010489   0.002479   4.231 7.44e-05 ***
# hipcirc      0.009702   0.003231   3.003  0.00379 ** 
# elbowbreadth 0.002355   0.045686   0.052  0.95905    
# kneebreadth  0.063188   0.028193   2.241  0.02843 *  
#   ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for gaussian family taken to be 20.31433)
# 
#     Null deviance: 8536.0  on 70  degrees of freedom
# Residual deviance: 1320.4  on 65  degrees of freedom
# AIC: 423.02
# 
# Number of Fisher Scoring iterations: 5

## 7.4 glm() 與lm() 差異 -------
# 做簡單線性回歸，沒區別。但glm比lm功能強大，可以做離散因變量模型等。
# 廣義線性模型（GLM）
# 在R中通常使用glm函數構造廣義線性模型，其中分佈參數包括了binomaial（兩項分佈）、gaussian（正態分佈）、
# gamma（伽馬分佈）、poisson(泊松分佈)等。和lm函數類似，glm的建模結果可以通過下述的泛型函數進行二次處理，
# 如summary()、coef()、confint()、residuals()、anova()、plot()、predict( )

bodyfat.lm01 <- lm(myFormula, data = bodyfat)
summary(bodyfat.lm01)

bodyfat.lm02 <- lm(myFormula, family = gaussian("log"), data = bodyfat)
summary(bodyfat.lm02)

## 
# 在下面的代碼中，type表示所需的預測類型。 默認值是線性預測變量的大小而備選“響應”是響應變量的大小。
# In the code below, type indicates the type of prediction required. The default is on the scale of the linear predictors, and the alternative "response" is on the scale of the response variable.
pred <- predict(bodyfat.glm, type="response")
pred

plot(bodyfat$DEXfat, pred, xlab="Observed Values", ylab="Predicted Values", col = "blue")
abline(a=0, b=1, col = "red")

# In the above code, if family=gaussian("identity") is used, the built model would be similar to linear regression. One can also make it a logistic regression by setting family to binomial("logit").
pred <- predict(bodyfat.glm, type="response", family = gaussian("identity"))
pred
plot(bodyfat$DEXfat, pred, xlab="Observed Values", ylab="Predicted Values", col = "blue")
abline(a=0, b=1, col = "red")

pred <- predict(bodyfat.glm, type="response", family = binomail("logit"))
pred
plot(bodyfat$DEXfat, pred, xlab="Observed Values", ylab="Predicted Values", col = "blue")
abline(a=0, b=1, col = "red")


### 8. Fitting Generalized Linear Models 原廠文件 -------------
?glm

# Examples

## Dobson (1990) Page 93: Randomized Controlled Trial :
counts <- c(18,17,15,20,10,20,25,13,12)
outcome <- gl(3,1,9)
treatment <- gl(3,3)
print(d.AD <- data.frame(treatment, outcome, counts))
glm.D93 <- glm(counts ~ outcome + treatment, family = poisson())
anova(glm.D93)
summary(glm.D93)

## an example with offsets from Venables & Ripley (2002, p.189)
utils::data(anorexia, package = "MASS")

anorex.1 <- glm(Postwt ~ Prewt + Treat + offset(Prewt),
                family = gaussian, data = anorexia)
summary(anorex.1)


# A Gamma example, from McCullagh & Nelder (1989, pp. 300-2)
clotting <- data.frame(
  u = c(5,10,15,20,30,40,60,80,100),
  lot1 = c(118,58,42,35,27,25,21,19,18),
  lot2 = c(69,35,26,21,18,16,13,12,12))
summary(glm(lot1 ~ log(u), data = clotting, family = Gamma))
summary(glm(lot2 ~ log(u), data = clotting, family = Gamma))

## Not run: 
## for an example of the use of a terms object as a formula
demo(glm.vr)

## End(Not run)

### 9. 非線性回歸 Non-linear Regression (自行閱讀)----  
# While linear regression is to find the line that comes closest to data, non-linear regression is to fit a curve through data. Function nls() provides nonlinear regression. Examples of nls() can be found by running “?nls” under R.

?nls

# Examples
require(graphics)

DNase1 <- subset(DNase, Run == 1)

## using a selfStart model
fm1DNase1 <- nls(density ~ SSlogis(log(conc), Asym, xmid, scal), DNase1)
summary(fm1DNase1)
## the coefficients only:
coef(fm1DNase1)
## including their SE, etc:
coef(summary(fm1DNase1))

## using conditional linearity
fm2DNase1 <- nls(density ~ 1/(1 + exp((xmid - log(conc))/scal)),
                 data = DNase1,
                 start = list(xmid = 0, scal = 1),
                 algorithm = "plinear")
summary(fm2DNase1)

## without conditional linearity
fm3DNase1 <- nls(density ~ Asym/(1 + exp((xmid - log(conc))/scal)),
                 data = DNase1,
                 start = list(Asym = 3, xmid = 0, scal = 1))
summary(fm3DNase1)

## using Port's nl2sol algorithm
fm4DNase1 <- nls(density ~ Asym/(1 + exp((xmid - log(conc))/scal)),
                 data = DNase1,
                 start = list(Asym = 3, xmid = 0, scal = 1),
                 algorithm = "port")
summary(fm4DNase1)

## weighted nonlinear regression
Treated <- Puromycin[Puromycin$state == "treated", ]
weighted.MM <- function(resp, conc, Vm, K)
{
  ## Purpose: exactly as white book p. 451 -- RHS for nls()
  ##  Weighted version of Michaelis-Menten model
  ## ----------------------------------------------------------
  ## Arguments: 'y', 'x' and the two parameters (see book)
  ## ----------------------------------------------------------
  ## Author: Martin Maechler, Date: 23 Mar 2001
  
  pred <- (Vm * conc)/(K + conc)
  (resp - pred) / sqrt(pred)
}

Pur.wt <- nls( ~ weighted.MM(rate, conc, Vm, K), data = Treated,
               start = list(Vm = 200, K = 0.1))
summary(Pur.wt)

## Passing arguments using a list that can not be coerced to a data.frame
lisTreat <- with(Treated,
                 list(conc1 = conc[1], conc.1 = conc[-1], rate = rate))

weighted.MM1 <- function(resp, conc1, conc.1, Vm, K)
{
  conc <- c(conc1, conc.1)
  pred <- (Vm * conc)/(K + conc)
  (resp - pred) / sqrt(pred)
}
Pur.wt1 <- nls( ~ weighted.MM1(rate, conc1, conc.1, Vm, K),
                data = lisTreat, start = list(Vm = 200, K = 0.1))
stopifnot(all.equal(coef(Pur.wt), coef(Pur.wt1)))

## Chambers and Hastie (1992) Statistical Models in S  (p. 537):
## If the value of the right side [of formula] has an attribute called
## 'gradient' this should be a matrix with the number of rows equal
## to the length of the response and one column for each parameter.

weighted.MM.grad <- function(resp, conc1, conc.1, Vm, K)
{
  conc <- c(conc1, conc.1)
  
  K.conc <- K+conc
  dy.dV <- conc/K.conc
  dy.dK <- -Vm*dy.dV/K.conc
  pred <- Vm*dy.dV
  pred.5 <- sqrt(pred)
  dev <- (resp - pred) / pred.5
  Ddev <- -0.5*(resp+pred)/(pred.5*pred)
  attr(dev, "gradient") <- Ddev * cbind(Vm = dy.dV, K = dy.dK)
  dev
}

Pur.wt.grad <- nls( ~ weighted.MM.grad(rate, conc1, conc.1, Vm, K),
                    data = lisTreat, start = list(Vm = 200, K = 0.1))

rbind(coef(Pur.wt), coef(Pur.wt1), coef(Pur.wt.grad))

## In this example, there seems no advantage to providing the gradient.
## In other cases, there might be.


## The two examples below show that you can fit a model to
## artificial data with noise but not to artificial data
## without noise.
x <- 1:10
y <- 2*x + 3                            # perfect fit
yeps <- y + rnorm(length(y), sd = 0.01) # added noise
nls(yeps ~ a + b*x, start = list(a = 0.12345, b = 0.54321))
## terminates in an error, because convergence cannot be confirmed:
try(nls(y ~ a + b*x, start = list(a = 0.12345, b = 0.54321)))

## the nls() internal cheap guess for starting values can be sufficient:

x <- -(1:100)/10
y <- 100 + 10 * exp(x / 2) + rnorm(x)/10
nlmod <- nls(y ~  Const + A * exp(B * x))

plot(x,y, main = "nls(*), data, true function and fit, n=100")
curve(100 + 10 * exp(x / 2), col = 4, add = TRUE)
lines(x, predict(nlmod), col = 2)



## The muscle dataset in MASS is from an experiment on muscle
## contraction on 21 animals.  The observed variables are Strip
## (identifier of muscle), Conc (Cacl concentration) and Length
## (resulting length of muscle section).
utils::data(muscle, package = "MASS")

## The non linear model considered is
##       Length = alpha + beta*exp(-Conc/theta) + error
## where theta is constant but alpha and beta may vary with Strip.

with(muscle, table(Strip)) # 2, 3 or 4 obs per strip

## We first use the plinear algorithm to fit an overall model,
## ignoring that alpha and beta might vary with Strip.

musc.1 <- nls(Length ~ cbind(1, exp(-Conc/th)), muscle,
              start = list(th = 1), algorithm = "plinear")
summary(musc.1)

## Then we use nls' indexing feature for parameters in non-linear
## models to use the conventional algorithm to fit a model in which
## alpha and beta vary with Strip.  The starting values are provided
## by the previously fitted model.
## Note that with indexed parameters, the starting values must be
## given in a list (with names):
b <- coef(musc.1)
musc.2 <- nls(Length ~ a[Strip] + b[Strip]*exp(-Conc/th), muscle,
              start = list(a = rep(b[2], 21), b = rep(b[3], 21), th = b[1]))
summary(musc.2)

### 10. 台中市空污資料 --------------
library(dplyr)
library(ggplot2)

## 載入data_20180321.csv 資料集而且出現正確的中文字型？
air <- read.csv("data_20180321.csv", encoding = "big5")
View(air)
str(air)
dim(air)

names(air)
# [1] "id"                  "year"                "month"               "day"                
# [5] "hour"                "p592"                "district"            "station"            
# [9] "o3"                  "o3_linear"           "o3_log"              "o3_catmull"         
# [13] "o3_cardinal"         "pm25"                "pm25_ab"             "pm25_linear"        
# [17] "pm25_log"            "pm25_catmull"        "pm25_cardinal"       "pm10"               
# [21] "pm10_linear"         "pm10_log"            "pm10_catmull"        "pm10_cardinal"      
# [25] "co"                  "co_linear"           "co_log"              "co_catmull"         
# [29] "co_cardinal"         "so2"                 "so2_linear"          "so2_log"            
# [33] "so2_catmull"         "so2_cardinal"        "no2"                 "no2_linear"         
# [37] "no2_log"             "no2_catmull"         "no2_cardinal"        "aqi"                
# [41] "amb_temp"            "amb_temp_ab"         "amb_temp_linear"     "amb_temp_log"       
# [45] "amb_temp_catmull"    "amb_temp_cardinal"   "benzene"             "ch4"                
# [49] "co2"                 "ethylbenzene"        "m_p_xylenes"         "nmhc"               
# [53] "no"                  "no_linear"           "no_log"              "no_catmull"         
# [57] "no_cardinal"         "nox"                 "nox_linear"          "nox_log"            
# [61] "nox_catmull"         "nox_cardinal"        "o_xylene"            "ph_rain"            
# [65] "rain_cond"           "rain_int"            "rh"                  "rh_ab"              
# [69] "rh_linear"           "rh_log"              "rh_catmull"          "rh_cardinal"        
# [73] "thc"                 "toluene"             "wd_hr"               "wind_direc"         
# [77] "wind_speed"          "wind_speed_linear"   "wind_speed_log"      "wind_speed_catmull" 
# [81] "wind_speed_cardinal" "ws_hr"               "ws_hr_linear"        "ws_hr_log"          
# [85] "ws_hr_catmull"       "ws_hr_cardinal"    
## 欄位對照表
# 1	id	序號
# 2	year	監測時間（年）
# 3	month	監測時間（月）
# 4	day	監測時間（日）
# 5	hour	監測時間（時）
# 6	city	縣市
# 7	district	鄉鎮市區
# 8	station	測站
# 9	o3	臭氧 O3 (ppb)
# 10	o3_linear	遺漏值處理
# 11	o3_log	遺漏值處理
# 12	o3_catmull	遺漏值處理
# 13	o3_cardinal	遺漏值處理
# 14	pm25	細懸浮微粒 PM2.5 (μg/m3)
# 15	pm25_ab	鄰近AirBox細懸浮微粒 PM2.5 (μg/m3)
# 16	pm25_linear	遺漏值處理
# 17	pm25_log	遺漏值處理
# 18	pm25_catmull	遺漏值處理
# 19	pm25_cardinal	遺漏值處理
# 20	pm10	懸浮微粒 PM10 (μg/m3)
# 21	pm10_linear	遺漏值處理
# 22	pm10_log	遺漏值處理
# 23	pm10_catmull	遺漏值處理
# 24	pm10_cardinal	遺漏值處理
# 25	co	一氧化碳 CO (ppm)
# 26	co_linear	遺漏值處理
# 27	co_log	遺漏值處理
# 28	co_catmull	遺漏值處理
# 29	co_cardinal	遺漏值處理
# 30	so2	二氧化硫 SO2 (ppb)
# 31	so2_linear	遺漏值處理
# 32	so2_log	遺漏值處理
# 33	so2_catmull	遺漏值處理
# 34	so2_cardinal	遺漏值處理
# 35	no2	二氧化氮 NO2 (ppb)
# 36	no2_linear	遺漏值處理
# 37	no2_log	遺漏值處理
# 38	no2_catmull	遺漏值處理
# 39	no2_cardinal	遺漏值處理
# 40	aqi	即時空氣品質指標
# 41	amb_temp	溫度 AMB_TEMP (℃)
# 42	amb_temp_ab	鄰近AirBox溫度 AMB_TEMP (℃)
# 43	amb_temp_linear	遺漏值處理
# 44	amb_temp_log	遺漏值處理
# 45	amb_temp_catmull	遺漏值處理
# 46	amb_cardinal	遺漏值處理
# 47	benzene	苯 BENZENE (ppb)
# 48	ch4	"甲烷 CH4 (ppm)	"
# 49	co2	二氧化碳 CO2
# 50	ethylbenzene	乙苯 ETHYLBENZENE (ppb)
# 51	m_p_xylenes	間、對二甲苯 M_P_XYLENES (ppb)
# 52	nmhc	非甲烷碳氫化合物 NMHC (ppm)
# 53	no	一氧化氮 NO (ppb)
# 54	no_linear	遺漏值處理
# 55	no_log	遺漏值處理
# 56	no_catmull	遺漏值處理
# 57	no_cardinal	遺漏值處理
# 58	nox	氮氧化物 NOx (ppb)
# 59	nox_linear	遺漏值處理
# 60	nox_log	遺漏值處理
# 61	nox_catmull	遺漏值處理
# 62	nox_cardinal	遺漏值處理
# 63	o_xylene	"鄰二甲苯 O_XYLENE (ppb)	"
# 64	ph_rain	酸雨
# 65	rain_cond	導電度
# 66	rain_int	降雨強度
# 67	rh	相對濕度 RH (percent)
# 68	rh_ab	鄰近AirBox相對濕度 RH (percent)
# 69	rh_linear	遺漏值處理
# 70	rh_log	遺漏值處理
# 71	rh_catmull	遺漏值處理
# 72	rh_cardinal	遺漏值處理
# 73	thc	總碳氫化合物 THC (ppm)
# 74	toluene	甲苯 TOLUENE
# 75	wd_hr	小時風向值 WD_HR (degrees)
# 76	wind_direc	風向 WIND_DIREC (degrees)
# 77	wind_speed	風速 WIND_SPEED (m/sec)
# 78	wind_speed_linear	遺漏值處理
# 79	wind_speed_log	遺漏值處理
# 80	wind_speed_catmull	遺漏值處理
# 81	wind_speed_cardinal	遺漏值處理
# 82	ws_hr	小時風速值 WS_HR (m/sec)
# 83	ws_hr_linear	遺漏值處理
# 84	ws_hr_log	遺漏值處理
# 85	ws_hr_catmull	遺漏值處理
# 86	ws_hr_cardinal	遺漏值處理

##  Cardinal 遺落值補法 
airCardinal00 <- select(air, id:station, o3_cardinal, pm25_cardinal, pm25_ab, pm10_cardinal, co_cardinal, so2_cardinal, no2_cardinal, amb_temp_cardinal, amb_temp_ab, benzene, ch4, co2, m_p_xylenes, nmhc, no_cardinal, nox_cardinal, ph_rain, rain_cond, rain_int, rh_cardinal, rh_ab, thc, toluene, wd_hr, wind_direc, wind_speed_cardinal, ws_hr_cardinal)
dim(airCardinal)

airCardinal <- select(air, id:station, o3_cardinal, pm25_cardinal, pm25_ab, pm10_cardinal, co_cardinal, so2_cardinal, no2_cardinal, amb_temp_cardinal, amb_temp_ab, benzene, ch4, co2, m_p_xylenes, nmhc, no_cardinal, nox_cardinal, ph_rain, rain_cond, rain_int, rh_cardinal, rh_ab, thc, toluene, wd_hr, wind_direc, wind_speed_cardinal, ws_hr_cardinal)
dim(airCardinal)

sum(is.na(airCardinal))  # [1] 517135

airCardinalForTree <- select(airCardinal, o3_cardinal, pm25_cardinal, 
                             pm10_cardinal:amb_temp_cardinal, no_cardinal, 
                             nox_cardinal, rh_cardinal, 
                             wind_speed_cardinal, ws_hr_cardinal)
airFit <- glm(pm25_cardinal ~ ., data=airCardinalForTree)
summary(airFit)

# Call:
#     glm(formula = pm25_cardinal ~ ., data = airCardinalForTree)
# 
# Deviance Residuals: 
#     Min       1Q   Median       3Q      Max  
# -93.801   -4.724   -0.245    4.434   43.849  
# 
# Coefficients:
#     Estimate Std. Error t value Pr(>|t|)    
#     (Intercept)         -1.145451   0.400746  -2.858  0.00426 ** 
#     o3_cardinal          0.105591   0.002676  39.465  < 2e-16 ***
#     pm10_cardinal        0.404488   0.001766 229.038  < 2e-16 ***
#     co_cardinal          3.022555   0.186399  16.216  < 2e-16 ***
#     so2_cardinal         0.241446   0.020722  11.652  < 2e-16 ***
#     no2_cardinal        -0.207212   0.094146  -2.201  0.02774 *  
#     amb_temp_cardinal   -0.058078   0.006639  -8.748  < 2e-16 ***
#     no_cardinal         -0.279424   0.094223  -2.966  0.00302 ** 
#     nox_cardinal         0.293649   0.094003   3.124  0.00179 ** 
#     rh_cardinal          0.033807   0.003737   9.048  < 2e-16 ***
#     wind_speed_cardinal -0.600025   0.035995 -16.670  < 2e-16 ***
#     ws_hr_cardinal      -0.686293   0.042584 -16.116  < 2e-16 ***
#     ---
#     Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for gaussian family taken to be 54.39819)
# 
# Null deviance: 8770518  on 51239  degrees of freedom
# Residual deviance: 2786710  on 51228  degrees of freedom
# AIC: 350199
# 
# Number of Fisher Scoring iterations: 2

airFit02 <- glm(pm25_cardinal ~ ., data=airCardinal)
summary(airFit02)
# Error in `contrasts<-`(`*tmp*`, value = contr.funs[1 + isOF[nn]]) : 
#     contrasts can be applied only to factors with 2 or more levels

dim(airCardinal)  # [1] 51240    35
airFit03 <- glm(pm25_cardinal ~ ., data=airCardinal[ ,9:35])
summary(airFit02)


