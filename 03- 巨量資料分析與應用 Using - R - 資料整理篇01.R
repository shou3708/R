#####  03- 巨量資料分析與應用 Using - R - 資料整理篇01  ####

# 資料面面觀
# 資料探勘中需要花很多時間整理資料，資料要怎麼整理？能怎麼整理，在開始之前，先了解資料的屬性，才能事半功倍。

# 美國國際開發署 https://www.usaid.gov/
# https://zh.wikipedia.org/zh-tw/%E7%BE%8E%E5%9B%BD%E5%9B%BD%E9%99%85%E5%BC%80%E5%8F%91%E7%BD%B2

# 美國國際開發署（英語：United States Agency for International Development，縮寫：USAID），或稱「美國國際開發總署」，是承擔美國大部分對外非軍事援助的聯邦政府機構，繼承國際合作總署（International Cooperation Administration）的職能。
# 美國國際開發署作為一個獨立的聯邦機構，依照美國國務院的外交政策，力求「為海外那些為過上美好生活而努力、進行著災後重建、以及為求生活於民主自由之國家而奮鬥的人們提供幫助」。

# https://www.usaid.gov/results-and-data/data-resources
# Foreign Aid Explorer dataset can also be downloaded in CSV format.
# 
#  the entire dataset used on the Foreign Aid Explorer website
# https://explorer.usaid.gov/data.html

# us_foreign_aid_complete.csv  506M
library(readr)
us_foreign_aid_complete <- read_csv("data/us_foreign_aid_complete.csv")
View(us_foreign_aid_complete)

# 在此利用美國 國際開發署 (USAID)的開放政府倡議，所提供的資料
# 網址 : http://jaredlander.com/data/US_Foreign_Aid.zip 

# 我們先來看看上述資料為何?
# Import DataSet from data (註:)
library(readr)
US_Foreign_Aid_Example00 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_00s.csv")
str(US_Foreign_Aid_Example00)
names(US_Foreign_Aid_Example00)
# [1] "Country.Name" "Program.Name" "FY2000"       "FY2001"       "FY2002"      
# [6] "FY2003"       "FY2004"       "FY2005"       "FY2006"       "FY2007"      
# [11] "FY2008"       "FY2009" 

head(US_Foreign_Aid_Example00)
# A tibble: 6 x 12
#   Country.Name Prog~ FY20~  FY2001  FY2002  FY2003  FY2004  FY2005  FY2006  FY2007  FY2008  FY2009
#   <chr>        <chr> <int>   <int>   <int>   <int>   <int>   <int>   <int>   <int>   <int>   <int>
# 1 Afghanistan  Chil~    NA      NA  2.59e6  5.65e7  4.02e7  3.98e7  4.09e7  7.25e7  2.84e7 NA     
# 2 Afghanistan  Depa~    NA      NA  2.96e6 NA       4.56e7  1.51e8  2.31e8  2.15e8  4.96e8  5.53e8
# 3 Afghanistan  Deve~    NA 4110478  8.76e6  5.45e7  1.81e8  1.94e8  2.13e8  1.73e8  1.51e8  3.68e6
# 4 Afghanistan  Econ~    NA   61144  3.18e7  3.41e8  1.03e9  1.16e9  1.36e9  1.27e9  1.40e9  1.42e9
# 5 Afghanistan  Food~    NA      NA NA       3.96e6  2.61e6  3.25e6  3.87e5 NA      NA      NA     
# 6 Afghanistan  Glob~    NA      NA NA      NA      NA      NA      NA      NA       6.31e7  1.76e6

US_Foreign_Aid_Example10 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_10s.csv")
head(US_Foreign_Aid_Example10)
# A tibble: 6 x 3
#   Country.Name Program.Name                                          FY2010
#   <chr>        <chr>                                                  <dbl>
# 1 Afghanistan  Child Survival and Health                                 NA
# 2 Afghanistan  Department of Defense Security Assistance          316514796
# 3 Afghanistan  Development Assistance                                    NA
# 4 Afghanistan  Economic Support Fund/Security Support Assistance 2797488331
# 5 Afghanistan  Food For Education                                        NA
# 6 Afghanistan  Global Health and Child Survival                   137642691

US_Foreign_Aid_Example40 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_40s.csv")
US_Foreign_Aid_Example50 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_50s.csv")
US_Foreign_Aid_Example60 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_60s.csv")
US_Foreign_Aid_Example70 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_70s.csv")
US_Foreign_Aid_Example80 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_80s.csv")
US_Foreign_Aid_Example90 <- read_csv("data/US_Foreign_Aid/US_Foreign_Aid_90s.csv")

