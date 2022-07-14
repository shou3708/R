## 08- 巨量資料分析與應用 Using - R - 關聯規則(購物籃分析) Association Rules ----

install.packages("arules")
install.packages("arulesViz")
install.packages("RColorBrewer")


#套件與資料的載入
library(arules)        # association rules (an S4 object orientation package)
library(arulesViz)     # data visualization of association rules
library(RColorBrewer)  # color palettes for plots
library(cluster)       # cluster analysis for market segmentation

??arules
# https://cran.r-project.org/web/packages/arules/arules.pdf
# Mining Association Rules and Frequent Itemsets
# Description Provides the infrastructure for representing,
# manipulating and analyzing transaction data and patterns 
# (frequent itemsets and association rules). Also provides interfaces to
# C implementations of the association mining algorithms Apriori and Eclat
# by C. Borgelt.

# Case1: Groceries Data

### 1. 關聯規則分析與檔案格式 -----
# 關聯規則分析的規則是指 X →Y ，X和Y為物件的集合
# X稱為前項（antecedents，R軟體稱為lhs,即lefte hand sides），
# Y稱為後項（consequents，R軟體稱為rhs,即right hand sides）。
# 我們舉以下的Transaction項目列表為例：

txn <- list(c("Bread", "Milk"), 
            c("Bread", "Diaper", "Beer", "Eggs"), 
            c("Milk", "Diaper", "Beer", "Coke"), 
            c("Bread", "Milk", "Diaper", "Beer"), 
            c("Bread", "Milk", "Diaper", "Coke"))
txn
# [[1]]
# [1] "Bread" "Milk" 
# [[2]]
# [1] "Bread"  "Diaper" "Beer"   "Eggs"  
# [[3]]
# [1] "Milk"   "Diaper" "Beer"   "Coke"  
# [[4]]
# [1] "Bread"  "Milk"   "Diaper" "Beer"  
# [[5]]
# [1] "Bread"  "Milk"   "Diaper" "Coke"  

# 以下是幾個規則範例：
# {Milk, Diaper} >> {Beer}         (s=0.4, c=0.67) s=2/5, c=2/3
# {Milk, Beer}   >> {Diaper}       (s=0.4, c=1.0)  s=?  , c=?   << 自行練習
# {Diaper, Beer} >> {Milk}         (s=0.4, c=0.67) s=?  , c=?   << 自行練習
# {Beer}         >> {Milk, Diaper} (s=0.4, c=0.67) s=?  , c=?   << 自行練習

# [1] {Bread,Milk}            
# [2] {Beer,Bread,Diaper,Eggs}
# [3] {Beer,Coke,Diaper,Milk} 
# [4] {Beer,Bread,Diaper,Milk}
# [5] {Bread,Coke,Diaper,Milk}
# 其中s指支援度support，亦即X和Y同時出現的次數 ÷ 所有交易數；
# c指信賴度confidence，亦即X和Y同時出現的次數 ÷ X出現的次數。
# 至於提昇lift則是指support/((support(X)*(support(Y)) 0.4 / (0.4*)

txn <- as(txn, "transactions")
inspect(txn)
#      items                   
# [1] {Bread,Milk}            
# [2] {Beer,Bread,Diaper,Eggs}
# [3] {Beer,Coke,Diaper,Milk} 
# [4] {Beer,Bread,Diaper,Milk}
# [5] {Bread,Coke,Diaper,Milk}
txnMat <- as(txn, "itemMatrix")
txnMat
# itemMatrix in sparse format with
# 5 rows (elements/transactions) and
# 6 columns (items)
inspect(txnMat)
#     items                   
# [1] {Bread,Milk}            
# [2] {Beer,Bread,Diaper,Eggs}
# [3] {Beer,Coke,Diaper,Milk} 
# [4] {Beer,Bread,Diaper,Milk}
# [5] {Bread,Coke,Diaper,Milk}
as(txnMat, "matrix")
#       Beer Bread  Coke Diaper  Eggs  Milk
# [1,] FALSE  TRUE FALSE  FALSE FALSE  TRUE
# [2,]  TRUE  TRUE FALSE   TRUE  TRUE FALSE
# [3,]  TRUE FALSE  TRUE   TRUE FALSE  TRUE
# [4,]  TRUE  TRUE FALSE   TRUE FALSE  TRUE
# [5,] FALSE  TRUE  TRUE   TRUE FALSE  TRUE
txnMat2 <- as(txn, "matrix")
txnMat2

