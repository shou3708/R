### 巨量資料分析與應用 Using - R --------
### 期中考 -- 巨量資料分析與應用 Using - R - UCI -鮑魚abalone的年齡  ----
# 東海大學資訊管理學系 姜自強博士

# 此次使用 UCI 機器學習的資料集 -----
# https://archive.ics.uci.edu/ml/datasets/Abalone 
# Predict the age of abalone from physical measurements 從物理測量中預測鮑魚的年齡

# Data Set Information:
# Predicting the age of abalone from physical measurements. The age of abalone is determined by cutting the shell through the cone, staining it, and counting the number of rings through a microscope -- a boring and time-consuming task. Other measurements, which are easier to obtain, are used to predict the age. Further information, such as weather patterns and location (hence food availability) may be required to solve the problem. 
# 數據集信息：
# 從物理測量中預測鮑魚的年齡。 鮑魚的年齡取決於從錐體切割殼體，染色，並通過顯微鏡計數環的數量 - 這是一個無聊而費時的任務。 其他測量，這是更容易獲得，被用來預測年齡。

# Attribute Information:

# Given is the attribute name, attribute type, the measurement unit and a brief description. The number of rings is the value to predict: either as a continuous value or as a classification problem. 
# 
# Name / Data Type / Measurement Unit / Description 
# ----------------------------- 
# Sex / nominal / -- / M, F, and I (infant) 
# Length / continuous / mm / Longest shell measurement 
# Diameter	/ continuous / mm / perpendicular to length 
# Height / continuous / mm / with meat in shell 
# Whole weight / continuous / grams / whole abalone 
# Shucked weight / continuous	/ grams / weight of meat 
# Viscera weight / continuous / grams / gut weight (after bleeding) 
# Shell weight / continuous / grams / after being dried 
# Rings / integer / -- / +1.5 gives the age in years 
# 
# The readme file contains attribute statistics.

# 屬性信息：
# 
# 給定的是屬性名稱，屬性類型，度量單位和簡要描述。 環的數量是要預測的值：要么作為連續值，要么作為分類問題。
# 
# 名稱/     數據類型/   度量單位/   說明
# -----------------------------
# 性別/     名義/       - /         M，F和I（嬰兒）
# 長度/     連續/       毫米/       最長殼測量
# 直徑/     連續/       毫米/       垂直於長度
# 高度/     連續/       毫米/       外殼肉
# 總重量/   連續/       克/         整個鮑魚
# 肉的重量/ 連續/        克/        重量
# 內臟重量/ 連續/        克/        腸道重量（出血後）
# 外殼重量/ 連續/        克/        乾燥後
# 戒指/     整數/       - /         +1.5為年齡
# 
# 自述文件包含屬性統計信息。

# Name		        Data Type	Meas.	Description
# ----		        ---------	-----	-----------
# Sex		        nominal			    M, F, and I (infant)
# Length		    continuous	mm	    Longest shell measurement
# Diameter	        continuous	mm	    perpendicular to length
# Height		    continuous	mm	    with meat in shell
# Whole weight	    continuous	grams	whole abalone
# Shucked weight	continuous	grams	weight of meat
# Viscera weight	continuous	grams	gut weight (after bleeding)
# Shell weight	    continuous	grams	after being dried
# Rings		        integer			    +1.5 gives the age in years

## 資料輸入-----
library(readr)
abalone<- read_csv("abalone.data", col_names =  FALSE)

### 問題 01 ~ 15 每題 5 分 合計 75%:
## 問題01: col_names =  FALSE 代表什麼意義?-----

## ANS: 說明這個csv檔是沒有表頭欄位名稱的


View(abalone)

## 備分原始資料
abaloneBackUp <- abalone

names(abalone)
# [1] "X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8" "X9"
## 問題02: 上述指令為何只顯示 X1, X2, .......?-----

## ANS: 因為csv檔沒有表頭 所以用x1~x9代替


## 問題03: 請將 abalone 資料集變數名稱，改為以下英文名稱 ?-----
# "Sex","Length","Diameter","Height","WholeWeight", "ShuckedWeight", "VisceraWeight", "ShellWeight", "Rings"
## ANS: 


names(abalone) <- c("Sex","Length","Diameter","Height","WholeWeight",
                    "ShuckedWeight", "VisceraWeight", "ShellWeight", "Rings")
    