## 問題探討01: 這八個檔案分別為美國國際開發署 (USAID)個計劃分別金援各國年度資料， ------
#              請問如何將這些檔案匯入並將資料集合併起來?

US_Foreign_Aid_Example00
US_Foreign_Aid_Example10
US_Foreign_Aid_Example40
US_Foreign_Aid_Example50
US_Foreign_Aid_Example60
US_Foreign_Aid_Example70
US_Foreign_Aid_Example80
US_Foreign_Aid_Example90

summary(US_Foreign_Aid_Example00)
# Country.Name       Program.Name           FY2000               FY2001              FY2002         
# Length:2453        Length:2453        Min.   :   -425714   Min.   :8.400e+01   Min.   :0.000e+00  
# Class :character   Class :character   1st Qu.:    625886   1st Qu.:4.855e+05   1st Qu.:5.602e+05  
# Mode  :character   Mode  :character   Median :   2850284   Median :2.311e+06   Median :2.540e+06  
#                                       Mean   :  22286469   Mean   :1.617e+07   Mean   :2.031e+07  
#                                       3rd Qu.:  12467022   3rd Qu.:9.909e+06   3rd Qu.:9.112e+06  
#                                       Max.   :1188001588   Max.   :1.096e+09   Max.   :1.585e+09  
#                                       NA's   :1729         NA's   :1507        NA's   :1582       
# FY2003               FY2004              FY2005               FY2006         
# Min.   :  -1985702   Min.   :3.400e+01   Min.   :  -1103763   Min.   :0.000e+00  
# 1st Qu.:    471648   1st Qu.:5.745e+05   1st Qu.:    278175   1st Qu.:4.134e+05  
# Median :   2615296   Median :2.472e+06   Median :   1638934   Median :2.159e+06  
# Mean   :  22458443   Mean   :1.961e+07   Mean   :  20795435   Mean   :2.015e+07  
# 3rd Qu.:   9411112   3rd Qu.:9.807e+06   3rd Qu.:   7683194   3rd Qu.:9.164e+06  
# Max.   :1934105998   Max.   :1.045e+09   Max.   :1534104430   Max.   :1.358e+09  
# NA's   :1469         NA's   :1402        NA's   :1228         NA's   :1242       
# FY2007              FY2008              FY2009         
# Min.   :0.000e+00   Min.   :4.000e+00   Min.   :0.000e+00  
# 1st Qu.:3.788e+05   1st Qu.:3.267e+05   1st Qu.:3.611e+05  
# Median :2.207e+06   Median :1.891e+06   Median :2.166e+06  
# Mean   :2.337e+07   Mean   :2.475e+07   Mean   :2.604e+07  
# 3rd Qu.:9.091e+06   3rd Qu.:9.717e+06   3rd Qu.:8.906e+06  
# Max.   :2.026e+09   Max.   :1.672e+09   Max.   :2.008e+09  
# NA's   :1233        NA's   :1112        NA's   :1152 

#  我們在這章會探討怎麼對資料重新排序，例如
# 1. 將以直行導向的資料排成橫列導向
# 2. (或反過來) 
# 3. 如何把一些分開的資料合併起來。
# R 的基本功能其實足以完成上述的工作，
# 但這裡我們會以更方便的dplyr, plyr、reshape2 和 data.table 來完成。

# 
#####  1. 初階方法 向量之間 cbind 和 rbind 資料合併 ##### 
# 要整理兩組擁有相同直行或同樣列數的資料，
# 可以使用 rbind 或者 cbind 對該資料進行合併。
# ---------------------------------------------------------- #
?cbind
# Combine R Objects by Rows or Columns
# cbind(..., deparse.level = 1)
# rbind(..., deparse.level = 1)

# cbind , c stands for column 欄位合併
# rbind , r stands for row    列合併 

# 建立兩個vector把它們當作data.frame 裡的欄位合併起來 cbind() --> "matrix"
sport <- c("Hockey", "Baseball", "Football")
sport
class(sport)  # "character"
league <- c("NHL", "MLB", "NFL")
league
trophy <- c("Stanley Cup", "Commissioner's Trophy",
            "Vince Lombardi Trophy")
trophy  #錦標杯

trophies1 <- cbind(sport, league, trophy)

trophies1
class(trophies1)  # "matrix"
dim(trophies1)    # 3 3