itemFrequency(txn)
# Beer  Bread   Coke Diaper   Eggs   Milk 
# 0.6    0.8    0.4    0.8    0.2    0.8 

itemFrequencyPlot(txn)
colSums(as(txnMat, "matrix")) # same as above
# Beer  Bread   Coke Diaper   Eggs   Milk 
#    3      4      2      4      1      4 

itemFrequency(txn, type="absolute")
# Beer  Bread   Coke Diaper   Eggs   Milk 
#    3      4      2      4      1      4 
colSums(as(txnMat, "matrix"))/nrow(txnMat) # same as above
# Beer  Bread   Coke Diaper   Eggs   Milk 
# 0.6    0.8    0.4    0.8    0.2    0.8 

?apriori
# Mining Associations with Apriori
# Usage
# apriori(data, parameter = NULL, appearance = NULL, control = NULL)
# parameter	
# object of class APparameter or named list. The default behavior is to mine rules with minimum support of 0.1, minimum confidence of 0.8, maximum of 10 items (maxlen), and a maximal time for subset checking of 5 seconds (maxtime).

rule01 <- apriori(txn, parameter=list(supp=0.2, conf=0.8, maxlen=5))
rule01a <- apriori(txn, parameter=list(supp=0.4, conf=0.8, maxlen=5))  # 用較高的標準 supp=0.8 
#default是0.1, 0.8, 10
# Apriori
# 
# Parameter specification:
# confidence minval smax arem  aval originalSupport maxtime support minlen maxlen target   ext
#        0.8    0.1    1 none FALSE            TRUE       5     0.2      1      5  rules FALSE
# 
# Algorithmic control:
#  filter tree heap memopt load sort verbose
#     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
# 
# Absolute minimum support count: 1 
# 
# set item appearances ...[0 item(s)] done [0.00s].
# set transactions ...[6 item(s), 5 transaction(s)] done [0.00s].
# sorting and recoding items ... [6 item(s)] done [0.00s].
# creating transaction tree ... done [0.00s].
# checking subsets of size 1 2 3 4 done [0.00s].
# writing ... [31 rule(s)] done [0.00s].
# creating S4 object  ... done [0.00s].

inspect(rule01)
#      lhs                    rhs      support confidence lift     count
# [1]  {}                  => {Milk}   0.8     0.8        1.000000 4    
# [2]  {}                  => {Bread}  0.8     0.8        1.000000 4    
# [3]  {}                  => {Diaper} 0.8     0.8        1.000000 4    
# [4]  {Eggs}              => {Beer}   0.2     1.0        1.666667 1    
# [5]  {Eggs}              => {Bread}  0.2     1.0        1.250000 1    
# [6]  {Eggs}              => {Diaper} 0.2     1.0        1.250000 1    
# [7]  {Coke}              => {Milk}   0.4     1.0        1.250000 2    
# [8]  {Coke}              => {Diaper} 0.4     1.0        1.250000 2    
# [9]  {Beer}              => {Diaper} 0.6     1.0        1.250000 3    
# [10] {Beer,Eggs}         => {Bread}  0.2     1.0        1.250000 1    
# [11] {Bread,Eggs}        => {Beer}   0.2     1.0        1.666667 1    
# [12] {Beer,Eggs}         => {Diaper} 0.2     1.0        1.250000 1    
# [13] {Diaper,Eggs}       => {Beer}   0.2     1.0        1.666667 1    
# [14] {Bread,Eggs}        => {Diaper} 0.2     1.0        1.250000 1    
# [15] {Diaper,Eggs}       => {Bread}  0.2     1.0        1.250000 1    
# [16] {Beer,Coke}         => {Milk}   0.2     1.0        1.250000 1    
# [17] {Beer,Coke}         => {Diaper} 0.2     1.0        1.250000 1    
# [18] {Bread,Coke}        => {Milk}   0.2     1.0        1.250000 1    
# [19] {Coke,Milk}         => {Diaper} 0.4     1.0        1.250000 2    
# [20] {Coke,Diaper}       => {Milk}   0.4     1.0        1.250000 2    
# [21] {Bread,Coke}        => {Diaper} 0.2     1.0        1.250000 1    
# [22] {Beer,Milk}         => {Diaper} 0.4     1.0        1.250000 2    
# [23] {Beer,Bread}        => {Diaper} 0.4     1.0        1.250000 2    
# [24] {Beer,Bread,Eggs}   => {Diaper} 0.2     1.0        1.250000 1    
# [25] {Beer,Diaper,Eggs}  => {Bread}  0.2     1.0        1.250000 1    
# [26] {Bread,Diaper,Eggs} => {Beer}   0.2     1.0        1.666667 1    
# [27] {Beer,Coke,Milk}    => {Diaper} 0.2     1.0        1.250000 1    
# [28] {Beer,Coke,Diaper}  => {Milk}   0.2     1.0        1.250000 1    
# [29] {Bread,Coke,Milk}   => {Diaper} 0.2     1.0        1.250000 1    
# [30] {Bread,Coke,Diaper} => {Milk}   0.2     1.0        1.250000 1    
# [31] {Beer,Bread,Milk}   => {Diaper} 0.2     1.0        1.250000 1 
inspect(rule01a)