# 資料集變數名稱修改後如下:
names(abalone)
# [1] "Sex"           "Length"        "Diameter"      "Height"        "WholeWeight"   "ShuckedWeight"
# [7] "VisceraWeight" "ShellWeight"   "Rings" 

## 產生新資料集  abaloneC 
abaloneC <- abalone

## 問題04: 請將 abaloneC 資料集變數名稱，改為以下中文名稱 ?-----
# "性別","長度","直徑","高度","總重量", "肉的重量", "內臟重量", "外殼重量", "環""
## ANS: 

names(abaloneC) <- c( "性別","長度","直徑","高度","總重量", "肉的重量", "內臟重量", "外殼重量", "環")

# 資料集變數名稱修改後如下:
names(abaloneC)
# [1] "性別"     "長度"     "直徑"     "高度"     "總重量"   "肉的重量" "內臟重量" "外殼重量" "環"  

str(abalone)
# Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	4177 obs. of  9 variables:
# $ Sex          : 性別     chr  "M" "M" "F" "M" ...
# $ Length       : 長度     num  0.455 0.35 0.53 0.44 0.33 0.425 0.53 0.545 0.475 0.55 ...
# $ Diameter     : 直徑     num  0.365 0.265 0.42 0.365 0.255 0.3 0.415 0.425 0.37 0.44 ...
# $ Height       : 高度     num  0.095 0.09 0.135 0.125 0.08 0.095 0.15 0.125 0.125 0.15 ...
# $ WholeWeight  : 總重量   num  0.514 0.226 0.677 0.516 0.205 ...
# $ ShuckedWeight: 肉的重量 num  0.2245 0.0995 0.2565 0.2155 0.0895 ...
# $ VisceraWeight: 內臟重量 num  0.101 0.0485 0.1415 0.114 0.0395 ...
# $ ShellWeight  : 外殼重量 num  0.15 0.07 0.21 0.155 0.055 0.12 0.33 0.26 0.165 0.32 ...
# $ Rings        : 環 int  15 7 9 10 7 8 20 16 9 19 ...  年齡 = 環 + 1.5

### dplyr 資料整理工具套件 dplyr ---------
# install.packages("dplyr")
library(dplyr)

## dplyr - select() 選取數值型變數出來! -------
## 問題05: dplyr - select() 選取數值型變數出來  存成 abaloneNumType 資料集?-----
## ANS: 
abaloneNumType <- select(abalone,length:ShellWeight)
abaloneNumTypeC <- select(abaloneC, 長度:環)

# abaloneNumType 資料集 如下:
names(abaloneNumType)
# [1] "Length"        "Diameter"      "Height"        "WholeWeight"   "ShuckedWeight" "VisceraWeight"
# [7] "ShellWeight" 

## 選擇隨機 N 行 Selecting Random N Rows ------------
## 問題06: dplyr - sample_n 選擇隨機 N 行?-----
## ANS: 

sample_n(abalone,3,replace = TRUE)
#  A tibble: 3 x 9
#     Sex Length Diameter Height WholeWeight ShuckedWeight VisceraWeight ShellWeight Rings
#   <chr>  <dbl>    <dbl>  <dbl>       <dbl>         <dbl>         <dbl>       <dbl> <int>
# 1     M  0.635    0.475  0.170      1.1935        0.5205        0.2695      0.3665    10
# 2     I  0.560    0.445  0.165      1.0285        0.4535        0.2530      0.2750    11
# 3     M  0.560    0.440  0.140      0.9710        0.4430        0.2045      0.2650    14

### Selecting Random Fraction(分數或比例) of Rows -----
## 問題07: dplyr - sample_frac 選擇隨機 0.3 比例  存成 abaloneTestData 資料集??-----
## ANS:
abaloneTestData <- sample_frac(abalone,0.3)

# 結果如下:
dim(abaloneTestData)
# [1] 1253    9

## 假設你需要子集數據。 過濾橫列(觀測值)資料 Filter Rows ------
## 問題08: 請解釋以下三指令代表為麼意義?-----
## ANS:
#第一行是找出鮑魚年齡為嬰兒的
#第2行是找出大於全部平均重量的鮑魚
#第3行找出環最大的鮑魚
(abaloneFilter01 = filter(abalone, Sex == "I"))
(abaloneFilter02 = filter(abalone, WholeWeight >= mean(WholeWeight) ))
(abaloneFilter03 = filter(abalone, Rings >= max(Rings) ))