# 利用data.frame()建立另一個data.frame
trophies2 <- data.frame(sport=c("Basketball", "Golf"),
                        league=c("NBA", "PGA"),
                        trophy=c("Larry O'Brien Championship Trophy",
                                 "Wanamaker Trophy"),
                        stringsAsFactors=FALSE)
trophies2
trophies1
class(trophies2)  # "data.frame"
class(trophies1)  # "matrix"
dim(trophies2)    #  2 3
dim(trophies1)    #  3 3

#用rbind把它們整合成一個  data.frame
trophies <- rbind(trophies1, trophies2)
trophies
class(trophies)   # "data.frame"
dim(trophies)     #  5 3

trophies_row <- rbind(trophies1, trophies2, deparse.level = 1, make.row.names = TRUE)
trophies_row

trophies_row02 <- cbind(trophies1, trophies2, deparse.level = 1, make.row.names = TRUE)
# Error in data.frame(..., check.names = FALSE) : 
#   arguments imply differing number of rows: 3, 2, 1
# ---------------------------------------------------------- #
# rbind 和 cbind 皆可以讀入數個引數，因此可合併任何數量的物件。
# 我們也可以用 cbind 來對直行指派名稱。
names(trophies2)
cbind(Sport = sport, Association = league, Prize = trophy)
names(trophies)
trophies <- cbind(Sport = sport, Association = league, Prize = trophy)
trophies
names(trophies)
# ---------------------------------------------------------- #

## 問題探討01: 這八個檔案分別為美國國際開發署 (USAID)個計劃分別金援各國年度資料，請問如何
#              將這些匯入的資料集合併起來?

US_Foreign_Aid_Example00
US_Foreign_Aid_Example10
US_Foreign_Aid_Example40
US_Foreign_Aid_Example50
US_Foreign_Aid_Example60
US_Foreign_Aid_Example70
US_Foreign_Aid_Example80
US_Foreign_Aid_Example90


US_Foreign_Aid_Example00_90 <- rbind(US_Foreign_Aid_Example00,US_Foreign_Aid_Example90)
US_Foreign_Aid_Example00_90 <- cbind(US_Foreign_Aid_Example00,US_Foreign_Aid_Example90)

names(US_Foreign_Aid_Example00_90)
# [1] "Country.Name" "Program.Name" "FY2000"       "FY2001"       "FY2002"      
# [6] "FY2003"       "FY2004"       "FY2005"       "FY2006"       "FY2007"      
# [11] "FY2008"       "FY2009"       "Country.Name" "Program.Name" "FY1990"      
# [16] "FY1991"       "FY1992"       "FY1993"       "FY1994"       "FY1995"      
# [21] "FY1996"       "FY1997"       "FY1998"       "FY1999" 

dim(US_Foreign_Aid_Example00)    # [1] 2453   12
dim(US_Foreign_Aid_Example90)    # [1] 2453   12
dim(US_Foreign_Aid_Example00_90) # [1] 2453   24

### US_Foreign_Aid_Example00_90 是你需要的嗎???
US_Foreign_Aid_Example00_90_ok <- cbind(US_Foreign_Aid_Example00,US_Foreign_Aid_Example90[ ,-c(1,2)])

dim(US_Foreign_Aid_Example00_90_ok) # [1] 2453   22
names(US_Foreign_Aid_Example00_90_ok)
# [1] "Country.Name" "Program.Name" "FY2000"       "FY2001"       "FY2002"       "FY2003"      
# [7] "FY2004"       "FY2005"       "FY2006"       "FY2007"       "FY2008"       "FY2009"      
# [13] "FY1990"       "FY1991"       "FY1992"       "FY1993"       "FY1994"       "FY1995"      
# [19] "FY1996"       "FY1997"       "FY1998"       "FY1999" 

US_Foreign_Aid_Example90_00_ok <- cbind(US_Foreign_Aid_Example90,US_Foreign_Aid_Example00[ ,-c(1,2)])
names(US_Foreign_Aid_Example90_00_ok)
# [1] "Country.Name" "Program.Name" "FY1990"       "FY1991"       "FY1992"       "FY1993"      
# [7] "FY1994"       "FY1995"       "FY1996"       "FY1997"       "FY1998"       "FY1999"      
# [13] "FY2000"       "FY2001"       "FY2002"       "FY2003"       "FY2004"       "FY2005"      
# [19] "FY2006"       "FY2007"       "FY2008"       "FY2009" 

