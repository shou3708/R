# ---------
#  第10章 for 迴圈–迭代元素的傳統作法
#  10-1 for 迴圈
#  迴圈的建立從  for  開始，它所需要的引數可被分為三個部份，而這引數表面看起來就像英文句子。
# 第三部份為任一含有任何值的 vector，一般為 numeric(數值)或者character(字元)。
# 第一部份則是一個變數，這變數將迭代性地被指派於第三部份  vector  裡的每一個值。
# 中間部分則是  "in"，這表示該變數(第一部份)在(in)vector(第三部份)裡。
# ---------------------------------------------------------- #
1:10
system.time(for (i in 1:100000)
{
   print(i)
})


for (i in 1:10)
{
    print(i)
}

# user  system elapsed 
# 54.03    0.08   54.36 

i
# ---------------------------------------------------------- #

system.time(print(1:1000000))
# user  system elapsed 
# 0.19    0.00    0.16 

54.03/0.19

# ---------------------------------------------------------- #
# for  迴圈裡的 vector 也可以是非連續性的，可以是任一 vector。

# 建立一個含有水果名稱的vector
fruit <- c("apple", "banana", "pomegranate")
fruit

# 建立一個變數(亦為vector)以儲存水果名稱的長度,先儲存NA值作為開始
fruitLength <- rep(NA, length(fruit))

?rep
# Replicate Elements of Vectors and Lists

rep("a", length(fruit))

# 把它顯示出來,全部為NA值
fruitLength

# 替它取名
names(fruitLength) <- fruit

# 再次顯示,還是NA值
fruitLength

# 對fruit(水果名稱)做出迭代,每次把名稱長度都存入vector??
for (a in fruit)
{
   fruitLength[a] <- nchar(a)
}

# 把長度顯示出來
fruitLength

# ---------------------------------------------------------- #

# 只需要呼叫nchar函數
fruitLength2 <- nchar(fruit)

# 替它取名
names(fruitLength2) <- fruit

# 把它顯示出
fruitLength2

# ---------------------------------------------------------- #

identical(fruitLength, fruitLength2)

?identical
# Test Objects for Exact Equality

# ---------------------------------------------------------- #
# ---------
#  10-2 while 迴圈
#  在  R  裡，比起  for  迴圈，while  迴圈極少被使用，不過我們還是簡單介紹它的操作。只要通過所檢測的條件，它就會重複性地執行  while  迴圈大括號裡的所有指令。
# ---------------------------------------------------------- #

x <- 1
while (x <= 5)
{
  print(x)
  x <- x + 1
}

# ---------------------------------------------------------- #
# ---------
#  10-3  迴圈的強制處理
#   有時候在一些迴圈裡我們有需要跳過一些迭代過程，或者完全性地退出迴圈。
#   我們可以使用 next 和 break 來完成這件事。
# ---------------------------------------------------------- #

for (i in 1:10)
{
  if (i == 3)
  {
    next
  }
  print(i)
}

# ---------------------------------------------------------- #

for (i in 1:10)
{
  if (i == 4)
  {
    break
  }
  print(i)
}

# 使用 next 和 break 有何差別？
# ---------------------------------------------------------- #