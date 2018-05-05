# 데이터 시각화
# 인간의 시지각 능력을 토대로 데이터에 대한 이해와 설득에 도움을 주기 위해 그림이나 도
# 형 등의 그래픽 요소들을 이용하여 데이터를 묘사하고 표현하는 것이다.

# 시각화 기능
# 데이터 시각화의 기능은 설명, 탐색, 표현의 세 가지로 구분

#설명기능 - 데이터의 시각화를 통해 전달하려는 메시지와 주요한 분석 결과를 설명하는 기능
#탐색기능 - 데이터에 숨겨져 있는 관계와 패턴을 찾기 위한 시각적 분석 기능
#표현기능 - 데이터를 활용한 개인 작품이나 예술적인 표현을 통해
#           감정적인 시선이나 이야기 전달, 공감을 불러일으키기 위한 기능

#서울시 교통사고 - http://stat.seoul.go.kr, http://data.seoul.go.kr
accid_2015 <- read.csv('c:/Java/seoul_car_acci_v1.txt', sep=',',header=T)
accid_2016 <- read.csv('c:/Java/seoul_car_acci_2016.txt', sep='\t',header=T)
accid_2005_2016 <- read.csv('c:/Java/seoul_car_acci_2005_2016.txt', sep='\t',header=T)

head(accid_2015)
head(accid_2016)
head(accid_2005_2016)


#R 시각화 도구
#graphics: R 기본 시각화도구, 별도 설치x, 쉽고 사용하기 간편
#ggplot2: R 고급 시각화 도구, 별도 설치o, 배우기 다소 어려움
#lattice: R 시각화 도구, 별도 설치o, 다중 그래프 작성 시 편리, 직관성 떨어짐

# install.packages('lattice')
# library(lattice)

install.packages('ggplot2')
library(ggplot2)

#그래프 작성 보조 도구 - dplyr
library(dplyr)

#산점도
head(iris)
gg1 <- ggplot(iris, aes(Sepal.Length, Sepal.Width))
#그래프 작성 초기화(데이터집합, x축, y축)
gg1 <- gg1 + geom_point()
#점 그래프: 산점도, 산포도
gg1

#Speices별로 색상을 지정해서 산점도
#colour 항목 별로 자동 적용 하려면 factor 타입이어야 함
gg2 <- ggplot(iris, aes(Sepal.Length, Sepal.Width))
gg2 <- gg2 + geom_point()
gg2 <- gg2 + geom_point(aes(colour=Species,size=Petal.Width))
gg2

#서울 중구 2015 교통사고 현황(월/발생건수)를 산점도geom_point로 작성
str(accid_2015)
joong_gu2015 <- subset(accid_2015, 자치구명=='중구')
joong_gu2015

p1 <- ggplot(joong_gu2015, aes(월,발생건수))
p1 <- p1 + geom_point(aes(colour=월,size=발생건수)) + xlim(1, 12) + ylim(0, 150) #x,y상하한값
p1 <- p1 + ggtitle('2015 중구 월별 교통사고 발생현황')
p1


#또 다른 유형 산점도
x <- 1:50
# y <- sapply(x,function(x) { x/(x+1) })
y <- sapply(x,function(x) x/(x+1))    # 중괄호 생략
df <- data.frame(x,y)
head(df)

gg3 <- ggplot(df, aes(x,y)) + geom_point()
gg3

#다이아몬드 데이터집합
#캐럿 당 가격을 산포도로 그림, 색상은 colour 변수 사용
head(diamonds)

gg4 <- ggplot(diamonds, aes(carat, price)) + geom_point(aes(colour=color, size=carat))
gg4

#선그래프 : geom_line
head(economics)

#시기date별 실업률unemploy 현황
gg5 <- ggplot(economics) + geom_line(aes(date,unemploy))
gg5

#선 그래프에 색상/크기 지정
gg6 <- ggplot(economics, aes(date,unemploy)) + geom_line(colour='red',size=1, linetype=3)
gg6 

#여러 개의 선 그래프 작성
gg7 <- ggplot(economics) + geom_line(aes(date,pce) ,colour='red') + geom_line(aes(date,unemploy))
gg7

#오렌지 나무 연령별 둘레 현황
head(Orange)

gg8 <- ggplot(Orange, aes(age, circumference)) + geom_line(aes(colour=Tree)) + geom_point()
gg8

#서울 중구 2015 교통사고 현황(월/발생건수)를
#선그래프geom_line으로 작성
q1 <- ggplot(joong_gu2015, aes(월,발생건수)) + geom_line()+ geom_point()
q1 <- q1 + xlim(1,13) + ylim(0,150)
q1 <- q1 + ggtitle('2015년 중구 월별 교통사고 발생현황')
q1

