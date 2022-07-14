### 巨量資料分析與應用 Using - R --------
### 05- 巨量資料分析與應用 Using - R - 分類(Cluster analysis) ----
# 東海大學資訊管理學系 姜自強博士

# 本章介紹 R 中各種分類技術的例子，包括k均值分類，
# k-medoids分類，層次聚類和基於密度的分類。 
# 前兩個部分演示如何使用k-means和k-medoids算法對 IRIS 數據進行分類。 
# 第三部分顯示了對相同數據進行分層聚類的示例。 
# 最後一節描述 基於密度的聚類和DBSCAN算法的思想，並展示瞭如何進行分類
# DBSCAN，然後用聚類模型標記新的數據。 

# Cluster analysis https://en.wikipedia.org/wiki/Cluster_analysis


### 5-1 k均值分類 (The k-Means Clustering) ------- 
# 本節展示鳶尾花(iris)資料集的k均值分類。
# 首先，我們從數據中刪除物種進行分類。 之後我們將函數kmeans（）應用於
# iris2，並將聚類結果存儲在kmeans.result中。 

# 本節介紹如何在包中使用函數kmeans()構建鳶尾花(iris)資料集的k均值分類
# 其中Sepal.Length，Sepal.Width，Petal.Length和Petal.Width被用來預測鳶尾花品種分類
# 在函數kmeans()構建分類，而 predict（）對新數據進行預測。

data(iris)
head(iris)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa

# 查看資料集的資料結構:
str(iris)
# 'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

iris2 <- iris

# 首先，我們從數據中刪除物種進行分類。 why?
iris2$Species <- NULL
head(iris2)  
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1          5.1         3.5          1.4         0.2
# 2          4.9         3.0          1.4         0.2
# 3          4.7         3.2          1.3         0.2
# 4          4.6         3.1          1.5         0.2
# 5          5.0         3.6          1.4         0.2
# 6          5.4         3.9          1.7         0.4

?kmeans
# K-Means Clustering
# kmeans(x, centers, iter.max = 10, nstart = 1,
#        algorithm = c("Hartigan-Wong", "Lloyd", "Forgy",
#                      "MacQueen"), trace=FALSE)

### k-means動畫示例 ----
library(animation)
# 先選取 plots 頁籤
kmeans.ani()

#預測分群結果與叢集中心
(kmeans.result <- kmeans(iris2, 3))
# K-means clustering with 3 clusters of sizes 38, 62, 50
# 
# Cluster means:
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1     6.850000    3.073684     5.742105    2.071053
# 2     5.901613    2.748387     4.393548    1.433871
# 3     5.006000    3.428000     1.462000    0.246000
# 
# Clustering vector:
#  [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
# [43] 3 3 3 3 3 3 3 3 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2
# [85] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 1 1 1 1 2 1 1 1 1 1 1 2 2 1 1 1 1 2 1 2 1 2 1 1
# [127] 2 2 1 1 1 1 1 2 1 1 1 1 2 1 1 1 2 1 1 1 2 1 1 2
# 
# Within cluster sum of squares by cluster:
# [1] 23.87947 39.82097 15.15100
# (between_SS / total_SS =  88.4 %)
# 
# Available components:
#     
# [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
# [6] "betweenss"    "size"         "iter"         "ifault"    

names(kmeans.result)
# [1] "cluster"      "centers"   "totss"       "withinss"    "tot.withinss" "betweenss"   "size"        
# [8] "iter"         "ifault"   
kmeans.result$cluster
# [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2
# [52] 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2
# [103] 1 1 1 1 2 1 1 1 1 1 1 2 2 1 1 1 1 2 1 2 1 2 1 1 2 2 1 1 1 1 1 2 1 1 1 1 2 1 1 1 2 1 1 1 2 1 1 2

# 然後將聚類結果與品種（Species）進行比較以檢查是否相似對像被分組在一起。
table(iris$Species, kmeans.result$cluster)
#             1  2  3
# setosa     50  0  0  <<< setosa“可以很容易地從其他簇中分離出來
# versicolor  0 48  2
# virginica   0 14 36

(14+2)/150   # [1] 0.1066667

# 上表說明解釋:
# 以上結果表明cluster \ setosa“可以很容易地從其他簇中分離出來，而且
# 那些集群\ versicolor“和\ virginica”在很小程度上是相互重疊的。

# 圖 iris的散佈圖矩陣
plot(iris2,col=kmeans.result$cluster)

# 接下來，繪製聚類及其中心圖 -------------- 
# 請注意，有四個數據中的尺寸，只有前兩個尺寸用於繪製下面的圖。
# 靠近綠色中心的一些黑點（星號）實際上更接近黑色中心
# 四維空間。 我們還需要知道，k均值聚類的結果可能會有所不同
# 從運行到運行，由於隨機選擇初始聚類中心。

