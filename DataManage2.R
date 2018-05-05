#학생 성적 데이터에 대해 학점을 부여
#3 과목 점수가 일정하지 않음 - 평균, 편차 구하기가 어려움
#학점을 구하려면 백분위를 결정
#이름으로 정렬하기 어려움 - 성과 이름 분리

#수학함수
data <- c(1,6.7,3.1,-5.6,-3.1,0.7,0,9,-6)
ceiling(data)      #올림
floor(data)        #버림
round(data)        #반올림   round(값, 숫자) 기본값 0의 자리
trunc(data)        #절삭
signif(data,1)     #유효숫자
sqrt(data)         #제곱근
abs(data)          #절대값
?signif

sort(data)         #정렬
rev(data)          #역순
rank(data)         #순위
cumsum(data)       #누적합
cumprod(data)      #누적곱
cummax(data)       #누적 최소값
cummin(data)       #누적 최대값

#통계함수
data <- c(2,7,5,3,1,4,6)

sum(data)
prod(data)
max(data)
min(data)
diff(data)       #차분
which.max(data)   #max의 index 값
which.min(data)
range(data)      #범위

mean(data)      #평균
median(data)    #중간값
sd(data)        #표준편차
var(data)       #분산
mad(data)       #중위값

#확률함수 : runif()  - 0~1사이의 균등분포 난수 생성
#set.seed(nnn)    - 임의값 시드 지정
set.seed(pi)
runif(10)

#문자함수
#nrow, ncol
ch <- c('ab','xyz','abc123')
nchar(ch)     #문자수를 센다

ch <- 'abc123987'
substr(ch,4,9)      #지정한 위치의 문자를 추출

grep('xyz',ch,fixed = T)     #지정한 패턴에 의해 문자 검색(index 값)
x <- c('abc','123','xyz','987')
grep('xyz',x,fixed = T)      

sub() #패턴에 의해 지정한 문자를 검색하고 문자 치환
sub('\\s','.','Hello,World!')       #공백 -> .
sub('\\s','.',' Hello,World!')
sub('\\s','.','Hello,World! ')

strsplit()    #문자에서 특정 요소를 분리
c <- strsplit('abc123','')
c

paste()  #구분자로 문자열을 분리한 후 결합
paste('x', 1:3, sep = '')
paste('x', 1:3, sep = '^')
paste('오늘은',date())

toupper(ch)  #대문자 변환
tolower(ch)  #소문자 변환

#성적처리
#성적 처리 지표 : ABCDF
#성과 이름을 분리
options(digits = 2)    #소수점 2자리
Student <- c('John Davis','Angela Williams','Bullwinkle Moose','David Jones',
             'Janice Markhammer','Cheryl Cushing','Reuven Ytzrhak','Greg Knox',
             'Joel England','Mary Rayburn')
Math <- c(502,600,412,358,495,512,410,625,573,522)
Science <- c(95,99,80,82,75,85,80,95,89,86)
English <- c(25,22,18,15,20,28,15,30,27,18)

examdata <- data.frame(Student, Math, Science, English, stringsAsFactors = F)

#성적 데이터를 표준화 시킴 : scale
#이웃분류KNN,벡터지원SVM,신경망 등
#많은 분류 알고리즘에 유용하게 사용
#변수값을 적당한 수준으로 조정 : 0~1, -1~1
#조정된 값을 평균과 표준편차로 다시 재계산
iris[1:4]
scale(iris[1:4])

#성적데이터 표준화
newdata <- scale(examdata[,2:4])

#평균점수 구하기
mean(newdata)    #결과가 제대로 안나옴
#apply함수 이용
#특정연산을 손쉽게 처리하게 해주는 함수
iris[1:4]
apply(iris[1:4],1,mean)
apply(iris[1:4],2,mean)
apply(iris[1:4],1,function(x)(x+100))
apply(Fruits[4:6],1,mean)
apply(Fruits[4:6],2,mean)
score <- apply(newdata,1,mean)     #행단위 연산 1 열단위 연산 2
score
?apply

#구해진 평균점수를 roster 테이블에 열로 추가
examdata <-cbind(examdata,score)
examdata

#newdata에서 각 학생 별로 최대값, 최소값을 출력해서
#maxscore, minscore 이름으로 열을 추가
maxscore <- apply(newdata,1,max)
minscore <- apply(newdata,1,min)
newdata <-cbind(newdata,maxscore,minscore)
newdata

#newdata에서 각 과목별로 최대점수, 최소점수을 출력해서
#maxmath, maxsci, maxeng
#minmath, minsci, mineng
rmaxscore <- apply(newdata,2,max)
rminscore <- apply(newdata,2,min)

