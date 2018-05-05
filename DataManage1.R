#기초 데이터 관리

#리더쉽에 관한 조사결과
#성별에 따라 매니저의 리더쉽이 관계있나?
#국적도 중요한 요인인가?
#질문에 대한 평점은 1~5까지 설정

manager <- 1:5
date <- c('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
country <- c('US','US','UK','UK','UK')
gender <- c('M','F','F','M','F')
age <- c(32,45,25,39,99)
q1 <- c(5,3,3,3,2)
q2 <- c(4,5,5,3,2)
q3 <- c(5,2,5,4,1)
q4 <- c(5,5,5,NA,2)
q5 <- c(5,5,2,NA,1)

leadership <- data.frame(
  manager, date, country, gender, age,
  q1,q2,q3,q4,q5,stringsAsFactors = F
)

leadership

#1) 새로운 속성(컬럼) 추가 : 다섯개의 평점을 결합
#데이터 프레임에 새로운 열을 추가하려면
#$연산자나 transform 함수 사용
mydata <- data.frame(x1 = c(2,2,6,4),
                     x2=c(3,4,2,8))
mydata

# sumx <- mydata$x1 + mydata$x2              #총합
# meanx <- (mydata$x1 + mydata$x2) / 2       #평균

#데이터프레임에 새로운 열 추가 : $
mydata$sumx <- mydata$x1 + mydata$x2
mydata$meanx <- (mydata$x1 + mydata$x2) / 2 

mydata

#새로운 열 추가 attach / detach 사용
attach(mydata)
  mydata$sumx <- x1 + x2
  mydata$meanx <- (x1 + x2) / 2
detach(mydata)
  
#새로운 열 추가 :transform
mydata <- transform(mydata,
          sumx = x1 + x2,
          meanx = (x1 + x2) /2)

rm(mydata)
mydata

#2) 변수(컬럼)값 재작성
#기존의 변수나 값을 기준으로 새로운 변수값을 생성
#연속값을 가지는 변수를 3개의 카테고리로 나눔
#잘 못 작성된 값을 바른 값으로 대체
#조건에 따라 통과/탈락 변수 생성
leadership$age_cate[leadership$age == 99] <- '백수'
leadership$age_cate[90 <= leadership$age & leadership$age < 99] <- '졸수'
leadership$age_cate[80 <= leadership$age & leadership$age < 90] <- '산수'
leadership$age_cate[70 <= leadership$age & leadership$age < 80] <- '고희'
leadership$age_cate[60 <= leadership$age & leadership$age < 70] <- '이순'
leadership$age_cate[50 <= leadership$age & leadership$age < 60] <- '지천명'
leadership$age_cate[40 <= leadership$age & leadership$age < 50] <- '불혹'
leadership$age_cate[30 <= leadership$age & leadership$age < 40] <- '이립'
leadership$age_cate[20 <= leadership$age & leadership$age < 30] <- '약관'

leadership

#within을 이용해서 간결하게 작성
leadership <- within(leadership, {
    age_cate[age == 99] <- '백수'
    age_cate[age < 99] <- '졸수'
    age_cate[age < 90] <- '산수'
    age_cate[age < 80] <- '고희'
    age_cate[age < 70] <- '이순'
    age_cate[age < 60] <- '지천명'
    age_cate[age < 50] <- '불혹'
    age_cate[age < 40] <- '이립'
    age_cate[age < 30] <- '약관'
})

#3) 컬럼명 변경 - 변수명이 맘에 안든다면 바꾸자!
fix(leadership)   #데이터 편집기를 이용
leadership

names(leadership)
names(leadership)[2] <- 'newDate'
names(leadership)[6:10] <- c('q1','q2','q3','q4','q5')


rm(leadership)
#plyr 패키지를 이용해서 이름을 바꿔보자
install.packages('plyr')
library('plyr')
leadership <- rename(leadership,
                     c(manager='managerID',date='examDate',
                       country='nation'))

#4)결측값(누락된 값) 처리
#누락, 오류, 부적절한 데이터를 보완 - NA
#is.na()는 누락값 여부 확인

x <- c(1,2,3,NA)
is.na(x)          #NA 여부 확인, TRUE로 출력

is.na(leadership[,6:10])
#설문조사항목에 대해 누락값 조사

#누락값은 비교 불가능 -> 비교연산자 사용 불가
#분석에서 누락값은 제외하는 것이 좋음

y <- x[1] + x[2] + x[3] + x[4]     
#NA가 포함된 벡터에 산술연산을 하면?
z <-sum(x)
y
z

#na.rm=T 를 사용해서 누락값 제외
z <- sum(x, na.rm = T)
z

#NA가 있는 관측치를 아예 제거 na.omit()
na.omit(leadership)


#5)날짜 데이터 다루기
#현재 날짜/시간 출력 - Sys.Date(), Sys.time()
Sys.Date()    #년월일
Sys.time()    #날짜, 시간 ,장소
date()        #날짜, 시간, 요일

#날짜 데이터를 입력할 때는 보통 문자형식을 사용
#경우에 따라 날짜로 검색하거나 계산해야 할 필요가 있으면
#문자형식을 날짜 형식으로 변환 해야함
#as.Date() : 기본형식은 yyyy-mm-dd
mydate <- c('2007-10-05','2018-03-01')
class(mydate)
mydates <- as.Date(mydate)
class(mydates)

#기본형식이 아닌 다른 형식의 날짜 데이터는
#형식 지정자를 사용해서 변환 해야함
mydate <- c('01/05/2016', '08/16/1975')
mydates <- as.Date(mydate, '%m/%d/%Y')
mydates

fmt <- '%m/%d/%y'    # %y는 2자리 년도
leadership$date <- as.Date(leadership$date, fmt)
leadership

#날짜 변환 -format() : 형식 지정자 %m %d %y
today <- Sys.Date()
format(today, format = '%m %b %B %Y %y')
format(today, format = '%A %a %d')

#날짜계산
#태어난 이후로 얼마나 흘렀나?
sdate <- as.Date('1989-08-24')
edate <- as.Date('2018-03-01')
mydays <- edate - sdate
mydays

difftime(edate, sdate)
difftime(edate, sdate, units = 'weeks')
difftime(edate, sdate, units = 'hours')

#형변환
#as.numeric() : is.numeric()
#as.Character() : is.Character()
#as.logical() : is.logical()
#날짜를 문자로 변환 - as.Character()
strDate <- as.character(edate)
class(strDate)

a <- 1:3
is.numeric(a)
is.vector(a)

a <- as.character(a)
is.numeric(a)
is.character(a)

#데이터 정렬 - order()
leadership[order(leadership$age),]
leadership[order(leadership$gender,leadership$age),]
leadership[order(leadership$gender,-leadership$age),]

#테이터 병합 - merge(), rbind()
#데이터가 여러 위치에 존재한다면 이것을 결합해보자!

#열 추가하기 - 수평적 결합
#조건 : 두개의 df를 결합하려면 공통의 키가 존재해야 함

merge(dfA, dfB, by='ID')
merge(dfA, dfB, by=c('ID', 'country'))

id <- 3:6
fname <- c('park','kim','jeong','song')
pinfo1 <- data.frame(id, fname)

pinfo1

id <- 5:7
fname <- c('lim','yeon','park')
pinfo2 <- data.frame(id, fname)

pinfo2

id <- 1:2
fname <- c('seo','lee')
pinfo3 <- data.frame(id, fname)

merge(pinfo1, pinfo2, by='id') #inner join
merge(pinfo1, pinfo2, by='id', all=T) #outer join
merge(pinfo1, pinfo2, by='id', all.x=T) #left outer join
merge(pinfo1, pinfo2, by='id', all.y=T) #right outer join
#2개의 df만 merge 할 수 있음 - merge(A,B,C) 는 불가!

merge(pinfo1,pinfo3, by='id')

#키가 없다면? -> cbind()
cbind(dfA, dfB)
cbind(pinfo1, pinfo3)
cbind(pinfo2, pinfo3)
?cbind

#행 추가하기 - rbind()
rbind(pinfo1, pinfo3)
rbind(pinfo2, pinfo3)


#데이터 부분집합 만들기
#df[행, 열] 표기로 원소에 접근 가능
newdata <- leadership[,6:10]      #인덱스로 추출
newdata
rm(newdata)
myvars <- c('q1','q2','q3','q4','q5')
newdata <- leadership[myvars]      #열이름으로 추출
newdata
rm(newdata)
myvars <- paste('q', 1:5,sep = '')     #q1,q2,q3...
newdata <- leadership[myvars]
newdata

paste('hello','world','!!')
paste('hello','world','!!',sep = '-')
paste('hello','world','!!',sep = '')


#변수 제외하기 : !, -, NULL
myvars <- names(leadership) %in% c('q3','q4')
#%in% : R의 특수 연산자 - 특정값 포함 여부 검사
myvars

newdata <- leadership[myvars]    #TRUE인 열만 출력
newdata <- leadership[!myvars]

newdata <- leadership[c(8,9)]      #8,9열 출력
newdata <- leadership[-c(8,9)]

leadership$q3 <- leadership$q4 <- NULL
leadership

#관측치를 검색 후 선택
newdata <- leadership[1:3,]    #1,2,3행 출력, 조건x
newdata

leadership[leadership$gender == 'M' & leadership$age > 30,]  #성별=남자, 나이>30
leadership
attach(leadership)
  leadership[gender == 'M' & age > 30,]
detach(leadership)

#날짜 기간으로 검색
#먼저, 문자형식을 날짜형식으로 변환
leadership$date <- as.Date(leadership$date)

#검색기간도 날짜 형식으로 작성
startdate <- as.Date('2014-10-25')
enddate <- as.Date('2014-10-31')

#which 함수 사용
which(leadership$date >= startdate &
  leadership$date <= enddate)
newdata <- leadership[which(
  leadership$date >= startdate &
    leadership$date <= enddate),]
newdata

#mtcars 자료집합을 이용해서 which 사용하기
?mtcars
mtcars

#변속기am==0가 자동, 실린더cyl가 4인 차 자동차의 연비mpg 출력
cardata <- mtcars[which(mtcars$am == 0 & mtcars$cyl == 4), 'mpg']
cardata

#위 사례들 보다 쉽게 부분 데이터 추출 - subset()
#subset(df, 조건, select=출력대상)
#나이가 35이상이거나 24이하인 매니저의 1,2 문항 출력
newdata <- subset(leadership, age > 35 | age < 24,
                  select=c(q1,q2))
newdata

#성별이 남M이고, 나이가 25이상인 매니저의 성별, 나이 q1,q2,q5 문항 출력
newdata <- subset(leadership, gender == 'M' & age >= 25,select = 4:8)
newdata

#무작위 표본 추출 - sample : 비복원/복원 추출
?sample
sample(x=1:10)                #비복원 추출
sample(x=1:10, replace = T)   #복원 추출
data <- 1:10
sample(x=data,3)
sample(x=data,3,replace = T)

mysample = leadership[sample(1:5,3),]
mysample = leadership[sample(1:5,3,replace = T),]
mysample = leadership[sample(1:nrow(leadership),3,replace = T),]
mysample

#행/열의 수 출력 : nrow(), ncol()
nrow(leadership)
ncol(leadership)

#데이터를 SQL처럼 사용하자! - sqldf
#sqldf는 SQL명령이 호출되면 자동으로 스키마 생성 후
#데이터를 테이블에 불러온 후 SQL문을 실행함
install.packages('sqldf')
library('sqldf')
#구글에서 제공하는 데이터집합 - Fruits
install.packages('googleVis')
library('googleVis')
Fruits
mtcars
iris #붓꽃 3가지 종류에 대해 꽃받침, 꽃잎 길이 정리
sqldf('select * from iris')
# 붓꽃 종을 출력 - 중복 배제
sqldf('select distinct Species from iris')
unique(iris$Species)
iris[!duplicated(iris$Species),]
install.packages("dplyr")
library(dplyr)
distinct(iris,iris$Species)       #dplyr 패키지 필요!
?distinct

#연습
sqldf('select Species from iris where "Petal.Width" >= 0.5')
sqldf('select Fruit from Fruits where Year=2010 and Location="West"')
sqldf('select * from mtcars where am=0 and cyl=4')

sqldf('select * from Fruits')
sqldf('select * from Fruits where Fruit = "Apples"')
sqldf('select * from Fruits order by Fruit DESC limit 3')
sqldf('select * from Fruits order by Year')
sqldf('select Fruit, avg(Sales) from Fruits group by Fruit')

sqldf('select count(Species) as count from iris where "Petal.Width" > 0.5')
sqldf('select species, max("Sepal.Length") as max from iris group by species')

?sqldf