summary(rule01)
# set of 31 rules
# 
# rule length distribution (lhs + rhs):sizes
# 1  2  3  4 
# 3  6 14  8  (3 + 6 +14 + 8 = 31)
# 
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   2.000   3.000   2.871   3.500   4.000 
# 
# summary of quality measures:
#     support         confidence          lift           count      
# Min.   :0.2000   Min.   :0.8000   Min.   :1.000   Min.   :1.000  
# 1st Qu.:0.2000   1st Qu.:1.0000   1st Qu.:1.250   1st Qu.:1.000  
# Median :0.2000   Median :1.0000   Median :1.250   Median :1.000  
# Mean   :0.3097   Mean   :0.9806   Mean   :1.280   Mean   :1.548  
# 3rd Qu.:0.4000   3rd Qu.:1.0000   3rd Qu.:1.250   3rd Qu.:2.000  
# Max.   :0.8000   Max.   :1.0000   Max.   :1.667   Max.   :4.000  
# 
# mining info:
# data ntransactions support confidence
#  txn             5     0.2        0.8
summary(rule01a)

inspect(head(sort(rule01, by="support"),10))
#      lhs              rhs      support confidence lift count
# [1]  {}            => {Milk}   0.8     0.8        1.00 4    
# [2]  {}            => {Bread}  0.8     0.8        1.00 4    
# [3]  {}            => {Diaper} 0.8     0.8        1.00 4    
# [4]  {Beer}        => {Diaper} 0.6     1.0        1.25 3    
# [5]  {Coke}        => {Milk}   0.4     1.0        1.25 2    
# [6]  {Coke}        => {Diaper} 0.4     1.0        1.25 2    
# [7]  {Coke,Milk}   => {Diaper} 0.4     1.0        1.25 2    
# [8]  {Coke,Diaper} => {Milk}   0.4     1.0        1.25 2    
# [9]  {Beer,Milk}   => {Diaper} 0.4     1.0        1.25 2    
# [10] {Beer,Bread}  => {Diaper} 0.4     1.0        1.25 2 
inspect(head(sort(rule01a, by="support"),10))

