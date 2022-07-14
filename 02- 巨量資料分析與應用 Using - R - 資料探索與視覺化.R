### 巨量資料分析與應用 Using - R --------
# 02- 巨量資料分析與應用 Using - R - 資料探索與視覺化 
#                                   Data Exploration and Visualization
# 東海大學資訊管理學系 姜自強博士

### 2-1 讓我們看看數據 Have a Look at Data ------
# 本章使用 iris 數據來演示R的數據探索。
# 我們首先檢查數據的大小和結構。 
# 在下面的代碼中:
# 函數dim（）返回數據的維數，這表明有150個觀察值（或行或記錄）和5個變量（或列）。 
# 變量的名字由names（）。 函數str（）和 attributes（）返回數據的結構和屬性。
data(iris)
dim(iris)
# [1] 150   5
names(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species" 
# 請問上述變數中文意義各為何? 知道嗎? 請參閱第一章。


str(iris)
# 'data.frame':	150 obs. of  5 variables:
#  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

attributes(iris)
# $names
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"     
# 
# $row.names
#   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21
#  [22]  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42
#  [43]  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63
#  [64]  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84
#  [85]  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105
# [106] 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126
# [127] 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147
# [148] 148 149 150
# 
# $class
# [1] "data.frame"

class(iris)
# [1] "data.frame"

# 接下來，我們如何查閱資料集裡面的資料呢？ 看看前五行的數據？
# Next, we have a look at the first five rows of data.
iris[1:5, ]
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa

# 前六筆的資料
head(iris)

# head 前六筆的資料為預設值 n = 10 可以列出前 n 筆資料
head(iris, n = 10) 

# 也可以看最後幾筆的資料
tail(iris)

### R 使用 中刮號代表索引 [  ]
# iris[n, m]  n 代表橫列， m 代表直行(變數)
iris[1,1]
iris[1,4]
iris[1,5]

iris[2,3]
iris[4,2]

# 若是n 或 m 不寫留空白 則代表所有橫列或直行
iris[1, ]  # 第一筆(橫列)所有直行
iris[ ,5]  # 第五直行(變數) 的所有筆數(橫列)
iris[ , ]  # 這又代表什麼意義？
iris

nrow(iris)
# [1] 150

ncol(iris)
# [1] 5

length(iris)
# [1] 5

dim(iris)
# [1] 150   5

## 從 iris 資料集取樣 10 筆
## draw a sample of 10 rows
index <- sample(1:nrow(iris), 10)
index
#  [1]  96 101  22 149  78  64  56 124  92 139

# 取出的 10 筆資料
# 看看前面的編號是否上面index 的數列相同

iris[index, ]
#     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
# 96           5.7         3.0          4.2         1.2 versicolor
# 101          6.3         3.3          6.0         2.5  virginica
# 22           5.1         3.7          1.5         0.4     setosa
# 149          6.2         3.4          5.4         2.3  virginica
# 78           6.7         3.0          5.0         1.7 versicolor
# 64           6.1         2.9          4.7         1.4 versicolor
# 56           5.7         2.8          4.5         1.3 versicolor
# 124          6.3         2.7          4.9         1.8  virginica
# 92           6.1         3.0          4.6         1.4 versicolor
# 139          6.0         3.0          4.8         1.8  virginica

# show 出欄位(變數)名稱
names(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species" 

# show 出橫列(觀測值)名稱
rownames(iris)
# [1] "1"   "2"   "3"   "4"   "5"   "6"   "7"   "8"   "9"   "10"  "11"  "12"  "13"  "14" 
# [15] "15"  "16"  "17"  "18"  "19"  "20"  "21"  "22"  "23"  "24"  "25"  "26"  "27"  "28" 
# [29] "29"  "30"  "31"  "32"  "33"  "34"  "35"  "36"  "37"  "38"  "39"  "40"  "41"  "42" 
# [43] "43"  "44"  "45"  "46"  "47"  "48"  "49"  "50"  "51"  "52"  "53"  "54"  "55"  "56" 
# [57] "57"  "58"  "59"  "60"  "61"  "62"  "63"  "64"  "65"  "66"  "67"  "68"  "69"  "70" 
# [71] "71"  "72"  "73"  "74"  "75"  "76"  "77"  "78"  "79"  "80"  "81"  "82"  "83"  "84" 
# [85] "85"  "86"  "87"  "88"  "89"  "90"  "91"  "92"  "93"  "94"  "95"  "96"  "97"  "98" 
# [99] "99"  "100" "101" "102" "103" "104" "105" "106" "107" "108" "109" "110" "111" "112"
# [113] "113" "114" "115" "116" "117" "118" "119" "120" "121" "122" "123" "124" "125" "126"
# [127] "127" "128" "129" "130" "131" "132" "133" "134" "135" "136" "137" "138" "139" "140"
# [141] "141" "142" "143" "144" "145" "146" "147" "148" "149" "150"

# 可以用欄位(變數)名稱來取資料，所以下二個指令是相同的
iris[1, "Species"]
# [1] setosa
iris[1, 5        ]
# [1] setosa

# 1:5 第一到第五筆 "Species" 
iris[1:5, "Species"]
# [1] setosa setosa setosa setosa setosa

iris[1:10, "Sepal.Length"]
#  [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9

iris[1:10, 1]
#  [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9

iris$Sepal.Length[1:10]
#  [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9

### 2-1 作業 -----
# 1. 請利用 Cars93 資料集練習上述的指令?
library(MASS) 
# 為何需要執行這一行指令 library(MASS)?
#A:為了使用mass套件裡的library函式
data(Cars93)
dim(Cars93) 
#A:[1] 93 27
?Cars93
# 2. 請問Cars93[83, 5]的值是多少?
Cars93[83, 5]
#A:[1] 8.6
# 3. 請解釋指令 names(Cars93) 顯示出各變數的中文意義?  Hint: 貼到google去翻譯。
names(Cars93)
# [1] "Manufacturer"  製造商     "Model"   型號           "Type"      種類         "Min.Price"    最低價格     
# [5] "Price"     定價         "Max.Price"  最高價格         "MPG.city" 市區油耗          "MPG.highway"  高速公路油耗     
# [9] "AirBags"   安全氣囊         "DriveTrain"  傳動系統       "Cylinders" 汽缸   "EngineSize"  引擎尺寸      
# [13] "Horsepower"  馬力       "RPM" 轉速               "Rev.per.mile"每分鐘轉速       "Man.trans.avail"   手動翻譯
# [17] "Fuel.tank.capacity"油箱容量 "Passengers"   乘載人數      "Length"  車體長度           "Wheelbase"      軸距  
# [21] "Width"  車寬            "Turn.circle" 旋轉半徑       "Rear.seat.room"  後座數   "Luggage.room"   後車廂   
# [25] "Weight"    重量         "Origin"      原型       "Make"製造
#
# 如: 
# "Manufacturer" “製造商”


### 2-2  探索單一個體變量 Explore Individual Variables ------
summary(iris)
# Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500   
summary(Cars93)
# 均值，中值和範圍也可以分別用均值（），中值（）和範圍（）函數來獲得。 函數quantile（）支持四分位數和百分位數如下：
# The mean, median and range can also be obtained respectively with functions with mean(), median() and range(). Quartiles and percentiles are supported by function quantile() as below:

mean(iris$Sepal.Length)
# [1] 5.843333

range(iris$Sepal.Length)
# [1] 4.3 7.9

min(iris$Sepal.Length)

max(iris$Sepal.Length)

sd(iris$Sepal.Length)
# [1] 0.8280661
?sd   # 標準偏差 Standard Deviation 
#       https://zh.wikipedia.org/wiki/%E6%A8%99%E6%BA%96%E5%B7%AE
# 在機率統計中最常使用作為測量一組數值的離散程度之用。
# 簡單來說，標準差是一組數值自平均值分散開來的程度的一種測量觀念。一個較大的標準差，代表大部分的數值和其平均值之間差異較大；一個較小的標準差，代表這些數值較接近平均值。

# 例如，兩組數的集合{0, 5, 9, 14}和{5, 6, 8, 9}其平均值都是7，但第二個集合具有較小的標準差。

sd1 <- c(0, 5, 9, 14)
sd2 <- c(5, 6, 8, 9)

# 平均值都是7
mean(sd1)  #[1] 7
mean(sd2)  #[1] 7

sd(sd1)  # [1] 5.944185
sd(sd2)  # [1] 1.825742  # 第二個集合具有較小的標準差。一個較小的標準差，代表這些數值較接近平均值。


# we check the variance of Sepal.Length with var()
var(iris$Sepal.Length)
# [1] 0.6856935

?var   # 變異量數  variance 變異數即在量測所有資料到平均數的平均距離。
# https://zh.wikipedia.org/wiki/%E6%96%B9%E5%B7%AE
# 變異量數描述的是它的離散程度，也就是該變量離其期望值的距離。
# 變異數即在量測所有資料到平均數的平均距離。一個很自然
# 會被想到用來量測資料分散程度之指標值為平均絕對離差。
# 但絕對值在代數運算上較麻煩，因此將絕對值以平方來替代
# 變異數會因資料中少數幾筆特別大或特別小的值，使變異數變得特別大。

# 小成第一次的段考成績為國文96分、數學90分、英文85分
# 、地理78分、 歷史92分、理化67分，請問小成成績的樣本變異數為多少?
score <- c(96, 90, 85, 78, 92, 67)
mean(score) #[1] 84.66667
var(score)  #[1] 113.4667

score2 <- rnorm(10, mean = 84.66667, sd = 1)
score2
mean(score2) #[1] 85.48354
var(score2)  #[1] 0.5529471  # 離散程度

quantile(iris$Sepal.Length)
#  0%  25%  50%  75% 100% 
# 4.3  5.1  5.8  6.4  7.9 

quantile(iris$Sepal.Length, c(0.2, 0.5, 0.85))
# 20% 50% 85% 
# 5.0 5.8 6.7 

# 也使用函數hist（）直方圖和density（）密度圖檢查其分佈情況並使用直方圖和密度進行檢查。
# also check its distribution with histogram and density using functions hist() and density().
hist(iris$Sepal.Length)
hist(iris$Sepal.Length, col = 1:10)
hist(iris$Sepal.Length, col = 2:10)
hist(iris$Sepal.Length, col = "red")
?hist

plot(density(iris$Sepal.Length))
plot(density(iris$Sepal.Length), col = "blue")
?plot

table(iris$Species)
# setosa versicolor  virginica 
#     50         50         50 

# table 比較適合類別型變數
table(iris$Sepal.Length)
# 4.3 4.4 4.5 4.6 4.7 4.8 4.9   5 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9   6 6.1 6.2 6.3 6.4 6.5 
#   1   3   1   4   2   5   6  10   9   4   1   6   7   6   8   7   3   6   6   4   9   7   5 
# 6.6 6.7 6.8 6.9   7 7.1 7.2 7.3 7.4 7.6 7.7 7.9 
#   2   8   3   4   1   1   3   1   1   1   4   1 

pie(table(iris$Species))
pie(table(iris$Species), col = 2:4)

barplot(table(iris$Species))
barplot(table(iris$Species), col = 2:4)
barplot(table(iris$Species), col = rainbow(10))

barplot(table(iris$Sepal.Length))
barplot(table(iris$Sepal.Length), col = 2:10)
barplot(table(iris$Sepal.Length), col = rainbow(20))

### 2-2 作業 ----- 
# 1. 請利用 Cars93 資料集練習上述的指令?
var(Cars93$MPG.city)
#[1] 31.58228
table(Cars93$Type)
#Compact Large Midsize  Small  Sporty   Van 
#16      11      22      21      14       9 
# 2. 請問iris 前面四個變數中sd 與 var 最大與最小的分別為那些變數? 
# ANS: sd 最大Petal.Length sd最小Sepal.Width var最大Petal.Length var最小Sepal.Length
sd(iris$Sepal.Length)0.8280661
sd(iris$Sepal.Width)0.4358663
sd(iris$Petal.Length)1.765298
sd(iris$Petal.Width)0.7622377
var(iris$Sepal.Length)0.6856935
var(iris$Sepal.width)
var(iris$Petal.Length)3.116278
var(iris$Petal.width)
## 2.3 探索多個變量 Explore Multiple Variables ------
# 在檢查了各個變量的分佈後，我們調查了兩個變量之間的關係。

# After checking the distributions of individual variables, we then investigate the relationships be- tween two variables. 
# Below we calculate covariance and correlation between variables with cov() and cor().

# 下面我們用cov（）和cor（）來計算變量之間的共變異數(協方差)和相關性。
# 共變異數 covariance
# https://zh.wikipedia.org/zh-tw/%E5%8D%8F%E6%96%B9%E5%B7%AE
# 共變異數（Covariance）在機率論和統計學中用於衡量兩個變量的總體誤差。
# 這與只表示一個變量誤差的變異數不同。 
# 如果兩個變量的變化趨勢一致，也就是說如果其中一個大於自身的期望值，另外一個也大於自身的期望值，那麼兩個變量之間的共變異數就是正值。 
# 如果兩個變量的變化趨勢相反，即其中一個大於自身的期望值，另外一個卻小於自身的期望值，那麼兩個變量之間的共變異數就是負值。


cov(iris$Sepal.Length, iris$Petal.Length)
# [1] 1.274315

cov(iris[ ,1:4])
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    0.6856935  -0.0424340    1.2743154   0.5162707
# Sepal.Width    -0.0424340   0.1899794   -0.3296564  -0.1216394
# Petal.Length    1.2743154  -0.3296564    3.1162779   1.2956094
# Petal.Width     0.5162707  -0.1216394    1.2956094   0.5810063

cov(iris[ , -5])
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    0.6856935  -0.0424340    1.2743154   0.5162707
# Sepal.Width    -0.0424340   0.1899794   -0.3296564  -0.1216394
# Petal.Length    1.2743154  -0.3296564    3.1162779   1.2956094
# Petal.Width     0.5162707  -0.1216394    1.2956094   0.5810063

cov(iris)
# 錯誤: is.numeric(x) || is.logical(x) is not TRUE

# 相關係數 correlation r
# https://zh.wikipedia.org/wiki/%E7%9B%B8%E5%85%B3
# 顯示兩個隨機變量之間線性關係的強度和方向。
# 當r>0時，表示兩變數正相關，r<0時，兩變數為負相關。
# 當|r|=1時，表示兩變數為完全線性相關，即為函數關係。
# 當r=0時，表示兩變數間無線性相關關係。
# 當0<|r|<1時，表示兩變數存在一定程度的線性相關。且|r|越接近1，兩變數間線性關係越密切；|r|越接近於0，表示兩變數的線性相關越弱。
# 一般可按三級劃分：|r|<0.4為低度線性相關；0.4≤|r|<0.7為顯著性相關；0.7≤|r|<1為高度線性相關。
cor(iris$Sepal.Length, iris$Petal.Length)
# [1] 0.8717538

cor(iris[ , -5])
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000  -0.1175698    0.8717538   0.8179411
# Sepal.Width    -0.1175698   1.0000000   -0.4284401  -0.3661259
# Petal.Length    0.8717538  -0.4284401    1.0000000   0.9628654
# Petal.Width     0.8179411  -0.3661259    0.9628654   1.0000000

## 作業: http://wiki.mbalib.com/zh-tw/%E7%9B%B8%E5%85%B3%E7%B3%BB%E6%95%B0
# 例:某財務軟體公司在全國有許多代理商，為研究它的財務軟體產品的廣告投入與銷售額的關係，統計人員隨機選擇10家代理商進行觀察，搜集到年廣告投入費和月平均銷售額的數據，並編製成相關表，見下表:

# 年廣告費投入	月均銷售額   (單位：萬元)
#    12.5          21.2
#    15.3          23.9
#    23.2          32.9
#    26.4          34.1
#    33.5          42.5
#    34.4          43.2
#    39.4          49.0
#    45.2          52.8
#    55.4          59.4
#    60.9          63.5	

#  相關係數為0.9942，說明廣告投入費與月平均銷售額之間有高度的線性正相關關係

# y = x^2 + 2*x + 7  >>> y ~ x

aggregate(Sepal.Length ~ Species, summary, data=iris)
#      Species Sepal.Length.Min. Sepal.Length.1st Qu. Sepal.Length.Median Sepal.Length.Mean
# 1     setosa             4.300                4.800               5.000             5.006
# 2 versicolor             4.900                5.600               5.900             5.936
# 3  virginica             4.900                6.225               6.500             6.588
#   Sepal.Length.3rd Qu. Sepal.Length.Max.
# 1                5.200             5.800
# 2                6.300             7.000
# 3                6.900             7.900

### 2.3 補充 - aggregate 匯總統計 ------
?aggregate
# Compute Summary Statistics of Data Subsets
# 計算數據子集的匯總統計

# 指令格式
## Default S3 method:
aggregate(x, ...)

## S3 method for class 'data.frame' # y = x^2 + 2*x + 7  >>> y ~ x
aggregate(x, by, FUN, ..., simplify = TRUE, drop = TRUE)

## S3 method for class 'formula'
aggregate(formula, data, FUN, ...,
          subset, na.action = na.omit)

## S3 method for class 'ts'
aggregate(x, nfrequency = 1, FUN = sum, ndeltat = 1,
          ts.eps = getOption("ts.eps"), ...)

# Arguments 參數

# x	    an R object.
# by	a list of grouping elements, each as long as the variables in the data frame x. 
#       The elements are coerced to factors before use.
#       分組元素列表，每個分組元素只要資料集 x 中的變量。
#       元素在使用前被強制成因子變數。

# 範例 Examples

aggregate(Sepal.Length ~ Species, summary, data=iris)
aggregate(Sepal.Length ~ Species, mean, data=iris)

## S3 method for class 'data.frame'
# aggregate(x, by, FUN, ..., simplify = TRUE, drop = TRUE)

aggregate(iris$Sepal.Length , iris$Species, mean)
# Error in aggregate.data.frame(as.data.frame(x), ...) : 
#     'by' must be a list

aggregate(iris$Sepal.Length , list(iris$Species), mean)
#      Group.1     x
# 1     setosa 5.006
# 2 versicolor 5.936
# 3  virginica 6.588

aggregate(iris$Sepal.Length , list(Species = iris$Species), mean)
#      Species     x
# 1     setosa 5.006
# 2 versicolor 5.936
# 3  virginica 6.588

aggregate(iris, list(Species = iris$Species), mean)
#      Species Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1     setosa        5.006       3.428        1.462       0.246      NA
# 2 versicolor        5.936       2.770        4.260       1.326      NA
# 3  virginica        6.588       2.974        5.552       2.026      NA

# 上述Species 為NA, So 還記得如何去掉Species ?
aggregate(iris[ , -5], list(Species = iris$Species), mean)
#      Species Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1     setosa        5.006       3.428        1.462       0.246
# 2 versicolor        5.936       2.770        4.260       1.326
# 3  virginica        6.588       2.974        5.552       2.026


## Compute the averages for the variables in 'state.x77', grouped
## according to the region (Northeast, South, North Central, West) that
## each state belongs to.
## 計算'state.x77'中變量的平均值，分組根據該美國地區（東北，南，北中，西）的情況。
?state.x77
dim(state.x77)
# [1] 50  8

head(state.x77)
#            人口       收入   文盲%      壽命    謀殺(每10萬人)    高中 %  零度    面積
#                                                                           天數
#            Population Income Illiteracy Life Exp Murder           HS Grad Frost   Area
# Alabama          3615   3624        2.1    69.05   15.1              41.3    20  50708
# Alaska            365   6315        1.5    69.31   11.3              66.7   152 566432
# Arizona          2212   4530        1.8    70.55    7.8              58.1    15 113417
# Arkansas         2110   3378        1.9    70.66   10.1              39.9    65  51945
# California      21198   5114        1.1    71.71   10.3              62.6    20 156361
# Colorado         2541   4884        0.7    72.06    6.8              63.9   166 103766

head(state.region)
state.region

levels(state.region)

state.x77

aggregate(state.x77, list(Region = state.region), mean)
#          Region Population   Income Illiteracy Life Exp    Murder  HS Grad    Frost      Area
# 1     Northeast   5495.111 4570.222   1.000000 71.26444  4.722222 53.96667 132.7778  18141.00
# 2         South   4208.125 4011.938   1.737500 69.70625 10.581250 44.34375  64.6250  54605.12
# 3 North Central   4803.000 4611.083   0.700000 71.76667  5.275000 54.51667 138.8333  62652.00
# 4          West   2915.308 4702.615   1.023077 71.23462  7.215385 62.00000 102.1538 134463.00

## Compute the averages according to region and the occurrence of more than 130 days of frost.根據地區計算平均值並發生超過130天的霜凍。
aggregate(state.x77,
          list(Region = state.region,
               Cold = state.x77[  ,"Frost"] > 130),
          mean)
#          Region  Cold Population   Income Illiteracy Life Exp    Murder  HS Grad    Frost      Area
# 1     Northeast FALSE  8802.8000 4780.400  1.1800000 71.12800  5.580000 52.06000 110.6000  21838.60
# 2         South FALSE  4208.1250 4011.938  1.7375000 69.70625 10.581250 44.34375  64.6250  54605.12
# 3 North Central FALSE  7233.8333 4633.333  0.7833333 70.95667  8.283333 53.36667 120.0000  56736.50
# 4          West FALSE  4582.5714 4550.143  1.2571429 71.70000  6.828571 60.11429  51.0000  91863.71
# 5     Northeast  TRUE  1360.5000 4307.500  0.7750000 71.43500  3.650000 56.35000 160.5000  13519.00
# 6 North Central  TRUE  2372.1667 4588.833  0.6166667 72.57667  2.266667 55.66667 157.6667  68567.50
# 7          West  TRUE   970.1667 4880.500  0.7500000 70.69167  7.666667 64.20000 161.8333 184162.17
## (Note that no state in 'South' is THAT cold.)

## 作業: 自行練習:
## Formulas, one ~ one, one ~ many, many ~ one, and many ~ many:
?chickwts  # Chicken Weights by Feed Type 飼料類型的雞重量
dim(chickwts)
head(chickwts)
#   weight      feed
# 1    179 horsebean
# 2    160 horsebean
# 3    136 horsebean
# 4    227 horsebean
# 5    217 horsebean
# 6    168 horsebean
summary(chickwts)

aggregate(weight ~ feed, data = chickwts, mean)
#        feed   weight
# 1    casein 323.5833
# 2 horsebean 160.2000
# 3   linseed 218.7500
# 4  meatmeal 276.9091
# 5   soybean 246.4286
# 6 sunflower 328.9167

?warpbreaks  #The Number of Breaks in Yarn during Weaving 織造過程中紗線的斷裂次數
dim(warpbreaks)  #[1] 54  3
summary(warpbreaks)
#     breaks      wool   tension
# Min.   :10.00   A:27   L:18   
# 1st Qu.:18.25   B:27   M:18   
# Median :26.00          H:18   
# Mean   :28.15                 
# 3rd Qu.:34.00                 
# Max.   :70.00 

aggregate(breaks ~ wool + tension, data = warpbreaks, mean)
#   wool tension   breaks
# 1    A       L 44.55556
# 2    B       L 28.22222
# 3    A       M 24.00000
# 4    B       M 28.77778
# 5    A       H 24.55556
# 6    B       H 18.77778

?airquality  #New York Air Quality Measurements 紐約空氣質量測量
head(airquality)
#   Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5
# 6    28      NA 14.9   66     5   6

aggregate(cbind(Ozone, Temp) ~ Month, data = airquality, mean)
#   Month    Ozone     Temp
# 1     5 23.61538 66.73077
# 2     6 29.44444 78.22222
# 3     7 59.11538 83.88462
# 4     8 59.96154 83.96154
# 5     9 31.44828 76.89655

?esoph  # Smoking, Alcohol and (O)esophageal Cancer 吸煙，酒精和（O）食道癌
        # Data from a case-control study of (o)esophageal cancer in Ille-et-Vilaine, 
        # France.來自法國Ille-et-Vilaine的（o）食道癌病例對照研究的數據。
dim(esoph)  # [1] 88  5
head(esoph)
#   agegp     alcgp    tobgp ncases ncontrols
# 1 25-34 0-39g/day 0-9g/day      0        40
# 2 25-34 0-39g/day    10-19      0        10
# 3 25-34 0-39g/day    20-29      0         6
# 4 25-34 0-39g/day      30+      0         5
# 5 25-34     40-79 0-9g/day      0        27
# 6 25-34     40-79    10-19      0         7

str(esoph)
# 'data.frame':	88 obs. of  5 variables:
# $ agegp    : Ord.factor w/ 6 levels "25-34"<"35-44"<..: 1 1 1 1 1 1 1 1 1 1 ...
# $ alcgp    : Ord.factor w/ 4 levels "0-39g/day"<"40-79"<..: 1 1 1 1 2 2 2 2 3 3 ...
# $ tobgp    : Ord.factor w/ 4 levels "0-9g/day"<"10-19"<..: 1 2 3 4 1 2 3 4 1 2 ...
# $ ncases   : num  0 0 0 0 0 0 0 0 0 0 ...
# $ ncontrols: num  40 10 6 5 27 7 4 7 2 1 ...

summary(esoph)
#   agegp   alcgp(gm/day) tobgp(gm/day)        ncases         ncontrols    
# 25-34:15   0-39g/day:23   0-9g/day:24   Min.   : 0.000   Min.   : 1.00  
# 35-44:15   40-79    :23   10-19   :24   1st Qu.: 0.000   1st Qu.: 3.00  
# 45-54:16   80-119   :21   20-29   :20   Median : 1.000   Median : 6.00  
# 55-64:16   120+     :21   30+     :20   Mean   : 2.273   Mean   :11.08  
# 65-74:15                                3rd Qu.: 4.000   3rd Qu.:14.00  
# 75+  :11                                Max.   :17.000   Max.   :60.00
aggregate(cbind(ncases, ncontrols) ~ alcgp + tobgp, data = esoph, sum)
#        alcgp    tobgp ncases ncontrols
# 1  0-39g/day 0-9g/day      9       261
# 2      40-79 0-9g/day     34       179
# 3     80-119 0-9g/day     19        61
# 4       120+ 0-9g/day     16        24
# 5  0-39g/day    10-19     10        84

## Dot notation:
aggregate( . ~ Species, data = iris, mean)

head(ToothGrowth)
dim(ToothGrowth)
?ToothGrowth 
# The Effect of Vitamin C on Tooth Growth in Guinea Pigs
# 維生素C對豚鼠牙齒生長的影響

# [,1]	 len	 numeric	 Tooth length(齒長)
# [,2]	 supp	 factor	     Supplement type (VC or OJ).補充因子補充類型
# [,3]	 dose	 numeric	 Dose in milligrams/day 劑量數值以毫克/天計的劑量

aggregate(len ~ supp, data = ToothGrowth, mean)
aggregate(len ~ dose, data = ToothGrowth, mean)
aggregate(len ~ ., data = ToothGrowth, mean)

## Often followed by xtabs():
ag <- aggregate(len ~ ., data = ToothGrowth, mean)
ag
xtabs(len ~ ., data = ag)


## Compute the average annual approval ratings for American presidents.
## 計算美國總統的平均年度支持率。
dim(presidents)
class(presidents)  # [1] "ts"
presidents
#      Qtr1 Qtr2 Qtr3 Qtr4
# 1945   NA   87   82   75
# 1946   63   50   43   32
# 1947   35   60   54   55
# 1948   36   39   NA   NA

aggregate(presidents, nfrequency = 1, FUN = mean)

## Give the summer less weight.
aggregate(presidents, nfrequency = 1,
          FUN = weighted.mean, w = c(1, 1, 0.5, 1))

## example with character variables and NAs 字符變量和NAs(值漏值)的例子 (自行閱讀)
testDF <- data.frame(v1 = c(1,  3, 5, 7, 8, 3, 5,NA, 4, 5, 7, 9),
                     v2 = c(11,33,55,77,88,33,55,NA,44,55,77,99) )
testDF
by1 <- c("red", "blue",  1,  2, NA, "big",   1,  2, "red",  1, NA, 12)
by2 <- c("wet",  "dry", 99, 95, NA, "damp", 95, 99, "red", 99, NA, NA)
aggregate(x = testDF, by = list(by1, by2), FUN = "mean")

# and if you want to treat NAs as a group 如果你想把NAs當作一個團體 (自行閱讀)
fby1 <- factor(by1, exclude = "")
fby2 <- factor(by2, exclude = "")
aggregate(x = testDF, by = list(fby1, fby2), FUN = "mean")

### End of aggregate 


boxplot(Sepal.Length ~ Species, data=iris, xlab="Species", ylab="Sepal.Length")
boxplot(Petal.Width ~ Species, data=iris, xlab="Species", ylab="Petal.Width")
boxplot(Sepal.Length ~ Species, data=iris, xlab="Species", ylab="Sepal.Length", col = 2:4)

# Scatter Plot
plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species, pch=as.numeric(iris$Species))

plot(iris$Sepal.Length, iris$Sepal.Width)

attach(iris)
plot(Sepal.Length, Sepal.Width, col=Species, pch=as.numeric(Species))

detach(iris)
plot(Sepal.Length, Sepal.Width, col=Species, pch=as.numeric(Species))
# Error in plot(Sepal.Length, Sepal.Width, col = Species, pch = as.numeric(Species)) : 
#   找不到物件 'Sepal.Length'

with(iris, plot(Sepal.Length, Sepal.Width, col=Species, pch=as.numeric(Species)))

# 當有很多點時，其中一些可能會重疊。 我們可以使用jitter（）來添加一個小的
# 繪圖前的數據噪音量。
# When there are many points, some of them may overlap. We can use jitter() to add a small
# amount of noise to the data before plotting.

plot(iris$Sepal.Length, iris$Sepal.Width)
plot(jitter(iris$Sepal.Length), jitter(iris$Sepal.Width))

# 平滑散點圖可以用函數smoothScatter（）來繪製，散點圖通過核密度估計得到平滑的顏色密度表示。
# A smooth scatter plot can be plotted with function smoothScatter(), which a smoothed color density representation of the scatterplot, obtained through a kernel density estimate.

smoothScatter(iris$Sepal.Length, iris$Sepal.Width)

# 可以用函數對（）生成散點圖的矩陣，其中每個子圖都是
# 一對變量的散點圖。
# A matrix of scatter plots can be produced with function pairs(), where each sub figure is the
# scatter plot of a pair of variables.
pairs(iris)
pairs(iris, col = 2:3)
pairs(iris, col = iris$Species)
pairs(iris, col = iris$Species, pch=as.numeric(iris$Species))

### 2-3 作業 -----
# 1. 請利用 Cars93 資料集練習上述的指令，請自行選取 Cars93 因子變數(如: Manufacturer) 做 aggregate 分類使用?
library(MASS)  # 為何需要執行這一行指令 library(MASS)?
data(Cars93)
dim(Cars93)
?Cars93
aggregate(Manufacturer, data = Cars93, mean)
str(Cars93)

### 2.4 更多探索 More Explorations ----
library(scatterplot3d)
scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)
scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width, highlight.3d = TRUE)
?scatterplot3d

