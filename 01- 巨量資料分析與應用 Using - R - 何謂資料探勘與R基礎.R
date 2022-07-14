### 巨量資料分析與應用 Using - R --------
# 東海大學資訊管理學系 姜自強博士

### 1-1 何謂資料探勘------
# 資料探勘(Data Mining)或是數據挖掘是從大量數據中發現有趣的知識的過程。
# 這是一個跨領域學科的技術，從許多領域的貢獻，如統計學，機器學習，信息檢索，模式識別和生物信息學。
# 資料探勘在醫療、零售，金融，電信，社會等諸多領域得到廣泛應用媒體。
# 資料探勘的主要技術包括分類和預測，聚類，異常檢測，關聯規則，序列分析，時間序列分析和文本挖掘等等
# 社交網絡分析和情感分析等新技術。
# 資料探勘(Data Mining)是透過自動或半自動化的方式對大量的數據進行探索和分析的過程，
# 從其中發掘出有意義或有興趣的現象，進而歸納出有脈絡可循的模式(Model)，並藉反覆印證找出意想之外可行的執行方案。
# 在現實世界的應用程序中，資料探勘的過程可以分為六個主要階段：業務理解，數據理解，數據準備，
# 建模，評估和部署。

# 延伸閱讀:
# 1. What is Data Mining? https://youtu.be/R-sGvh6tI04 (可以開啟字幕與中文自動翻譯，建議第一次先聽英文) 3:21

# 2. 小餐廳大資料 Small Restaurant Big Data （中文字幕）https://youtu.be/Qa6p3Sy7g-Q    3:11
#     http://www.ichef.tw/big-data.html
#     小餐廳大資料 Small Restaurant Big Data
#     探索餐廳的資料小宇宙...
#     餐廳所產生的資料，不只營收報表上那麼簡單。其實 iCHEF POS App 紀錄的每筆交易背後，
#     都有包含口味偏好、經手人員、以及出菜時間等，超過 40 個資料點。
#     一家每天 100 組客人的小餐廳，每年就會產生超過 100 萬筆資料點，以及超過 2 兆種關聯的方式，
#     這數字比我們銀河系的行星數還多 10 倍。透過大資料科技探索這些資料的關聯性，
#     我們或許能讓小餐廳用自身資料，找到預測自己未來的方式。

# 3. MIGO功典【零售業】知名運動品牌大數據應用案例 https://youtu.be/Q6xEnHBDr6s  4:16
#     台灣零售實體店數據採集與分析應用實例

### 1-1 作業 ----
### 1. 請點閱 延伸閱讀: 的三個案例?
### 2. 請到Youtube 找出資料探勘(Data Mining)運用的三個案例影片?
###   1.https://youtu.be/AezkugUtePo
###   2.https://youtu.be/bkcAmCqIaao
###   3.https://youtu.be/Q6xEnHBDr6s
### 3. 請告訴我你對資料探勘的解譯與想要運用資料探勘來解決什麼問題?
###   A.資料探勘就是在大量資料中找尋特別且可以應用在生活或科技上的關連，並發展成另一類產業。
###     我會想使資料探勘在商業的應用更加廣大，主要想朝利用現有的資料來分析出未來下一個崛起、有商業價值的商品。
### 4. 何謂大數據(Big Data)?
###   A.指的是在傳統數據處理應用軟件不足以處理的大或複雜的數據集的術語。
###     可以定義為来自各種來源的大量非結構化或結構化數據。
###     他的出現促成廣泛主題的新穎研究。 這也導致各種大數據統計方法的發展。
### 1-2 R 的基礎: -----
# R是一個免費的統計計算和圖形軟件環境。它提供了各種各樣的統計和圖形技術。
# R在CRAN上提供了超過一萬個套件(軟件包)

# 必學的幾個R套件 ---
# http://dataology.blogspot.tw/2015/02/10r.html