inspect(head(sort(rule01,by="confidence"),10))
#      lhs              rhs      support confidence lift     count
# [1]  {Eggs}        => {Beer}   0.2     1          1.666667 1    
# [2]  {Eggs}        => {Bread}  0.2     1          1.250000 1    
# [3]  {Eggs}        => {Diaper} 0.2     1          1.250000 1    
# [4]  {Coke}        => {Milk}   0.4     1          1.250000 2    
# [5]  {Coke}        => {Diaper} 0.4     1          1.250000 2    
# [6]  {Beer}        => {Diaper} 0.6     1          1.250000 3    
# [7]  {Beer,Eggs}   => {Bread}  0.2     1          1.250000 1    
# [8]  {Bread,Eggs}  => {Beer}   0.2     1          1.666667 1    
# [9]  {Beer,Eggs}   => {Diaper} 0.2     1          1.250000 1    
# [10] {Diaper,Eggs} => {Beer}   0.2     1          1.666667 1 
inspect(head(sort(rule01a,by="confidence"),10))

### 2. 超市購物關聯分析範例 -----
# 本範例的超市購物資料，檔案的欄位說明如下：購買產品分為
# Ready made、Frozen Food、Alcohol、Fresh Vegetables、Milk、Bakery goods、Fresh meat、Toiletries、Snacks、Tinned Goods
# 成品，冷凍食品，酒精，新鮮蔬菜，牛奶，麵包店用品，鮮肉，洗漱用品，零食，罐頭食品
#等10個類別，有買則資料值設為1，沒買則資料值設為0，另外還包括一些個人基本資料，諸如性別、年齡、婚姻狀況等。

# 建立關聯模型需注意的事項包括：建模時可以設定支援度、信賴度等建模細節，當門檻值過高而無法生成模型時，使用者須適度調整門檻值；執行後產生的關聯規則，可以查看詳細的規則內容。排序的規則有支援度(Support)、信賴度(Confidence)、提昇(Lift)等方式，使用者可依需求選擇；另外也可以產生自訂目標的關聯規則。

shopping <- read.csv("shopping.txt", header=T)
str(shopping)
# 'data.frame':	786 obs. of  15 variables:
# $ Ready.made      : int  1 1 1 1 1 1 1 1 1 1 ...
# $ Frozen.foods    : int  0 0 0 0 0 0 0 0 0 0 ...
# $ Alcohol         : int  0 0 0 0 0 0 0 0 0 0 ...
# $ Fresh.Vegetables: int  0 0 0 0 0 0 0 0 0 0 ...
# $ Milk            : int  0 0 0 1 0 0 0 0 1 0 ...
# $ Bakery.goods    : int  0 0 0 1 0 1 1 0 0 0 ...
# $ Fresh.meat      : int  0 0 0 0 0 0 0 0 0 0 ...
# $ Toiletries      : int  0 1 1 0 0 0 0 0 0 0 ...
# $ Snacks          : int  1 0 1 0 0 1 0 0 1 0 ...
# $ Tinned.Goods    : int  0 0 0 0 0 1 0 0 1 0 ...
# $ GENDER          : Factor w/ 2 levels "Female","Male": 1 1 2 1 1 2 1 1 1 1 ...
# $ Age             : Factor w/ 5 levels "18 to 30","31 to 40",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ MARITAL         : Factor w/ 5 levels "Divorced","Married",..: 5 3 4 5 3 4 4 5 4 4 ...
# $ CHILDREN        : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
# $ WORKING         : Factor w/ 2 levels "No","Yes": 2 2 2 2 2 1 1 1 1 1 ...

head(shopping)
#   Ready.made Frozen.foods Alcohol Fresh.Vegetables Milk Bakery.goods Fresh.meat
# 1          1            0       0                0    0            0          0
# 2          1            0       0                0    0            0          0
# 3          1            0       0                0    0            0          0
# 4          1            0       0                0    1            1          0
# 5          1            0       0                0    0            0          0
# 6          1            0       0                0    0            1          0
#   Toiletries Snacks Tinned.Goods GENDER      Age   MARITAL CHILDREN WORKING
# 1          0      1            0 Female 18 to 30   Widowed       No     Yes
# 2          1      0            0 Female 18 to 30 Separated       No     Yes
# 3          1      1            0   Male 18 to 30    Single       No     Yes
# 4          0      0            0 Female 18 to 30   Widowed       No     Yes
# 5          0      0            0 Female 18 to 30 Separated       No     Yes
# 6          0      1            1   Male 18 to 30    Single       No      No
dim(shopping)
# [1] 786  15