##### 2. 用 merge 合併兩個 data.frame #####
#   R 有一個內建的 merge 函數，可以用來合併兩個 data.frame
# ---------------------------------------------------------- #
?merge  # Merge Two Data Frames
# Merge two data frames by common columns or row names, 
# or do other versions of database join operations.
# merge(x, y, ...)

# merge(x, y, by = intersect(names(x), names(y)),
#       by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,
#       sort = TRUE, suffixes = c(".x",".y"),
#       incomparables = NULL, ...)

names(US_Foreign_Aid_Example00)
# [1] "Country.Name" "Program.Name" "FY2000"   "FY2001"   "FY2002"      
# [6] "FY2003"   "FY2004"    "FY2005"       "FY2006"       "FY2007"      
# [11] "FY2008"  "FY2009"      
head(US_Foreign_Aid_Example90$Country.Name, n= 3)   #Afghanistan 阿富汗
head(US_Foreign_Aid_Example00$Country.Name)
head(US_Foreign_Aid_Example90$Program.Name)
head(US_Foreign_Aid_Example00$Program.Name)

ls()
# [1] "league"                          "sport"                           "trophies"                       
# [4] "trophies_row"                    "trophies1"                       "trophies2"                      
# [7] "trophy"                          "US_Foreign_Aid_Example00"        "US_Foreign_Aid_Example00_90"    
# [10] "US_Foreign_Aid_Example00_90_ok"  "US_Foreign_Aid_Example00_90_row" "US_Foreign_Aid_Example10"       
# [13] "US_Foreign_Aid_Example40"        "US_Foreign_Aid_Example50"        "US_Foreign_Aid_Example60"       
# [16] "US_Foreign_Aid_Example70"        "US_Foreign_Aid_Example80"        "US_Foreign_Aid_Example90"       
# [19] "US_Foreign_Aid_Example90_00_ok" 

ls(pattern = "^U")
# [1] "US_Foreign_Aid_Example00"        "US_Foreign_Aid_Example00_90"     "US_Foreign_Aid_Example00_90_ok" 
# [4] "US_Foreign_Aid_Example00_90_row" "US_Foreign_Aid_Example10"        "US_Foreign_Aid_Example40"       
# [7] "US_Foreign_Aid_Example50"        "US_Foreign_Aid_Example60"        "US_Foreign_Aid_Example70"       
# [10] "US_Foreign_Aid_Example80"        "US_Foreign_Aid_Example90"        "US_Foreign_Aid_Example90_00_ok" 

dim(US_Foreign_Aid_Example90)  # [1] 2453   12  # 1990 ~ 1999
dim(US_Foreign_Aid_Example00)  # [1] 2453   12  # 2000 ~ 2009
Aid90s00s <- merge(x=US_Foreign_Aid_Example90, y=US_Foreign_Aid_Example00,
                   by.x=c("Country.Name", "Program.Name"),
                   by.y=c("Country.Name", "Program.Name"))
# by.x 指定左邊 data.frame 裡要用來作為關鍵詞的直行，而 
# by.y 則是對右邊的 data.frame 做出同樣的事。

dim(Aid90s00s) #[1] 2453   22  # 1990 ~ 2009  #為何是 22 個欄位，同學要知道?
head(Aid90s00s) 

#####  3. 用 plyr join 合併 data.frame #####
#  plyr 套件，它所包含的 join 函數跟 merge 是一樣的，但它運行速度比較快。
#  而它最大的缺點，是在所要連結的每個列表中，關鍵詞的直行名稱必須是一樣的。
#  plyr: Tools for Splitting, Applying and Combining Data
# ---------------------------------------------------------- #

install.packages("plyr")
require(plyr)

?join  # Join two data frames together.
# join(x, y, by = NULL, type = "left", match = "all")
# by	- character vector of variable names to join by. 
#      If omitted, will match on all common variables.
# type - type of join: left (default), right, inner or full. 
# match- how should duplicate ids be matched? 
#        Either match just the "first" matching row, or match "all"   
#        matching rows. Defaults to "all" for compatibility with merge,
#        but "first" is significantly faster.

# join 函數
# ---------------------------------------------------------- #
# join 的其中一個引數可以指定左連結、右連結、內部或完全(外部)連結。
names(US_Foreign_Aid_Example90)
Aid90s00sJoin <- join(x = US_Foreign_Aid_Example90, y = US_Foreign_Aid_Example00, by = c("Country.Name", "Program.Name"))
dim(Aid90s00sJoin)  # [1] 2453   22
head(Aid90s00sJoin)