#학점 계산 - 사분위수
#quantile() - 집단에서 측정된 수치의 특성을 표현
#분위수 - 확률적으로 균등하게 영역을 나눠 계산한 수
y <- quantile(score, c(.8, .6, .4, .2))
y



examdata$grade[score >= y[1]] <- 'A'    #상위 20% : 0.74 
examdata$grade[y[2] <= score & score < y[1]] <- 'B'             #상위 40% : 0.44
examdata$grade[y[3] <= score & score < y[2]] <- 'C'             #상위 60% : 0.    
examdata$grade[y[4] <= score & score < y[3]] <- 'D'
examdata$grade[score < y[4]] <- 'F'
examdata

#이름에서 성과 이름 분리 : strsplit
strsplit(examdata$Student,' ')  #공백으로 분리 sep=' '

name <- c('a 1','b 2')
names <- strsplit(name, ' ')
names[[1]][1]

apply(names, 1, '[')
sapply(names, "[", 1)    #names에 있는 모든 원소에 대해
                         #원소 추출함수 ([) 적용 후 첫 번째 원소 목록 출력
names <- strsplit(examdata$Student, ' ')
fname <- sapply(names, '[', 1)
lname <- sapply(names, '[', 2)
fname
lname

rm(examdata)
#examdata <- cbin(fname, lname)    확인용
examdata <- cbind(fname, lname, examdata[,-1])
examdata
#이름과 성을 각각 열로 추가하고,
#기존 데이터프레임에서 첫번째 열을 제외한 뒤
#나머지를 여기에 각각 열로 추가한

examdata <- examdata[order(fname,lname),]
examdata

#apply:
#배열, 행렬에 함수를 행이나 열의 방향으로 적용
#결과는 벡터, 행렬, 리스트로 출력(범용으로 사용)

#sapply: sapply(대상, 함수)
#apply나 lapply를 사용하기 편하게 간편화 시킴

#lapply:

sum(1:20) # 1~20까지의 합 - 벡터, 1차원배열
nums <- matrix(1:20, ncol=4)   #2차원 배열
apply(nums, 1, sum)            #행 단위로 sum 적용
apply(nums, 2, sum)            #열 단위로 sum 적용

iris[1:4]
class(iris[1:4])
iris[,1:4]
class(iris[,1:4])

apply(iris[,1:4],1, mean)   #결과 벡터(행)
apply(iris[,1:4],2, mean)   #결과 벡터(열)
lapply(iris[,1:4], mean)    #결과 리스트(열)
sapply(iris[,1:4], mean)    #결과 벡터(열)

#실행흐름 제어 : if, for, switch
#반복문 - 자주 사용하지 X : apply 함수 이용
for(i in 1:10) {
  print(i)
  result <- i * 3
  print(result)
}

i <- 1
while(i <= 10) {
  print(i)
  i <- i + 1
}

i <- 1
while(T) {
  i <- i * 3
  print(i)
  if(i > 99999) break
}

i <- 1
repeat{                   #do-while 구문과 유사
  result <- i * 3
  print(result)
  if(i > 9999) break
  i <- i + 1
}

#조건문 - if
grade <- '수'
if (is.character(grade))
  grade <- as.factor(grade)
class(grade)
if(!is.character(grade)){
  grade <- as.factor(grade)
} else {
  print('이미 factor형으로 선언된 변수입니다!')
}

#ifelse(조건, 문장1, 문장2)
i <- 11
ifelse(i>10,'10보다 크다','10보다 작다')

x <- c(6:-4)
x
sqrt(x)      #경고 표시 - 음수는 제곱근 계산 불가!
sqrt(ifelse(x>=0, x, NA))

#switch:
todayfeels <- c('sad','blue','happy','afraid')
for(i in todayfeels) {
  print(switch (i,happy='행복',afraid='두려움',blue='우울',sad='슬픔'))
}

todayfeels <- 1:4
for(i in todayfeels) {
  print(switch(i,'행복','두려움','우울','슬픔'))
}

#데이터 집계 - aggregate
#특정한 값을 기준으로 그룹화 한후 다양한 집계 처리
#aggregate(계산될열~기준될열, 데이터, 함수)

library(googleVis)
Fruits  # Fruit, Year, Location, Sales, Expenses, Profit, Date

#년도별 판매액
aggregate(Sales~Year, Fruits, sum)

#과일별 판매액
aggregate(Sales~Fruit, Fruits, sum)

#과일별 최고판매액
aggregate(Sales~Fruit, Fruits, max)