names(shopping)
# [1] "Ready.made"       "Frozen.foods"     "Alcohol"          "Fresh.Vegetables" "Milk"            
# [6] "Bakery.goods"     "Fresh.meat"       "Toiletries"       "Snacks"           "Tinned.Goods"    
# [11] "GENDER"           "Age"              "MARITAL"          "CHILDREN"         "WORKING"

library(dplyr)
shopping02 <- shopping %>% select(Ready.made:Tinned.Goods)

sum(is.na(shopping02))
# [1] 
shopping03 <- na.exclude(shopping02)
identical(shopping03, shopping02)
# [1] TRUE

## 二種格式可以輸入  apriori -----
## 格式一 as.matrix
shopping04 = as.matrix(shopping03) 

## 格式二 transactions
shopping05T = as(shopping03, "transactions") 
# Error in asMethod(object) : 
#     column(s) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 not logical or a factor. Discretize the columns first.

shopping05 <- shopping03
shopping05$Ready.made <- as.factor(shopping05$Ready.made)
shopping05[2] <- as.factor(shopping05[2])
for (i in 1:10){
    shopping05[i] <- as.factor(shopping05[i])
}
str(shopping05)
shopping05T = as(shopping05, "transactions") 
inspect(shopping05T)
#       items transactionID
# [1]   {}    1            
# [2]   {}    2    

shopping055 <- shopping03
for (i in 1:10){
    shopping055[i] <- ifelse(shopping055[i] == 1, TRUE, FALSE)  
}
head(shopping055)
shopping05T = as(shopping055, "transactions") 
inspect(shopping05T)

### 3. apriori 關聯分析----
rule04 = apriori(shopping04,parameter=list(supp=0.09, conf=0.8,maxlen=5))
# Apriori
# 
# Parameter specification:
#  confidence minval smax arem  aval originalSupport maxtime support minlen maxlen target   ext
#         0.8    0.1    1 none FALSE            TRUE       5    0.09      1      5  rules FALSE
# 
# Algorithmic control:
#  filter tree heap memopt load sort verbose
#     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
# 
# Absolute minimum support count: 70 
# 
# set item appearances ...[0 item(s)] done [0.00s].
# set transactions ...[10 item(s), 786 transaction(s)] done [0.00s].
# sorting and recoding items ... [8 item(s)] done [0.00s].
# creating transaction tree ... done [0.00s].
# checking subsets of size 1 2 3 4 5 done [0.00s].
# writing ... [4 rule(s)] done [0.00s].
# creating S4 object  ... done [0.00s].
rule05 = apriori(shopping05T,parameter=list(supp=0.09, conf=0.8,maxlen=5))

inspect(rule05)
#     lhs                                    rhs            support    confidence lift     count
# [1] {Frozen.foods,Milk}                 => {Bakery.goods} 0.09033079 0.8352941  1.948193 71   
# [2] {Alcohol,Bakery.goods,Tinned.Goods} => {Ready.made}   0.10050891 0.8144330  1.654120 79   
# [3] {Ready.made,Alcohol,Tinned.Goods}   => {Bakery.goods} 0.10050891 0.8315789  1.939528 79   
# [4] {Frozen.foods,Snacks,Tinned.Goods}  => {Bakery.goods} 0.09414758 0.8222222  1.917705 74 

inspect(head(sort(rule04,by="support"),10))
#     lhs                                    rhs            support    confidence lift     count
# [1] {Alcohol,Bakery.goods,Tinned.Goods} => {Ready.made}   0.10050891 0.8144330  1.654120 79   
# [2] {Ready.made,Alcohol,Tinned.Goods}   => {Bakery.goods} 0.10050891 0.8315789  1.939528 79   
# [3] {Frozen.foods,Snacks,Tinned.Goods}  => {Bakery.goods} 0.09414758 0.8222222  1.917705 74   
# [4] {Frozen.foods,Milk}                 => {Bakery.goods} 0.09033079 0.8352941  1.948193 71 
inspect(head(sort(rule05,by="support"),10))