# ggplot2 
# 這個套件是玩R繪圖必須知道的套件，
# 擁有非常強大的繪圖功能。早些年ggplot2與lattice同為高級繪圖套件，不過看來ggplot2略勝一籌。
# 
# plyr
# 這個套件可以將vector、list、data.frame的資料做快速的切割、應用、組合，是非常好用的套件，
# 像是join功能，可以做inner、left、right、full等join功能。
# plyr可以讓工程師以資料庫的概念，有效率的把玩資料。
# 
# dplyr
# 這個套件跟plyr類似，但是針對data.frame、data.table、以及多種資料庫為基礎的資料。
# 將資料做快速的切割、應用、組合，尤其處理大量資料，dplyr是非常好用的工具。 
# 
# 
# reshape2 
# 這個套件可以幫助我們將資料進行縱向、橫向轉換，筆者發現對於該套件處理連續型或時間資料是非常好用的，
# 如空氣品質資料、證券行情資料等。通常會再搭配dplyr，讓資料分析事半功倍。
# 
# stringr
# 這個可以透過正規表示式(Regular Expression)去處理大量的字串，像是檢查、配對、替換等等。
# 
# lubridate  
# 主要提供日期、時間、時區的標準化處理。
# 
# shiny
# 這個套件是做原型(prototype)非常好用的工具，尤其在大型公司的資料團隊，我們經常會需要做原型在進行展示。
# 透過shiny就可以達到這個目的。知名的例子像是ebay就是採用shiny產生原型測試後，在用Java語言佈署到應用層。

### 1-2-1 R 軟體的安裝: ----
# The R Project for Statistical Computing    https://www.r-project.org/
# Download and Install R                     http://cran.csie.ntu.edu.tw/   

# Download R for Linux
# Download R for (Mac) OS X
# Download R for Windows

### 1-2-2 RStudio 軟體的安裝: ----
# RStudio – Open source and enterprise-ready professional software for R    https://www.rstudio.com/
# Download and Install RStudio          https://www.rstudio.com/products/rstudio/download/#download

### 1-2 作業 ----
### 請問目前 R 有多少套件類別，以及目前一共有多少套件?
### A.15367

### 1-3 R 內建常用的資料集(Datasets) 與 online HELP 線上查詢------
# http://ccckmit.wikidot.com/r:dataset

# 找出所有已安裝的資料集
data(package = .packages(all.available = TRUE))

# CO2           Carbon Dioxide Uptake in Grass Plants (草地植物對二氧化碳的吸收)
# co2           Mauna Loa Atmospheric CO2 Concentration
# cars          Speed and Stopping Distances of Cars
# ChickWeight   Weight versus age of chicks on different diets (體重與不同年齡雞的飲食)
# airquality    New York Air Quality Measurements
# iris          Edgar Anderson's Iris Data
# mtcars        Motor Trend Car Road Tests
# faithful      Old Faithful Geyser Data
# occupationalStatus     Occupational Status of Fathers and their Sons
# volcano       Topographic Information on Auckland's Maunga Whau Volcano
# women         Average Heights and Weights for American Women

#1. CO2           Carbon Dioxide Uptake in Grass Plants (草地植物對二氧化碳的吸收)
data(CO2)
head(CO2)
dim(CO2)
?CO2
str(CO2)
require(stats); require(graphics)
coplot(uptake ~ conc | Plant, data = CO2, show.given = FALSE, type = "b")
coplot(uptake ~ conc | Plant, data = CO2, show.given = FALSE, type = "b", col = CO2$Type)
coplot(uptake ~ conc | Plant, data = CO2, show.given = FALSE, type = "b", col = CO2$Treatment)
coplot(uptake ~ conc | Plant, data = CO2, show.given = FALSE, type = "b", col = CO2$Plant)

#2. co2           Mauna Loa Atmospheric CO2 Concentration
data(co2)
head(co2)
dim(co2)
class(co2)
# [1] "ts"  >>> A time series 
?co2
# Atmospheric concentrations of CO2 are expressed in parts per million (ppm) and reported in the preliminary 1997 SIO manometric mole fraction scale.
# 大氣中的二氧化碳濃度以百萬分率（ppm）表示，並在1997年初始SIO測壓摩爾分數標準中報告。
co2
#  Jan    Feb    Mar    Apr    May    Jun    Jul    Aug    Sep    Oct    Nov    Dec
# 1959 315.42 316.31 316.50 317.56 318.13 318.00 316.39 314.65 313.68 313.18 314.66 315.43
# 1960 316.27 316.81 317.42 318.87 319.87 319.43 318.01 315.74 314.00 313.68 314.84 316.03
# 1961 316.73 317.54 318.38 319.31 320.42 319.61 318.42 316.63 314.83 315.16 315.94 316.85