# ---------------------------------------------------------- #
# join 的其中一個引數可以指定左連結、右連結、內部或完全(外部)連結。
# ---------------------------------------------------------- #

## 問題探討02: 再談如何將這八個檔案匯入的問題? ------------- 
getwd()
# setwd("xx") #change the directory which you want to save this file  >> 新增目錄 downloadUS8files
setwd("data/downloadUS8files")
getwd()
# [1] "data/downloadUS8files"

download.file(url="http://jaredlander.com/data/US_Foreign_Aid.zip",
              destfile="ForeignAid.zip")
# trying URL 'http://jaredlander.com/data/US_Foreign_Aid.zip'
# Content type 'application/zip' length 226642 bytes (221 KB)
# downloaded 221 KB
# You can find this file in your working directory -> ForeignAid.zip

unzip("ForeignAid.zip", exdir="dataUS")  #dataUS 目錄可以事先不存在
# 8 個檔案已經下載後解壓縮到dataUS 目錄

dir("dataUS")
# [1] "US_Foreign_Aid_00s.csv" "US_Foreign_Aid_10s.csv" "US_Foreign_Aid_40s.csv"
# [4] "US_Foreign_Aid_50s.csv" "US_Foreign_Aid_60s.csv" "US_Foreign_Aid_70s.csv"
# [7] "US_Foreign_Aid_80s.csv" "US_Foreign_Aid_90s.csv"

# ---------------------------------------------------------- #
install.packages("stringr")
require(stringr)
??stringr
#Strings are not glamorous 富有魅力的, high-profile components of R, but they do play a big role in many data cleaning and preparations tasks.

# 首先取得檔案的列表
# data12/US_Foreign_Aid_00s.csv
# data12/US_Foreign_Aid_10s.csv
# ...
# data12/US_Foreign_Aid_90s.csv
?dir  #List the Files in a Directory/Folder
# 首先取得檔案的列表
dir("dataUS", pattern="\\.csv")    #8 files in directory
dir("dataUS")                      # all files in directory dataUS

theFiles <- dir("dataUS", pattern="\\.csv")               #存入向量
# theFiles <- dir("data12/", pattern="\\.csv")  #存入向量
theFiles ; class(theFiles)
# [1] "US_Foreign_Aid_00s.csv" "US_Foreign_Aid_10s.csv" "US_Foreign_Aid_40s.csv"
# [4] "US_Foreign_Aid_50s.csv" "US_Foreign_Aid_60s.csv" "US_Foreign_Aid_70s.csv"
# [7] "US_Foreign_Aid_80s.csv" "US_Foreign_Aid_90s.csv"
# [1] "character"

length(theFiles)   # [1] 8
theFiles[7]        #取單一值"US_Foreign_Aid_80s.csv"
theFiles[5:7]      #取連續值
theFiles[c(1,3,7)] #取不連續值

# 取出相對字串 12 到 18 字元
str_sub("US_Foreign_Aid_00s.csv", start=12, end=18) 
# [1] "Aid_00s"

# 取第一個檔案 第12 到 第18 字元
str_sub(theFiles[1], start=12, end=18)  # the same


nameToUseTest <- str_sub("US_Foreign_Aid_00s.csv", start=12, end=18)
nameToUseTest   # "US_Foreign_Aid_00s.csv" --> "Aid_00s"

ls()
## 對這些檔案進行迭代
for(a in theFiles)
{
    # 建立適合的名稱以指派到資料群
    nameToUse <- str_sub(string=a, start=12, end=18)
    print(nameToUse)
    # 用read.table讀取csv檔
    # 用file.path來指定文件夾和檔名是的一個便捷的方法
    temp <- read.table(file=file.path("dataUS", a),
                       header=TRUE, sep=",", stringsAsFactors=FALSE)
    
    # 把它們指派到工作空間
    assign(x=nameToUse, value=temp)
}
# You will find 8 dataframe files in working space
ls()
# [1] "a"                               "Aid_00s"                        
# [3] "Aid_10s"                         "Aid_40s"                        
# [5] "Aid_50s"                         "Aid_60s"                        
# [7] "Aid_70s"                         "Aid_80s"                        
# [9] "Aid_90s"                         "Aid90s00s"       

?assign   #Assign a Value to a Name

View(Aid_00s)