## 總結選定的變量 Summarize selected variables  -----
## 問題09: 請解釋以下指令代表為麼意義?-----
## ANS:
#統整出平均重量 環的中位數 和幾筆資料
summarise(abalone, WholeWeight_mean = mean(WholeWeight), Rings_med=median(Rings), count = n())
#   WholeWeight_mean Rings_med count
#              <dbl>     <int> <int>
# 1        0.8287422         9  4177

## 創建一個新變量 Create a new variable --------------
## 問題10: 請解釋以下指令代表為麼意義?-----
## ANS:
#創一個新變量為總重量除以環數
abaloneMutate <- mutate(abalone, WholeWeightVsRings = WholeWeight / Rings)
names(abaloneMutate)
# [1] "Sex"                "Length"             "Diameter"           "Height"            
# [5] "WholeWeight"        "ShuckedWeight"      "VisceraWeight"      "ShellWeight"       
# [9] "Rings"              "WholeWeightVsRings"

## 問題11: 請解釋以下指令代表為麼意義?-----
## ANS:取WholeWeightVsRings平均數
mean(abaloneMutate$WholeWeightVsRings)
# [1] 0.08109457

## 問題12: 請解釋以下指令代表為麼意義?-----
## ANS: 把abaloneMutate依據性別分類 找個數和平均總重量
## 總結，分組和排序 Summarize, Group and Sort Together  --------------
abaloneMutate %>% group_by(Sex) %>% summarise(count = n(), WholeWeightMean = mean(WholeWeight))
#     Sex count WholeWeightMean
#   <chr> <int>           <dbl>
# 1     F  1307       1.0465321
# 2     I  1342       0.4313625
# 3     M  1528       0.9914594

## 問題13: 請解釋以下指令代表為麼意義?-----
## ANS:把abaloneMutate依據性別和環分類 找個數和平均總重量
abaloneMutate %>% group_by(Sex, Rings) %>% summarise(count = n(), WholeWeightMean = mean(WholeWeight))
# A tibble: 68 x 4
# Groups:   Sex [?]
# Sex Rings count WholeWeightMean
# <chr> <int> <int>           <dbl>
# 1     F     5     4       0.1622500
# 2     F     6    16       0.5595938
# 3     F     7    44       0.5927273
# 4     F     8   122       0.8122787
# 5     F     9   238       0.9820504
# 6     F    10   248       1.0557056
# 7     F    11   200       1.2165125
# 8     F    12   128       1.1142422
# 9     F    13    88       1.0742955
# 10     F    14    56       1.1477768
# # ... with 58 more rows

## 數值型各變數分布圖 --------
## 問題14: 請解釋以下四指令代表為麼意義?-----
## ANS:
pairs(abaloneNumType)
#做abaloneNumType的散布圖
pairs(abalone[ ,2:8])
#做abalone2至8欄位的散布圖
abalone$Sex <- as.factor(abalone$Sex)
#將性別做為辦別因子 再做散布圖
pairs(abalone[ ,2:8], col = abalone$Sex )
#做abalone2至8欄位 性別做為辦別因子的散布圖
# 一起來看看我們的資料分布囉!
# 基礎的plot函數可依參數的性質畫出不同的X-Y散佈圖、長條圖、盒狀圖、散佈圖矩陣：

#直徑(Diameter)與總重量(WholeWeight) 散佈圖
## 問題15: 請解釋以下指令代表為麼意義?-----
## ANS:
#為直徑(Diameter)與總重量(WholeWeight) 散佈圖
plot(abalone$Diameter, abalone$WholeWeight) 
#為依據性別做直徑(Diameter)與總重量(WholeWeight) 散佈圖
plot(abalone$Diameter, abalone$WholeWeight, col = abalone$Sex)

## 機器學習 請使用  ctree（）構建鮑魚(abalone)資料集的決策樹?  25%
## 
### 使用package套件 party -函數ctree建立決策樹(Decision Trees with Package party with ctree()) ------- 
# 本節介紹如何在包中使用函數ctree（）構建鮑魚(abalone)資料集的決策樹
# 其中各變數被用來預測鮑魚
# 在函數ctree（）構建決策樹，而 predict（）對新數據進行預測。
# 在建模之前，鮑魚(abalone)資料集被分成兩個子集：訓練（70％）和測試（30％）。
# 隨機種子設置為以下的固定值，以使結果可重現。