str(co2)
require(graphics)
plot(co2, ylab = expression("Atmospheric concentration of CO"[2]),
     las = 1)
title(main = "Mauna Loa Atmospheric CO2 Concentration")

#3. cars          Speed and Stopping Distances of Cars
data(cars)
head(cars)
dim(cars)
?cars
# The data give the speed of cars and the distances taken to stop. Note that the data were recorded in the 1920s.
# 數據給出了汽車的速度和停止的距離。 請注意，這些數據是在20世紀20年代記錄的。

# Examples
require(stats); require(graphics)
plot(cars, xlab = "Speed (mph)", ylab = "Stopping distance (ft)",
     las = 1)
lines(lowess(cars$speed, cars$dist, f = 2/3, iter = 3), col = "red")
title(main = "汽車的速度和停止的距離")

plot(cars, xlab = "汽車的速度 Speed (mph)", ylab = "停止的距離Stopping distance (ft)",
     las = 1, log = "xy")
title(main = "cars data (logarithmic scales)")
lines(lowess(cars$speed, cars$dist, f = 2/3, iter = 3), col = "red")
summary(fm1 <- lm(log(dist) ~ log(speed), data = cars))
opar <- par(mfrow = c(2, 2), oma = c(0, 0, 1.1, 0),
            mar = c(4.1, 4.1, 2.1, 1.1))
plot(fm1)
par(opar)

## An example of polynomial regression
plot(cars, xlab = "Speed (mph)", ylab = "Stopping distance (ft)",
     las = 1, xlim = c(0, 25))
d <- seq(0, 25, length.out = 200)
for(degree in 1:4) {
    fm <- lm(dist ~ poly(speed, degree), data = cars)
    assign(paste("cars", degree, sep = "."), fm)
    lines(d, predict(fm, data.frame(speed = d)), col = degree)
}
anova(cars.1, cars.2, cars.3, cars.4)

#4. airquality    New York Air Quality Measurements
data(airquality)
head(airquality)
dim(airquality)
?airquality
# 1973年5月至9月在紐約進行的每日空氣質量測量。
require(graphics)
pairs(airquality, panel = panel.smooth, main = "airquality data")

#5. volcano       Topographic Information on Auckland's Maunga Whau Volcano
#                 奧克蘭Maunga Whau火山的地形信息
data(volcano)
head(volcano)
dim(volcano)
?volcano
# Description
# Maunga Whau (Mt Eden) is one of about 50 volcanos in the Auckland volcanic field. This data set gives topographic(地形) information for Maunga Whau on a 10m by 10m grid.

require(grDevices); require(graphics)
filled.contour(volcano, color.palette = terrain.colors, asp = 1)
title(main = "奧克蘭Maunga Whau火山的地形信息")

#6. occupationalStatus     Occupational Status of Fathers and their Sons
#                         父親和兒子的職業地位
data(occupationalStatus)
head(occupationalStatus)
dim(occupationalStatus)
?occupationalStatus
# Occupational Status of Fathers and their Sons
# Description
# Cross-classification of a sample of British males according to each subject's occupational status and his father's occupational status.
# 父與子的職業地位
# 描述
# 根據每個學科的職業地位和父親的職業地位，對英國男性的樣本進行交叉分類。

require(stats); require(graphics)
plot(occupationalStatus)

##  Fit a uniform association model separating diagonal effects
##  擬合分離對角效應的統一關聯模型
Diag <- as.factor(diag(1:8))
Rscore <- scale(as.numeric(row(occupationalStatus)), scale = FALSE)
Cscore <- scale(as.numeric(col(occupationalStatus)), scale = FALSE)
modUnif <- glm(Freq ~ origin + destination + Diag + Rscore:Cscore,
               family = poisson, data = occupationalStatus)