##### An example of assign()
?assign  # Assign a Value to a Name
# assign(x, value, pos = -1, envir = as.environment(pos),
# inherits = FALSE, immediate = TRUE)
for(i in 1:6) { #-- Create objects  'r.1', 'r.2', ... 'r.6' --
    nam <- paste("r", i, sep = ".")
    assign(nam, 1:i)
}

r.1
r.4
ls(pattern = "^r..$")
ls()  # objects in working 
##### end of assign() 

## 問題探討02: 再談如何將這八個檔案匯入的問題?  >>> 已經解決囉! 

## 問題探討03: 就這樣用"勞力"將這八個檔案匯入的資料集合併起來? -------------

## 要把多筆資料合併成一個 data.frame但不想要逐一對它們手動指定連結 
## 如此案例為8個data frame 8 個國際援助資料集 so 
# 可以把所有 data.frame 放進一個 list，然後用 Reduce 陸續做連結

# 先找出data.frame的名稱
ls(pattern = "^A")
# [1] "Aid_00s"       "Aid_10s"       "Aid_40s"       "Aid_50s"       "Aid_60s"      
# [6] "Aid_70s"       "Aid_80s"       "Aid_90s"       "Aid90s00s"     "Aid90s00sJoin"

theFiles
# [1] "US_Foreign_Aid_00s.csv" "US_Foreign_Aid_10s.csv" "US_Foreign_Aid_40s.csv"
# [4] "US_Foreign_Aid_50s.csv" "US_Foreign_Aid_60s.csv" "US_Foreign_Aid_70s.csv"
# [7] "US_Foreign_Aid_80s.csv" "US_Foreign_Aid_90s.csv"

frameNames <- str_sub(string = theFiles, start = 12, end = 18)
frameNames
# "Aid_00s" "Aid_10s" "Aid_40s" "Aid_50s" "Aid_60s" "Aid_70s" "Aid_80s" "Aid_90s"

# 建立一個空list
length(frameNames)  # 有 8 個檔案

?vector  # vector produces a vector of the given length and mode.
# vector(mode = "logical", length = 0)
# mode	-  "list" or "expression" or (except for vector) "any".
v01 <- vector("list",10)  #產生10 個空 list
class(v01)
v01
# end of  ?vector

frameList <- vector("list", length(frameNames))  # 建立一個長度為 8 的 list
frameList        #已產生 8 個空 list
names(frameList)
str(frameList)
names(frameList) <- frameNames
names(frameList)
str(frameList)
frameList

frameList[[1]]
frameList[[Aid_00s]] 
#Error in frameList[[Aid_00s]] : invalid subscript type 'list'
frameList[["Aid_00s"]] 

# 把每個data.frame放入list??
?parse  # Parse Expressions 
# parse returns the parsed but unevaluated expressions in a list.
# parse(file = "", n = NULL, text = NULL, prompt = "?",
# keep.source = getOption("keep.source"), srcfile,
# encoding = "unknown")
#
# text	- character vector. The text to parse
parse00s <- parse(text = Aid_00s)
head(parse00s)
class(parse00s) #"expression"

?eval  # Evaluate an (Unevaluated) Expression
# eval(expr, envir = parent.frame(),
# enclos = if(is.list(envir) || is.pairlist(envir))
# parent.frame() else baseenv())
eval(2 ^ 2 )
eval(2 ^ 2 ^ 3)

for (a in frameNames)
{
    frameList[[a]] <- eval(parse(text = a))
    # data.frame 的名字皆為字元，而 <- 運算子所需要的是一個變數而不是字元
    # 因此我們解析(parse)該字元使其轉換為變數。 for list name only
    
}

### test only
length(frameList)  # 8
frameList[[1]]
frameList[[1]]<- NULL
frameList[[8]] <- Aid_00s
head(frameList[[8]])
head(frameList[[1]])

class(frameList[[8]])
class(frameList[[1]])
names(frameList)
names(frameList[[1]])
names(frameList[[8]]) <- "Aid_00s"
names(frameList[[8]])
#[1] "Aid_00s" NA        NA        NA        NA        NA        NA        NA       
#[9] NA        NA        NA        NA  
names(frameList)
rm(frameList)

### end of test only

# ---------------------------------------------------------- #

head(frameList[[1]])
head(frameList[["Aid_00s"]])
head(frameList[[5]])
head(frameList[["Aid_60s"]])

# ---------------------------------------------------------- #