plot(iris2[c("Sepal.Length", "Sepal.Width")], col = kmeans.result$cluster)

plot(iris2[c("Sepal.Length", "Sepal.Width")], col = kmeans.result$cluster,
     pch = kmeans.result$cluster)

# plot cluster centers 繪製聚類及其中心點
kmeans.result$centers
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1     6.850000    3.073684     5.742105    2.071053
# 2     5.901613    2.748387     4.393548    1.433871
# 3     5.006000    3.428000     1.462000    0.246000
points(kmeans.result$centers[ ,c("Sepal.Length", "Sepal.Width")], col = 1:3,
             pch = 8, cex=4)
points(kmeans.result$centers[ ,c("Sepal.Length", "Sepal.Width")], col = 1:3,
             pch = 19, cex=2)
# R Plot PCH Symbols Chart
# http://www.endmemo.com/program/R/pchsymbols.php

### 接下來我們想利用集群找出離群值並將離群值和集群中心標示出來：-----
#find 5 largest distances between objects and cluster centers
names(kmeans.result)
# [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"   
# [7] "size"         "iter"         "ifault"   
kmeans.result

kmeans.result$centers
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1     5.006000    3.428000     1.462000    0.246000
# 2     5.901613    2.748387     4.393548    1.433871
# 3     6.850000    3.073684     5.742105    2.071053

centers = kmeans.result$centers[kmeans.result$cluster, ]
centers

head(centers)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1        5.006       3.428        1.462       0.246
# 1        5.006       3.428        1.462       0.246
# 1        5.006       3.428        1.462       0.246
# 1        5.006       3.428        1.462       0.246
# 1        5.006       3.428        1.462       0.246
# 1        5.006       3.428        1.462       0.246

distances = sqrt(rowSums((iris2-centers)^2)) #計算距離
distances
# [1] 0.14135063 0.44763825 0.41710910 0.52533799 0.18862662 0.67703767 0.41518670 0.06618157 0.80745278
# [10] 0.37627118 0.48247280 0.25373214 0.50077939 0.91322505 1.01409073 1.20481534 0.65420180 0.14415270
# [19] 0.82436642 0.38933276 0.46344363 0.32860310 0.64029681 0.38259639 0.48701129 0.45208406 0.20875823

outliers = order(distances,decreasing=T)[1:5] #找出離群值前五個

outliers
# [1]  99  58  94  61 119

iris2[outliers, ]
#     Sepal.Length Sepal.Width Petal.Length Petal.Width
# 99           5.1         2.5          3.0         1.1
# 58           4.9         2.4          3.3         1.0
# 94           5.0         2.3          3.3         1.0
# 61           5.0         2.0          3.5         1.0
# 119          7.7         2.6          6.9         2.3

plot(iris2[c("Sepal.Length", "Sepal.Width")], col=kmeans.result$cluster)
points(kmeans.result$centers[,c("Sepal.Length", "Sepal.Width")], col=1:3, pch=8, cex=2)
points(iris2[outliers,c("Sepal.Length", "Sepal.Width")], col=4, pch='+', cex=2)


# 5-2 基於分類的離群值檢測 Outlier Detection by Clustering -------------
# 檢測異常值的另一種方法是聚類。 通過將數據分組到集群，這些數據不是
# 分配給任何群集被視為異常值。 例如，使用基於密度的聚類如
# DBSCAN [Ester et al。，1996]，如果物體連接到一個物體，則物體被分組到一個物體中
# 另一個人口稠密的地區。 因此，未分配給任何群集的對像是孤立的
# 從其他對象，被視為異常。 DBSCAN的一個例子基於密度的聚類。
# 我們還可以用k-means算法檢測異常值。 用k-means，數據被分割
# 通過將它們分配到最近的聚類中心而將它們分成k組。 之後，我們可以計算出來
# 每個對象與其集群中心之間的距離（或不相似度），並挑選最大的對象
# 距離作為異常值。 用虹膜數據中的k-means進行異常值檢測的一個例子

# remove species from the data to cluster
iris3 <- iris[ ,1:4]
kmeans.result2 <- kmeans(iris3, centers=3)
# cluster centers
kmeans.result2$centers
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1     6.850000    3.073684     5.742105    2.071053
# 2     5.006000    3.428000     1.462000    0.246000
# 3     5.901613    2.748387     4.393548    1.433871

# cluster IDs
kmeans.result2$cluster
# [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
# [51] 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
# [101] 1 2 1 1 1 1 2 1 1 1 1 1 1 2 2 1 1 1 1 2 1 2 1 2 1 1 2 2 1 1 1 1 1 2 1 1 1 1 2 1 1 1 2 1 1 1 2 1 1 2

# calculate distances between objects and cluster centers
(centers <- kmeans.result2$centers[kmeans.result2$cluster, ])
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 3     5.006000    3.428000     1.462000    0.246000
# 3     5.006000    3.428000     1.462000    0.246000
# 3     5.006000    3.428000     1.462000    0.246000
# 3     5.006000    3.428000     1.462000    0.246000