summary(modUnif)
plot(modUnif) # 4 plots, with warning about  h_ii ~= 1

#7. faithful      Old Faithful Geyser Data
data(faithful)
head(faithful)
dim(faithful)
?faithful
# Waiting time between eruptions and the duration of the eruption for the Old Faithful geyser in Yellowstone National Park, Wyoming, USA.
# 美國懷俄明州黃石國家公園的老忠實噴泉噴發和噴發持續時間之間的等待時間。
# Examples
require(stats); require(graphics)
f.tit <-  "faithful data: Eruptions of Old Faithful"

ne60 <- round(e60 <- 60 * faithful$eruptions)
all.equal(e60, ne60)             # relative diff. ~ 1/10000
table(zapsmall(abs(e60 - ne60))) # 0, 0.02 or 0.04
faithful$better.eruptions <- ne60 / 60     # 更好的噴發
te <- table(ne60)
te[te >= 4]                      # (too) many multiples of 5 !
plot(names(te), te, type = "h", main = f.tit, xlab = "Eruption time (sec)")

plot(faithful[, -3], main = f.tit,
     xlab = "Eruption time (min)",
     ylab = "Waiting time to next eruption (min)")
lines(lowess(faithful$eruptions, faithful$waiting, f = 2/3, iter = 3),
      col = "red")

#8. women         Average Heights and Weights for American Women
data(women)
head(women)
dim(women)
?women
# 這個數據集為30-39歲的美國婦女提供了平均身高和體重。
# Examples
require(graphics)
plot(women, xlab = "Height (in)", ylab = "Weight (lb)", col = "red",
     main = "women data: American women aged 30-39")

#9. ChickWeight   Weight versus age of chicks on different diets (體重與不同年齡雞的飲食)
data(ChickWeight)
head(ChickWeight)
dim(ChickWeight)
?ChickWeight
require(graphics)
coplot(weight ~ Time | Chick, data = ChickWeight,
       type = "b", show.given = FALSE)
coplot(weight ~ Time | Chick, data = ChickWeight,col = ChickWeight$Chick,
       type = "b", show.given = FALSE)
coplot(weight ~ Time | Chick, data = ChickWeight,col = ChickWeight$Diet,
       type = "b", show.given = FALSE)

#10. iris          Edgar Anderson's Iris Data
pairs(iris)
pairs(iris, col = iris$Species)

#11. mtcars        Motor Trend Car Road Tests
?mtcars
# 這些數據摘自“1974年美國汽車趨勢”雜誌，其中包括32款汽車（1973-74款）的油耗和汽車設計和性能方面的10個方面。
require(graphics)
pairs(mtcars, main = "mtcars data")
pairs(mtcars, main = "mtcars data", col = mtcars$cyl)
pairs(mtcars, main = "mtcars data", col = mtcars$gear)
coplot(mpg ~ disp | as.factor(cyl), data = mtcars,
       panel = panel.smooth, rows = 1)


### 1-3 作業 (R 內建常用的資料集(Datasets)) ----
### 1. 請在這網頁中 http://ccckmit.wikidot.com/r:dataset  找出 5 個與老師不同的資料集，
###    利用 ? 查詢該資料集的用途與範例 Examples?
### 1.遺傳演算法https://www.r-bloggers.com/genetic-algorithms-a-simple-r-example/
### 2.資料採礦https://rdatamining.wordpress.com/2011/08/26/examples-on-clustering-with-r/
### 3.機器學習https://cran.r-project.org/web/views/MachineLearning.html
### 4.影像處理https://cran.r-project.org/web/views/MedicalImaging.html
### 5.優化方法https://stat.ethz.ch/R-manual/R-patched/library/stats/html/optimize.html
### 1-4 以鳶尾花資料集為例 The Iris Dataset ----
# 鳶尾花資料集已被用於許多研究出版物的分類。 它包含150來自三類鳶尾花各自的樣品owers[Frank and Asuncion, 2010]。這個R內建的鳶尾花(iris)資料集是非常著名的生物資訊資料集之一，取自美國加州大學歐文分校的機械學習資料庫http://archive.ics.uci.edu/ml/datasets/Iris，資料的筆數為150筆，
# 共有五個欄位：
# 1. 花萼長度(Sepal Length)：計算單位是公分。
# 2. 花萼寬度(Sepal Width)：計算單位是公分。
# 3. 花瓣長度(Petal Length) ：計算單位是公分。
# 4. 花瓣寬度(Petal Width)：計算單位是公分。
# 5. 品種類別(Species Class)：可分為Setosa，Versicolor和Virginica三個品種。