allAid <- Reduce(function(...)
{
    join(..., by = c("Country.Name", "Program.Name"))
}, frameList)
# Reduce 會先將list中的前兩個data.frame做連結，之後再做其他data.frame 直到所有

dim(allAid) # 2453   67
View(allAid)

### 作業01 此次所的的資料輸出成 Rdata 上傳到教學平台。 -----
##  老師影片會做說明!

### 自行練習 Reduce
?Reduce
#Common Higher-Order Functions in Functional Programming Languages


install.packages("useful")
require(useful)

corner(allAid, c = 15)
?corner  #Display a corner section of a rectangular data set
# corner(x, ...)
# x  the data
# r  Number of rows to display
# c  Number of columns to show

bottomleft(allAid, c = 15)
?bottomleft  # Grabs the bottom left corner of a data set
# bottomleft(x, r = 5L, c = 5L, ...)

# example of Reduce
?Reduce  # Common Higher-Order Functions in Functional Programming Languages
# Reduce(f, x, init, right = FALSE, accumulate = FALSE)

Reduce(sum, 1:10) 
# 1+2+ ... + 10
# 55

# end of reduce



### 將 data.table	中的資料合併  #####
#  用 data.table 來對資料做連結也需要比較不一樣的指令。
#  首先我們把其中兩組資料從 data.frame 轉換成 data.tables。
# ---------------------------------------------------------- #

install.packages("data.table")
require(data.table)
dt90 <- data.table(Aid_90s, key = c("Country.Name", "Program.Name"))
dt00 <- data.table(Aid_00s, key = c("Country.Name", "Program.Name"))

# ---------------------------------------------------------- #

dt0090 <- dt90[dt00]
# dt90為左邊   dt00為右邊 所以為左連結
dim(dt0090)  # [1] 2453   22
View(dt0090)
dt9000 <- dt00[dt90]
View(dt9000)
# ---------------------------------------------------------- #
# 可以使用data.table套件的rbindlist函數進行合併 8 個檔案合併(欄位相同)
?rbindlist  #Makes one data.table from a list of many

Aid_00sDT <- as.data.table(Aid_00s)
Aid_10sDT <- as.data.table(Aid_10s)
Aid_40sDT <- as.data.table(Aid_40s)
Aid_50sDT <- as.data.table(Aid_50s)
Aid_60sDT <- as.data.table(Aid_60s)
Aid_70sDT <- as.data.table(Aid_70s)
Aid_80sDT <- as.data.table(Aid_80s)
Aid_90sDT <- as.data.table(Aid_90s)

l = list(Aid_00sDT,Aid_10sDT,Aid_40sDT,Aid_50sDT,Aid_60sDT,Aid_70sDT,Aid_80sDT,Aid_90sDT)

Aid00_90sDT_ALL <- rbindlist(l, use.names=TRUE, fill=TRUE)  
dim(Aid00_90sDT_ALL)  # [1] 19624    67  錯誤  # 作業 請修正????


#####  資料整理 使用 reshape2 套件置換行、列資料 #####

#####  melt  #####
#  Aid_00s 這個 data.frame，我們可以看到每一年都被儲存在它專屬的直行中。
#  我們要將這資料的每一列以"國家-援助計畫-年份" (country-program-year)的形式呈現
#  而所對應的援助金額(Dollars)則被儲存在一個直行裡。
# 我們使用 reshape2 裡的 melt 函數來達到上述結果。
# ---------------------------------------------------------- #

head(Aid_00s)
# Country.Name                                      Program.Name FY2000  FY2001   FY2002
# 1  Afghanistan                         Child Survival and Health     NA      NA  2586555
# 2  Afghanistan         Department of Defense Security Assistance     NA      NA  2964313
# 3  Afghanistan                            Development Assistance     NA 4110478  8762080
# 4  Afghanistan Economic Support Fund/Security Support Assistance     NA   61144 31827014
# 5  Afghanistan                                Food For Education     NA      NA       NA
# 6  Afghanistan                  Global Health and Child Survival     NA      NA       NA
# FY2003     FY2004     FY2005     FY2006     FY2007     FY2008     FY2009
# 1  56501189   40215304   39817970   40856382   72527069   28397435         NA
# 2        NA   45635526  151334908  230501318  214505892  495539084  552524990
# 3  54538965  180539337  193598227  212648440  173134034  150529862    3675202
# 4 341306822 1025522037 1157530168 1357750249 1266653993 1400237791 1418688520
# 5   3957312    2610006    3254408     386891         NA         NA         NA
# 6        NA         NA         NA         NA         NA   63064912    1764252