library(rgl)
plot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)

# 熱圖顯示數據矩陣的二維顯示，可以使用R中的heatmap（）生成。使用下面的代碼，我們計算虹膜數據中不同花朵之間的相似度與dist（）然後用熱圖進行繪製。
# A heat map presents a 2D display of a data matrix, which can be generated with heatmap() in R. With the code below, we calculate the similarity between different flowers in the iris data
# with dist() and then plot it with a heat map.
distMatrix <- as.matrix(dist(iris[,1:4]))
heatmap(distMatrix)

# 一個水平圖可以用包格子中的函數levelplot（）生成[Sarkar，2008]。 函數grey.colors（）創建一個伽瑪校正的灰色顏色矢量。
# A level plot can be produced with function levelplot() in package lattice [Sarkar, 2008]. Function grey.colors() creates a vector of gamma-corrected gray colors.
library(lattice)
levelplot(Petal.Width ~ Sepal.Length*Sepal.Width, iris, cuts=9,
          col.regions = grey.colors(10)[10:1])

levelplot(Petal.Width ~ Sepal.Length*Sepal.Width, iris, cuts=9,
          col.regions = rainbow(10)[10:1])

filled.contour(volcano, color=terrain.colors, asp=1,
               plot.axes=contour(volcano, add=T))