# 可先使用data 輸入iris資料,head和tail函數查看資iris料集的前6筆或後幾筆資料，
# 順便檢視資料欄位名稱，前4個欄位為數值型態第5個欄位為類別型態。
data(iris)
head(iris)
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa
tail(iris)
# Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
# 145          6.7         3.3          5.7         2.5 virginica
# 146          6.7         3.0          5.2         2.3 virginica
# 147          6.3         2.5          5.0         1.9 virginica
# 148          6.5         3.0          5.2         2.0 virginica
# 149          6.2         3.4          5.4         2.3 virginica
# 150          5.9         3.0          5.1         1.8 virginica

str(iris)
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

# summary 敘述性統機資料
summary(iris)
# Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500   

# 接著以mean函數算出Sepal.Length等各個變數的平均值：
mean(iris$Sepal.Length)
# [1] 5.843333
mean(iris$Sepal.Width)
# [1] 3.057333
mean(iris$Petal.Length)
# [1] 3.758
mean(iris$Petal.Width)
# [1] 1.199333

# 若是只想取到小數第二位，則可利用round函數：
round(mean(iris$Sepal.Length), 2)
# [1] 5.84
?round
# Rounding of Numbers 數字舍入


# 由於某些資料檔名稱或變數名稱很長，像iris$Sepal.Length這樣的寫法很麻煩，
# 這時我們可以先使用attach函數，建立與iris資料集的連結，之後就可直接使用變數名稱來操作：
attach(iris)
round(mean(Sepal.Length),2)

# 最後以summary產生基本敘述統計資料，包括數值資料的平均數、中位數、最大最小值、四分位數以及
# 類別資料的次數。
summary(iris)
# Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500 

# 其他如變異數、標準差可使用var()、sd()函數。
var(iris$Sepal.Length)
# [1] 0.6856935
sd(iris$Petal.Length)
# [1] 1.765298

pairs(iris)
# 延伸閱讀:
# http://www.cc.ntu.edu.tw/chinese/epaper/0031/20141220_3105.html

### 1-4 作業: 以bodyfat (體脂肪的預測)資料集為例 The bodyfat Dataset ----
### 1. 輸入並使用 bodyfat (體脂肪的預測)資料集?
###    [提示]data("bodyfat")
###    [提示]??bodyfat  >>  data("bodyfat", package = "TH.data") >> head(bodyfat)
###    pairs(bodyfat)
data("BodyFat")
data("bodyfat", package = "TH.data")
head(bodyfat)
pairs(bodyfat)
### 2. 了解並解釋 bodyfat 資料集中10個變數意義?
###1.身體脂肪百分比
###2.年齡（以年為單位）
###3.重量（以磅為單位）
###4.高度（英寸）
###5.脖子圍（厘米）
###6.胸圍（厘米）
###7.腹部周長（厘米）
###8.腳踝周長（厘米）
###9.二頭肌周長（厘米）
###10.手腕周長（厘米）
### 3. 使用 bodyfat 資料集重複 1-4 節所有iris 資料集所用過的指令?
head(bodyfat)
tail(bodyfat)
str(bodyfat)
summary(bodyfat)
mean(iris$Sepal.age)
var(iris$Sepal.age)
sd(iris$Petal.age)
# bodyfat (體脂肪的預測)資料集有10個變量有71個觀測值。
# Improved prediction of body fat by measuring skinfold thickness, circumferences, and bone breadths. 
# age           年齡。
# DEXfat        由DXA測量的身體脂肪，反應變量。
# waistcirc     腰圍。
# hipcirc       臀圍。
# elbowbreadth  肘部的寬度。
# kneebreadth   膝蓋的寬度。