# ---------------------------------------------------------- #

require(reshape2)

?melt  #Convert an object into a molten data frame.

names(Aid_00s)
# [1] "Country.Name" "Program.Name" "FY2000"       "FY2001"       "FY2002"       "FY2003"      
# [7] "FY2004"       "FY2005"       "FY2006"       "FY2007"       "FY2008"       "FY2009"  

# 擷取呈現資料  Country.Name   Program.Name and Year 對應到 Dollars
# 其中 id.vars 引數是用來指定一些可以辨識不同列的直行。

melt00 <- melt(Aid_00s, id.vars=c("Country.Name", "Program.Name"),
               variable.name="Year", value.name="Dollars")

dim(melt00)      # [1] 24530     4
tail(melt00, 10)
View(melt00)

dim(melt00)  # 24530     4   why? --->  24530 = 2453 * 10  why? 4 
dim(Aid_00s) #  2453     12
names(melt00)  # "Country.Name" "Program.Name" "Year"         "Dollars"  
names(Aid_00s)
#[1] "Country.Name" "Program.Name" "FY2000"       "FY2001"       "FY2002"  
#[6] "FY2003"       "FY2004"       "FY2005"       "FY2006"       "FY2007"      
#[11] "FY2008"       "FY2009" 
# ---------------------------------------------------------- #

#現在的資料可被用來繪圖了，可讓我們很快地觀察和了解到每個計畫在不同時間點下的援助金額。
str(melt00)

unique(melt00$Country.Name)
unique(melt00$Program.Name)

length(unique(melt00$Country.Name))  #202
length(unique(melt00$Program.Name))  # 21

require(scales)
require(ggplot2)
# 把Year直排名稱的"FY"消除掉,並把它轉換成numeric
melt00$Year <- as.numeric(str_sub(melt00$Year, start=3, 6))

# 依據年份和援助計畫進行分群
meltAgg <- aggregate(Dollars ~ Program.Name + Year, data=melt00,
                     sum, na.rm=TRUE)


meltAggCountry <- aggregate(Dollars ~ Country.Name + Year, data=melt00,
                     sum, na.rm=TRUE)
# 只保留援助計畫名稱的首十個字元
# 這樣名字才能恰到好處地被放入圖中
meltAgg$Program.Name <- str_sub(meltAgg$Program.Name, start=1,
                                end=10)

ggplot(meltAgg, aes(x=Year, y=Dollars)) +
    geom_line(aes(group=Program.Name)) +
    facet_wrap(~ Program.Name) +
    scale_x_continuous(breaks=seq(from=2000, to=2009, by=2)) +
    theme(axis.text.x=element_text(angle=90, vjust=1, hjust=0)) +
    scale_y_continuous(labels=multiple_format(extra=dollar,
                                              multiple="B"))


# 只保留援助國家名稱的首十個字元
# 這樣國家名字才能恰到好處地被放入圖中
meltAggCountry$Country.Name <- str_sub(meltAggCountry$Country.Name, start=1,
                                end=10)

ggplot(meltAggCountry, aes(x=Year, y=Dollars)) +
    geom_line(aes(group=Country.Name)) +
    facet_wrap(~ Country.Name) +
    scale_x_continuous(breaks=seq(from=2000, to=2009, by=2)) +
    theme(axis.text.x=element_text(angle=90, vjust=1, hjust=0)) +
    scale_y_continuous(labels=multiple_format(extra=dollar,
                                              multiple="B"))

# ---------------------------------------------------------- #
# ---------------------------------------------------------- #

cast00 <- dcast(melt00, Country.Name + Program.Name ~ Year,
                value.var = "Dollars")
head(cast00)

# ---------------------------------------------------------- #

### dplyr ---------------
### Introducing DPLYR TUTORIAL (WITH 50 EXAMPLES) 
## Introducing Time Series Analysis with dplyr
# Important dplyr Functions to remember
# 
# dplyr 函數  | 用途                           |  Equivalent SQL
# ------------| --------------------------     | ----------------
# select()	  | Selecting columns (variables)  | SELECT
# filter()	  | Filter (subset) rows.	       | WHERE
# group_by()  | Group the data	               | GROUP BY
# summarise() | Summarise (or aggregate) data  | -
# arrange()	  | Sort the data	               | ORDER BY
# join()	  | Joining data frames (tables)   | JOIN
# mutate()	  | Creating New Variables	       | COLUMN ALIAS