inspect(head(sort(rule04,by="confidence"),10))
#     lhs                                    rhs            support    confidence lift     count
# [1] {Frozen.foods,Milk}                 => {Bakery.goods} 0.09033079 0.8352941  1.948193 71   
# [2] {Ready.made,Alcohol,Tinned.Goods}   => {Bakery.goods} 0.10050891 0.8315789  1.939528 79   
# [3] {Frozen.foods,Snacks,Tinned.Goods}  => {Bakery.goods} 0.09414758 0.8222222  1.917705 74   
# [4] {Alcohol,Bakery.goods,Tinned.Goods} => {Ready.made}   0.10050891 0.8144330  1.654120 79  
inspect(head(sort(rule05,by="confidence"),10))

# 以第一個關聯規則{Frozen Food, Milk => Bakery goods}為例解釋如下：全部總共786筆資料，
# 買Milk和Frozen Food的人是85筆，買Bakery goods的人是337筆，
# 買Milk和Frozen Food而且買Bakery goods的人是71筆，買Milk和Frozen Food但不買Bakery goods的人是14筆。
# 所以後項是指Bakery goods；前項是指Milk和Frozen Food；信賴度為83.529 = 71/85，是指購買前項產品的客戶中也買後項產品的比例；
# 支援度(即指購買前項產品的客戶占全部客戶的比例 x 信賴度)是9.033 = 10.814% x 83.529% 或解釋成= 71 / 786，指購買前項產品也買後項產品的客戶占全部客戶的比例；提昇是1.948，即等於(71/85)/ (337/786)或解釋成 = 83.529% / 42.875%，指購買前後項產品占購買前項產品的比例除以購買後項產品占全部客戶的比例。

itemFrequency(shopping05T)
#   Ready.made     Frozen.foods          Alcohol Fresh.Vegetables             Milk 
#   0.49236641       0.40203562       0.39440204       0.08269720       0.18829517 
# Bakery.goods       Fresh.meat       Toiletries           Snacks     Tinned.Goods 
#   0.42875318       0.02926209       0.09923664       0.47455471       0.45547074
itemFrequencyPlot(shopping05T, col = 2:12)

itemFrequency(shopping05T[ , c(2,5)])

itemFrequency(shopping05T[ , 6])
# Bakery.goods 
#    0.4287532 
0.4287532 * 786  # = [1] 337
itemFrequencyPlot(shopping05T[ , 1:3])


# 此外，也可設定特定目標的關聯規則，如以下設定後項為Alcohol。或者降低信賴度從80%至75%，則可產生17個較多的關聯規則，提供我們參考顧客購買物品的關聯性。
rule05a = apriori(shopping05T,parameter=list(supp=0.09, conf=0.75,maxlen=5))
inspect(rule05a)
#      lhs                                       rhs            support    confidence lift     count
# [1]  {Alcohol,Milk}                         => {Bakery.goods} 0.09033079 0.7888889  1.839960 71   
# [2]  {Frozen.foods,Milk}                    => {Bakery.goods} 0.09033079 0.8352941  1.948193 71   
# [3]  {Milk,Tinned.Goods}                    => {Bakery.goods} 0.10050891 0.7900000  1.842552 79   
# [4]  {Milk,Snacks}                          => {Bakery.goods} 0.09669211 0.7755102  1.808757 76   
# [5]  {Milk,Bakery.goods}                    => {Ready.made}   0.10559796 0.7545455  1.532488 83   
# [6]  {Ready.made,Milk}                      => {Bakery.goods} 0.10559796 0.7904762  1.843663 83   
# [7]  {Frozen.foods,Alcohol,Tinned.Goods}    => {Bakery.goods} 0.09414758 0.7789474  1.816773 74   
# [8]  {Alcohol,Bakery.goods,Tinned.Goods}    => {Frozen.foods} 0.09414758 0.7628866  1.897560 74   
# [9]  {Ready.made,Frozen.foods,Bakery.goods} => {Alcohol}      0.10432570 0.7522936  1.907428 82   
# [10] {Ready.made,Frozen.foods,Snacks}       => {Alcohol}      0.09669211 0.7600000  1.926968 76   
# [11] {Alcohol,Bakery.goods,Tinned.Goods}    => {Ready.made}   0.10050891 0.8144330  1.654120 79   
# [12] {Ready.made,Alcohol,Tinned.Goods}      => {Bakery.goods} 0.10050891 0.8315789  1.939528 79   
# [13] {Alcohol,Snacks,Tinned.Goods}          => {Ready.made}   0.09160305 0.7912088  1.606951 72   
# [14] {Ready.made,Alcohol,Tinned.Goods}      => {Snacks}       0.09160305 0.7578947  1.597065 72   
# [15] {Ready.made,Alcohol,Snacks}            => {Bakery.goods} 0.10178117 0.7547170  1.760260 80   
# [16] {Frozen.foods,Snacks,Tinned.Goods}     => {Bakery.goods} 0.09414758 0.8222222  1.917705 74   
# [17] {Ready.made,Frozen.foods,Tinned.Goods} => {Bakery.goods} 0.09923664 0.7878788  1.837605 78 