head(abalone)
pairs(abalone[ ,-1])
pairs(abalone[ ,-1], col = abalone$Sex) ## error
str(abalone)
# Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	4177 obs. of  9 variables:
# $ Sex          : chr  "M" "M" "F" "M" ...
# $ Length       : num  0.455 0.35 0.53 0.44 0.33 0.425 0.53 0.545 0.475 0.55 ...
# $ Diameter     : num  0.365 0.265 0.42 0.365 0.255 0.3 0.415 0.425 0.37 0.44 ...
# $ Height       : num  0.095 0.09 0.135 0.125 0.08 0.095 0.15 0.125 0.125 0.15 ...
# $ WholeWeight  : num  0.514 0.226 0.677 0.516 0.205 ...
# $ ShuckedWeight: num  0.2245 0.0995 0.2565 0.2155 0.0895 ...
# $ VisceraWeight: num  0.101 0.0485 0.1415 0.114 0.0395 ...
# $ ShellWeight  : num  0.15 0.07 0.21 0.155 0.055 0.12 0.33 0.26 0.165 0.32 ...
# $ Rings        : int  15 7 9 10 7 8 20 16 9 19 ...
abalone$Sex <- as.factor(abalone$Sex)
abaloneC$性別 <- as.factor(abaloneC$性別)

# 查看資料集的資料結構:
str(abalone)
# Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	4177 obs. of  9 variables:
# $ Sex          : Factor w/ 3 levels "F","I","M": 3 3 1 3 2 2 1 1 3 1 ...
# $ Length       : num  0.455 0.35 0.53 0.44 0.33 0.425 0.53 0.545 0.475 0.55 ...
# $ Diameter     : num  0.365 0.265 0.42 0.365 0.255 0.3 0.415 0.425 0.37 0.44 ...
# $ Height       : num  0.095 0.09 0.135 0.125 0.08 0.095 0.15 0.125 0.125 0.15 ...
# $ WholeWeight  : num  0.514 0.226 0.677 0.516 0.205 ...
# $ ShuckedWeight: num  0.2245 0.0995 0.2565 0.2155 0.0895 ...
# $ VisceraWeight: num  0.101 0.0485 0.1415 0.114 0.0395 ...
# $ ShellWeight  : num  0.15 0.07 0.21 0.155 0.055 0.12 0.33 0.26 0.165 0.32 ...
# $ Rings        : int  15 7 9 10 7 8 20 16 9 19 ...

summary(abalone)
# Sex          Length         Diameter          Height        WholeWeight    
# F:1307   Min.   :0.075   Min.   :0.0550   Min.   :0.0000   Min.   :0.0020  
# I:1342   1st Qu.:0.450   1st Qu.:0.3500   1st Qu.:0.1150   1st Qu.:0.4415  
# M:1528   Median :0.545   Median :0.4250   Median :0.1400   Median :0.7995  
#          Mean   :0.524   Mean   :0.4079   Mean   :0.1395   Mean   :0.8287  
#          3rd Qu.:0.615   3rd Qu.:0.4800   3rd Qu.:0.1650   3rd Qu.:1.1530  
#          Max.   :0.815   Max.   :0.6500   Max.   :1.1300   Max.   :2.8255  
# ShuckedWeight    VisceraWeight     ShellWeight         Rings       
# Min.   :0.0010   Min.   :0.0005   Min.   :0.0015   Min.   : 1.000  
# 1st Qu.:0.1860   1st Qu.:0.0935   1st Qu.:0.1300   1st Qu.: 8.000  
# Median :0.3360   Median :0.1710   Median :0.2340   Median : 9.000  
# Mean   :0.3594   Mean   :0.1806   Mean   :0.2388   Mean   : 9.934  
# 3rd Qu.:0.5020   3rd Qu.:0.2530   3rd Qu.:0.3290   3rd Qu.:11.000  
# Max.   :1.4880   Max.   :0.7600   Max.   :1.0050   Max.   :29.000 

# 隨機種子設置為以下的固定值，以使結果可重現。
set.seed(1234)

# 在建模之前，鮑魚(abalone)資料集被分成兩個子集：訓練（70％）和測試（30％）。

### 本次作業01 - 請將此 鮑魚資料集完成老師第四章所有的決策樹的方法以及隨機森林 --------
###              rpart 與 C50 和 randomForest構建預測模型,並加以說明?


### 本次作業02 - UCI - Adult Data Set --------
### 請將此 Adult 資料集完成老師第四章所有的決策樹的方法以及隨機森林 --------
###              ctree(), rpart 與 C50 和 randomForest構建預測模型,並加以說明?
### https://archive.ics.uci.edu/ml/datasets/Adult