q1a <- ggplot(joong_gu2015, aes(월,발생건수)) + geom_line()+ geom_point()
q1a <- q1a + xlim(1,13) + ylim(0,150)
q1a <- q1a + ggtitle('2015년 중구 월별 교통사고 발생현황')
q1a <- q1a + scale_x_continuous(breaks = 1:12) 
q1a <- q1a + theme(panel.background = element_rect(fill='white',colour = 'grey'),
                   plot.title = element_text(hjust=0.5))
q1a

#막대 그래프: geom_bar
head(mtcars)
str(mtcars)    #factor 요소 확인
#차량 별 실린더 수 현황 히스토그램
gg9 <- ggplot(mtcars, aes(cyl)) + geom_bar()
gg9

fcyl <- factor(mtcars$cyl)
gg9a <- ggplot(mtcars, aes(fcyl)) + geom_bar(aes(fill=fcyl),width = 0.5)
#cyl은 num타입 - factor형으로 변환
gg9a

#누적 막대 그래프
fgear <- factor(mtcars$gear)
gg9b <- ggplot(mtcars, aes(fcyl)) + geom_bar(aes(fill=fcyl),width = 0.5) + geom_bar(aes(fill=fgear),width = 0.5)
#cyl은 num타입 - factor형으로 변환
gg9b

#수평 누적 막대 그래프
gg9c <- ggplot(mtcars, aes(fcyl))
gg9c <- gg9c + geom_bar(aes(fill=fcyl),width = 0.5) + geom_bar(aes(fill=fgear),width = 0.5)
gg9c <- gg9c + coord_flip()
gg9c

#일반적인 막대 그래프
#실린더 수에 따른 연비 그래프
#stat='identity'는 y축에 mpg값을 그대로 사용하라는 의미
gg10 <- ggplot(mtcars, aes(fcyl, mpg))
gg10 <- gg10 + geom_bar(aes(fill=fcyl), stat = 'identity')
gg10

#서울 중구 2015 교통사고 현황(월/발생건수)를
#막대그래프geom_bar로 작성
p4 <- ggplot(joong_gu2015, aes(월,발생건수))
# p4 <- p4 + geom_bar(aes(fill=월),width=0.5,stat='identity')
# p4 <- p4 + geom_bar(fill=월,width=0.5,stat='identity')
p4 <- p4 + geom_bar(fill=rainbow(12),width=0.5,stat='identity')
p4 <- p4 + scale_x_continuous(breaks = 1:12)
p4

#서울 2015년 12월 각 자치구 별 교통사고 현황(자치구명/발생건수)를 출력
#막대그래프geom_bar로 작성
accid_2015_12 <- subset(accid_2015, 월==12)
head(accid_2015_12)
str(accid_2015_12)
p5 <- ggplot(accid_2015_12, aes(자치구명,발생건수))
# p5 <- p5 + geom_bar(aes(fill=rainbow(25)),width=0.5,stat='identity')
p5 <- p5 + geom_bar(aes(fill=자치구명),width=0.5,stat='identity')
p5 <- p5 + theme(axis.text.x = element_text(angle = 270, hjust = 1))
p5

#2015년 12월 서울 각 자치구 별
#교통사고 현황(자치구명/부상자수)를 출력
p6 <- ggplot(accid_2015_12, aes(자치구명,부상자수))
p6 <- p6 + geom_bar(aes(fill=자치구명),width=0.5,stat='identity')
p6 <- p6 + theme(axis.text.x = element_text(angle = 270, hjust = 1))
p6

#2015년 12월 서울 각 자치구 별
#교통사고 현황(자치구명/사망자수)를 출력
p7 <- ggplot(accid_2015_12, aes(자치구명,사망자수))
p7 <- p7 + geom_bar(aes(fill=자치구명),width=0.5,stat='identity')
p7 <- p7 + theme(axis.text.x = element_text(angle = 270, hjust = 1))
p7

#원 그래프 : coord_polar()
gg9 <- gg9 + coord_flip()
gg9      #수평막대

gg9p <- gg9 + coord_polar()
gg9p     #원그래프

gg10 <- ggplot(mtcars, aes(factor(1), fill=fcyl))
gg10 <- gg10 + geom_bar(width = 1) + coord_polar(theta = 'y')
gg10

#
df <- data.frame(
  group = c('Male','Female','Child'),
  age = c(25, 27 ,5)
)
df

bc <- ggplot(df,aes('',age,fill=group)) + geom_bar(stat = 'identity')
bc <- bc + coord_polar(theta='y') #임의의 각도 세타 사용
bc