###  4. 關聯規則視覺化-----
# 最後我們要做的事是將先前4, 17個關聯規則視覺化，包括繪製Heat map(熱圖)、Balloon plot (氣球圖)、Graph (網路圖) 、平行座標圖(Parallel coordinates plot)，程式碼如下：
library(arulesViz)
#Heat map(熱圖)
plot(rule05)
plot(rule05a)
#Balloon plot (氣球圖)
plot(rule05,method="grouped") 
plot(rule05a,method="grouped") 
# Graph (網路圖)
plot(rule05,method="graph",control =list(type="items"))
plot(rule05a,method="graph",control =list(type="items"))
# Parallel coordinates plot (平行座標圖)
plot(rule05, method = "paracoord", control = list(reorder = TRUE))
plot(rule05a, method = "paracoord", control = list(reorder = TRUE))

## 補充 -- 自行閱讀
### 5. 序列分析 ------
# 序列(Sequence)分析類似於關聯規則，但還得考量時間的先後順序，也就是一種著重時間順序的資料關聯分析。
# 序列分析的重點在於資料中必須存在先後順序的關係(例如時間)。
# 序列分析可以提供我們針對客戶客製化行銷的預測，掌握良機，
# 當某位客戶買了某項產品後，就已經預告將來的某個時間點會再度買我們的附加產品或服務。
# 在這裡我們將舉以一個電信公司的維修案例來作說明。
# 所使用的檔案名稱為TelRepair.txt，包括750個維修案例，共有5915紀錄，3個欄位。
# 第1個欄位是ID，對應一份診斷修理報告，第2個欄位紀錄著每個ID修理診斷的順序，第3個欄位紀錄每次修理診斷的動作代碼。
# 每份診斷修理報告開始以代碼90表示(但只有727個案例是，有可能是紀錄動作不切實)，成功完成修理以代碼210表示，若問題無法成功解決，則以代碼299表示。檔案內容及格式如下(不需欄名)：

install.packages("arulesSequences")
library("arulesSequences")

?read_baskets   # read_baskets {arulesSequences}
# Read Transaction Data
# Description
# Read transaction data in basket format (with additional temporal or other information) and create an object of class transactions.

# TelRepair.txt 
# ID	INDEX1	STAGE
# 1  	1   	90    << 修理報告開始以代碼90表示
# 1	    2   	170
# 1	    3   	110
# 1	    4   	150
# 1	    5   	120
# 1	    6   	125
# 1	    7   	180
# 1	    8   	195
# 1	    9   	210  <<  成功完成修理以代碼210

repair <- read_baskets("TelRepair.txt", sep="\t", info=c("sequenceID","eventID"))

inspect(repair)
#        items sequenceID eventID
# [1]    {90}    1         1     
# [2]    {170}   1         2     
# [3]    {110}   1         3     
# [4]    {150}   1         4     
# [5]    {120}   1         5     
# [6]    {125}   1         6     

arulesSeq = cspade(repair,parameter = list(supp=0.2),control = list(verbose=T),tmpdir=tempdir())
arulesSeq = cspade(repair,parameter = list(supp=0.2),control = list(verbose=T))


summary(arulesSeq)
as(arulesSeq,"data.frame")