persp(volcano, theta=25, phi=30, expand=0.5, col="lightblue")

# 平行坐標可以很好地顯示多維數據。 一個平行的坐標圖可以用parcoord（）在MASS包中生成，
# 並且用parallelplot（）在包格中生成。
# Parallel coordinates provide nice visualization of multiple dimensional data. A parallel coor- dinates plot can be produced with parcoord() in package MASS, and with parallelplot() in package lattice.
library(MASS)
parcoord(iris[1:4], col=iris$Species)


library(lattice)
parallelplot(~iris[1:4] | Species, data=iris)

library(ggplot2)
qplot(Sepal.Length, Sepal.Width, data=iris, facets=Species ~.)
qplot(Sepal.Length, Sepal.Width, data=iris, facets=Species ~., col= iris$Species)

### 2.5 將圖表保存到文件中 Save Charts into Files -----
# 如果在數據探索中有很多圖形，最好的做法是將它們保存到文件中。 R為此提供了各種功能。 
# 下面是將函數pdf（）和postscript（）分別保存為PDF和PS文件的示例。 
# BMP，JPEG，PNG和TIFF格式的圖片文件可以分別用bmp（），jpeg（），png（）和tiff（）生成。 
# 請注意，繪圖後需要使用graphics.off（）或dev.off（）關閉文件（或圖形設備）。

# If there are many graphs produced in data exploration, a good practice is to save them into files. R provides a variety of functions for that purpose. Below are examples of saving charts into PDF and PS files respectively with functions pdf() and postscript(). Picture files of BMP, JPEG, PNG and TIFF formats can be generated respectively with bmp(), jpeg(), png() and tiff(). Note that the files (or graphics devices) need be closed with graphics.off() or dev.off() after plotting.

# save as a PDF file
pdf("myPlot.pdf")
x <- 1:50
plot(x, log(x))
graphics.off()

# save as a jpeg file
jpeg("myPlot.jpg")
x <- 1:50
plot(x, log(x))
graphics.off()

# Save as a postscript file
postscript("myPlot2.ps")
x <- -20:20
plot(x, x^2)
graphics.off()