#heat map : heatmap()
#데이터가 행렬 객체를 사용함
accid_2015_12 #문자와 숫자가 혼재됨
row.names(accid_2015_12) <- accid_2015_12$자치구명
#accid_2015_12의 각 행의 이름을 지정
mtx_acci_2105_12 <- accid_2015_12[,4:6]
#accid_2015_12에서 발생건수, 사망자수, 부상자수 추출
mtx_acci_2105_12 <- data.matrix(mtx_acci_2105_12)
#발생건수, 사망자수, 부상자수 데이터를 행렬로 변환
str(mtx_acci_2105_12)

heatmap(mtx_acci_2105_12,col=cm.colors(128), Rowv = NA, Colv = NA,
        scale = 'column', cexCol = 1, margins = c(5,5))

#mtcars
head(mtcars)
mmtcars <- as.matrix(mtcars)
head(mmtcars)

heatmap(mmtcars)      #기본 열그래프 작성
heatmap(mmtcars, scale='column')  #정규화 작업 후 다시 그림
                                  #유사성을 나타내기 위해 군집화 실행
heatmap(mmtcars, scale = 'column',
        Colv = NA, Rowv = NA)     #군집화 제거
heatmap(mmtcars, scale = 'column',
        Colv = NA, Rowv = NA, col=rainbow(256))     #색상 지정1
heatmap(mmtcars, scale = 'column',
        Colv = NA, Rowv = NA, col=terrain.colors(256))     #색상 지정2

#버블차트
#2015년 12월 서울 각 자치구 별
#교통사고 현황(발생건수/사망자수)를 출력
gg11 <- ggplot(accid_2015_12, aes(발생건수,사망자수))
gg11 <- gg11 + geom_point(aes(size=사망자수),
                          shape=16, alpha=0.45)
# gg11 <- gg11 + scale_fill_brewer(palette='Set1')
gg11 <- gg11 + scale_fill_brewer(palette='Paired')
gg11

#scale_fill_brewer에서 지원하는 색상 팔레트 조회
RColorBrewer::display.brewer.all()

#Cars93 데이터 이용 - 도시, 고속도로별 연비
library(MASS)
head(Cars93)

#단순한 버블 그래프
ggplot(Cars93, aes(Weight, MPG.highway)) +
  # geom_point(size=6, shape=21)   #기본
  # geom_point(aes(size=MPG.highway), shape=21)  #사이즈 지정
  # geom_point(aes(size=MPG.highway), shape=21,colour='red')  #색상 지정
  geom_point(aes(size=MPG.highway), shape=21,fill='red')  #내부 채우기

# ggplot(Cars93, aes(Weight, MPG.highway,fill=Price)) +
  # 연속형 변수Price에 따라 색깔 변화
ggplot(Cars93, aes(Weight, MPG.highway,fill=Cylinders)) +
  # 범주형 변수Cylinders에 따라 색깔 변화
  geom_point(size=5,shape=21, colour='red') +
  scale_fill_brewer(palette = 'Oranges')
  #색깔 지정을 미리 정의된 팔레트 이용

#공간지도 - 지도에 통계관련 자료를 표시
head(accid_2015)
install.packages('ggmap')
install.packages('maps')
install.packages('mapproj')

library(ggmap)
library(maps)
library(mapproj)

# seoulmp <- get_googlemap('seoul')
# seoulmp <- get_googlemap('seoul', maptype = 'satellite')
seoulmp <- get_googlemap('seoul', maptype = 'roadmap', zoom = 11)
# seoulmp <- get_googlemap('seoul', maptype = 'hybrid')
# seoulmp <- get_googlemap('seoul', maptype = 'terrain')  #Default값
seoul <- ggmap(seoulmp)
seoul

rm(seoul)

head(accid_2015_12)
seoul_lat_lon <- read.csv('c:/Java/seoul_lat_lon.txt')
head(seoul_lat_lon)

#교통사고 정보와 구별 위치 정보를 합침
accid_2015_12 <- merge(accid_2015_12, seoul_lat_lon,
                       by.x='자치구명', by.y='area')
head(accid_2015_12)

#맵에 자치구 위치를 점으로 표시
gmp <- ggmap(seoulmp)
gmp <- gmp + geom_point(data=accid_2015_12,
                        aes(lon, lat, size=발생건수),
                        shape=17, color='blue',alpha=.5)
gmp <- gmp + geom_text(data=accid_2015_12, aes(label=자치구명),
                       size=3,hjust=1.2,fontface='bold')
# gmp <- gmp + geom_path(data=accid_2015_12, aes(lon, lat),
#                        color='red',alpha=.5,lwd=1)
gmp