#과일별 최저판매액
aggregate(Sales~Fruit, Fruits, min)

#과일별, 연도별 최저판매액
aggregate(Sales~Fruit+Year,Fruits,min)

#iris 데이터집합에서 종 별 꽃받침의 평균 길이는?
iris
aggregate(Sepal.Length~Species,iris,mean)
aggregate(Sepal.Length~Species,iris,max)
aggregate(Sepal.Length~Species,iris,min)

#iris 데이터집합에서 종 별 꽃잎의 평균 길이는?
aggregate(Petal.Length~Species,iris,mean)
aggregate(Petal.Length~Species,iris,max)
aggregate(Petal.Length~Species,iris,min)

#차종 별 도시와 고속도로의 평균 연비 계산
install.packages('MASS')
library(MASS)
str(Cars93)

data.frame(Cars93$MPG.highway, Cars93$MPG.city, Cars93$Type)

aggregate(MPG.highway~Type,Cars93,mean)
aggregate(MPG.city~Type,Cars93,mean)

#tapply : 그룹별로 함수를 적용하는 apply계열 함수
x <- 1:20
y <- rep(1:4,5) #1,2,3,4를 5번씩 반복
x
y

tapply(x, y, sum)

tapply(x, x %% 2 == 0, sum) #짝수, 홀수의 합 계산

#iris에서 종별 꽃받침 평균 길이
tapply(iris$Sepal.Width, iris$Species, mean)

#Fruits 데이터집합에서 연도 별 총 매출액
tapply(Fruits$Sales, Fruits$Year, sum)

#데이터 재구성 reshape
#데이터를 좀 더 향상된 방시긍로 자르고 붙이는 기능 제공
#wide-format data : 데이터 분석 시 많이 이용
#long-format data : 다양한 상황에 사용

#melt : 기존 데이터를 long-format data로 변형
#cast : 기존 데이터를 wide-format data로 변형

#이처럼 데이터의 구조를 바꾸려면
#reshape2패키지를 설치하고 melt, cast 함수를 사용해야함
install.packages("reshape2")
library(reshape2)

airquality     #대기질에 관련된 데이터 집합
str(airquality)

#melt : 특정컬럼을 기준으로 varialbe, value로 나눔
#데이터프레임을 다룰 때 데이터구조를 행의 키를 기준으로
#나머지를 변수화해서 하나의 열에 담아버리는 것을 melt, melting이라 함
#melt(데이터, 기준열)

head(airquality)
air1 <- melt(airquality, id.vars = c('Month','Day'))
head(air1)

melt(airquality, id=c('Month','Day'), measure = c('Solar.R','Wind'))
#Month, Day를 기준으로 Solar.R, Wind를 변수명 컬럼, 값 컬럼에 합쳐서 저장

#mydata 생성하기
ID <- c(1,1,2,2)
Time <- rep(1:2,2)
X1 <- c(5,3,6,2)
X2 <- c(6,5,1,4)

mydata <- data.frame(ID,Time,X1,X2, stringsAsFactors = F)

melted <- melt(mydata, id=c('ID','Time'))
#ID, Time을 기준으로 나머지는 변수명 컬럼, 값 컬럼에 모두 합쳐 저장

#Fruits 데이터를 year를 기준으로 나머지 데이터를 melt 하시오
Fruits
yfruits <- melt(Fruits, id.vars = 'Year')
yfruits <- melt(Fruits, id.vars = 'Year',variable.name = 'Test01' ,value.name = 'Test02' )
yfruits

dcast(yfruits, Year~Test01)

#melt된 데이터를 새로운 형식의 데이터로 만드려면
#집계함수가 적용/적용되지 않은 dcast 함수를 이용
#dcast(데이터, 기준컬럼~대상컬럼, 적용함수)

dcast(melted, ID~variable,mean)
#ID를 기준으로 variable 컬럼의 모든 데이터를 그룹화 해서 평균을 계산

dcast(melted, ID~variable, mean)
dcast(melted, Time~variable, mean)
dcast(melted, ID~Time, mean)
dcast(melted, ID+Time~variable)
dcast(melted, ID+variable~Time)
dcast(melted, ID~variable+Time)

#Fruits 데이터를 year,fruit를 기준으로 sales, expense, profit 데이터를 melt하시오.
myval <- Fruits[,c('Year','Fruit','Sales','Expenses','Profit')]
zfruits <- melt(myval, id.vars = c('Year','Fruit'))
zfruits
dcast(zfruits, Year+Fruit~variable)
dcast(zfruits, Year~Fruit+variable)

nchar("statistics")
length("statistics")