distances <- sqrt(rowSums((iris3 - centers)^2))
head(distances)
# [1] 0.1413506 0.4476382 0.4171091 0.5253380 0.1886266 0.6770377

# pick top 5 largest distances
outliersTopFive <- order(distances, decreasing=T)[1:5]
outliersTopFive
# [1]  99  58  94  61 119

# who are outliers
print(outliersTopFive)

print(iris3[outliersTopFive, ])
#     Sepal.Length Sepal.Width Petal.Length Petal.Width
# 99           5.1         2.5          3.0         1.1
# 58           4.9         2.4          3.3         1.0
# 94           5.0         2.3          3.3         1.0
# 61           5.0         2.0          3.5         1.0
# 119          7.7         2.6          6.9         2.3

# plot clusters
plot(iris3[ ,c("Sepal.Length", "Sepal.Width")], pch="o",
        col=kmeans.result2$cluster, cex=1)
# plot cluster centers
points(kmeans.result2$centers[,c("Sepal.Length", "Sepal.Width")], col=1:3,
              pch=8, cex=3)
# plot outliers
# Cluster centers are labeled with asterisks and outliers with \+".
points(iris3[outliersTopFive, c("Sepal.Length", "Sepal.Width")], pch="+", col=4, cex=3)

#### 一起來看看我們的資料分布囉! ------
# 基礎的plot函數可依參數的性質畫出不同的X-Y散佈圖、長條圖、盒狀圖、散佈圖矩陣：

#花萼長度(Sepal Length)與花萼寬度(Sepal Width) 散佈圖
plot(iris$Sepal.Length, iris$Sepal.Width) 
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species)

#品種類別(Species Class) 長條圖
plot(iris$Species)
plot(iris$Species, col = 2:4) 

#品種類別(Species Class)與花萼長度(Sepal Length) 盒鬚圖
plot(iris$Species, iris$Sepal.Length) 
plot(iris$Species, iris$Sepal.Length, col = 2:4) 

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


### 5.3 The k-Medoids 中心點劃分 Clustering 與 估計聚類數量? ------
# 本部分顯示k-medoids 與函數pam（）和pamk（）聚類。
# PAM (Partitioning Around Medoids) is a classic algorithm for k-medoids(中心點劃分) clustering.

?pamk
# Partitioning around medoids with estimation of number of clusters
# 對medoids進行分區的情況下來估計聚類數量?
# function pamk() in package fpc does not require a user to choose k.
# Instead, it calls the function pam() or clara() to perform a partitioning around 
# medoids clustering with the number of clusters estimated by optimum average silhouette width.

library(fpc)
pamk.result <- pamk(iris2)
pamk.result
# $pamobject
# Medoids:
#     ID Sepal.Length Sepal.Width Petal.Length Petal.Width
# [1,]   8          5.0         3.4          1.5         0.2
# [2,] 127          6.2         2.8          4.8         1.8
# Clustering vector:
# [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# [43] 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
# [85] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
# [127] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
# Objective function:
#     build      swap 
# 0.9901187 0.8622026 
# 
# Available components:
#     [1] "medoids"    "id.med"     "clustering" "objective"  "isolation"  "clusinfo"  
# [7] "silinfo"    "diss"       "call"       "data"      
# 
# $nc
# [1] 2
# 
# $crit
# [1] 0.0000000 0.6857882 0.5528190 0.4896972 0.4867481 0.4703951 0.3390116 0.3318516
# [9] 0.2918520 0.2918482

# number of clusters
pamk.result$nc
# [1] 2

# check clustering against actual species
table(pamk.result$pamobject$clustering, iris$Species)
#   setosa versicolor virginica
# 1     50          1         0
# 2      0         49        50

# 分的還不錯
149/150  # [1] 0.9933333

layout(matrix(c(1,2),1,2)) # 2 graphs per page
plot(pamk.result$pamobject)   # pamk.result中的變數 $pamobject
layout(matrix(1)) # change back to one graph per page

# pamk.result中的變數 $pamobject
pamk.result$pamobject

# 在上面的例子中，pamk（）產生兩個集群：一個是“setosa”，另一個是混合“versicolor”和“virginica”。 
# 在圖6中，左圖是一個二維的“聚類圖”（聚類）繪圖）兩個集群，線條顯示集群之間的距離。 
# 正確的一個顯示他們的 剪影。 在輪廓剪影中，一個大si（幾乎1）表明相應的觀察結果
# 聚類很好，小si（約0）意味著觀察位於兩個聚類之間，
# 並且負si的觀察可能被置於錯誤的簇中。 
# 由於平均Si在上述輪廓中分別為0.81和0.62，所識別的兩個聚類很好地聚類。

