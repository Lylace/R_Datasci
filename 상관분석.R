#2의 변수 x,y가 있을 때
#두 변수가 서로 어떤 관계에 있는지 파악하는 경우 존재

#키x가 클수록 몸무게y도 증가하는가?
#교육x을 많이 받으면 소득y이 증가하는가?
#광고x를 많이 하면 판매량y이 커지는가?

#이처럼 두 변수가 서로 어떤 관계에 있는지 파악 - 상관분석
#두 변수의 상관관계는 산점도로 나타내고
#점들이 흩어져 있는 모습을 보고 관계를 파악
#기울기에 따라 양/음의 상관관계로 분류

#상관분석은 서로가 어떤관계에 있는지 파악할 수 가 있지만,
#서로의 인과관계는 파악할 수 없다.
#즉, 여름이 다가오면 빙과류가 많이 팔린다
#여름이 다가오면 모기가 점점 많아진다
#하지만, 모기가 많아져서 빙과류가 많이 팔리나?
#이것은 서로 직접적인 관련은 없다
#단지, 여름이라는 변수가 큰 영향을 미쳤을 뿐이다
#간혹 다른상황에서는 서로 직접적인 영향을 주고 받는 경우도 존재

cor()

#회사에서 신제품이 출시 되었을 때
#안내메일을 발송하는 횟수와 제품 판매량 사이 관계 조사
# 제품판매량 : 3,5,8,11,13
# 안내메일발송수 : 1,2,3,4,5

x <- c(3,5,8,11,13)
y <- 1:5

cor(x,y) #상관계수
#-0.7 ~ -1.0 : 강한 음적 선형관계
#-0.3 ~ -0.7 : 뚜렷한 음적 선형관계
#-0.1 ~ -0.3 : 약한 음적 선형관계
#-0.1 ~ 0.1 : 거의 무시해도 좋음
#0.1 ~ 0.3 : 약한 양적 선형관계
#0.3 ~ 0.7 : 뚜렷한 양적 선형관계
#0.7 ~ 1.0 :강한 양적 선형관계

#상관계수
#상관분석은 두 변수가 서로 어떤 관계인지를 파악하는 분석
#점들이 흩어져 있는 모습을 보고 두 변수의 관계를 파악하는데
#과연, 점들이 모여있는 밀도는 어떻게 표현할까?

#예를 들어, 둘 다 같은 양의 상관관계라 하더라도
#점들이 모여있는 모습(밀도)가 다를 수 있기 때문에
#서로 얼마나 다른지 정도를 알 수 있는 방법이 필요
#그림으로 파악이 되어도 수학적 표기 역시 필요

#따라서, 통계에서는 추가로 숫자를 사용해서 밀도 표현
#이 밀도를 표현한 숫자가 상관계수임
#보통 -1 ~ +1까지만 사용해서 밀도를 표현함

#한편, 상관분석은 변수에 따라 치우침이 다른 경우 발생
#즉, 상관계수가 크게 나와도 치우침이 상대적으로 작거나
#상관계수가 작은데 치우침이 커서 상관계수가 작게 나오는 경우도 발생
#따라서, 위 기준에 맞지 않는 상황 발생
#보조적으로 가설검증으로 결과 해석 필요

#실업자 수와 개인 소비 지출의 상관관계 분석
library(ggplot2)
?economics
str(economics)
cor(economics$unemploy, economics$pce)
#상관계수: 양의 상관관계 존재
#즉, x값이 증가하면 y값이 증가(정비례)
cor.test(economics$unemploy, economics$pce)
#상관계수에 대한 가설 검증

plot(economics$unemploy, economics$pce, type = 'l')

qplot(unemploy, pce, data=economics,
      geom = c('point','smooth'))

#실업자수와 개인저축률의 상관관계 분석
cor(economics$unemploy, economics$psavert)
#상관계수: 음의 상관관계 존재
#즉, x값이 증가하면 y값이 감소(반비례)
cor.test(economics$unemploy, economics$psavert)
qplot(unemploy, psavert, data=economics,
      geom = c('point','smooth'))

#iris에서 꽃받침, 꽃잎의 너비/길이에 대한 상관계수 계산
cor(iris$Sepal.Width, iris$Sepal.Length)
cor(iris[,1:4])

airs <- airquality[,1:4] #공기오염도 데이터
airs <- na.omit(airs)

cor(airs)

plot(airs$Ozone)

abline(airs$Ozone/150, 1:150) #임의 추세선
plot(airs$Solar.R)
plot(airs$Wind)
plot(airs$Temp)

plot(airs) #산점도 작성

pairs(airs ,panel = panel.smooth)

library(ggplot2)
qplot(Ozone, Solar.R, data=airs,
      geom = c('point','smooth'))


#공분산
#치우침을 활용해서 상관계수를 구하는데
#통계에서 치우침을 표현하는 대표적인 기호는 분산
#분산을 이용해서 상관계수를 구하기도 하지만 복잡!
var()

#한편, 상관분석은 기본적으로 변수가 2개이므로
#치우침은 2개의 변수에 의해 발생
#따라서, 각각의 분산 외에도 두 변수의 공통된 치우침도
#알아야 하는데 두 변수의 공통된 치우침을 공분산이라 함
cov()

#Cars93데이터에서 고속도로연비와 차체 중량의 상관관계 분석
library(MASS)
str(Cars93)

plot(Cars93$Weight,Cars93$MPG.highway)
plot(MPG.highway~Weight,data = Cars93)
abline(lm(MPG.highway~Weight,data = Cars93),col='red')
#음의 상관관계 확인

cor(Cars93$Weight,Cars93$MPG.highway) #공분산을 표준화한 것 - 상관계수
cov(Cars93$Weight,Cars93$MPG.highway) #음수출력 - 음의 상관관계

#상관행렬
#여러 변수(2개이상)의 상관관계를 한번에 알아보고자
#하는 경우 모든 변수에 대한 상관관계를 알려주는 상관행렬을 사용
cor()
corrplot()

#자동차 각 요소에 대한 상관관계를 분석 - mtcars 이용
head(mtcars)

cor_cars <- cor(mtcars)  #상관행렬 생성
cor_cars <- round(cor(mtcars), 2) #소수점 조정
cor_cars #각 항목에 대한 상관계수 파악 어려움

install.packages("corrplot")
library(corrplot)
corrplot(cor_cars,method = 'pie') #상관행렬을 열 그래프로 시각화
                   #파란색 - 양의 상관관계
                   #빨강색 - 음의 상관관계
?corrplot

corrplot(cor_cars,method = 'shade')
corrplot(cor_cars,method = 'pie')
corrplot(cor_cars,method = 'color')

#놀이동산 만족도에 대한 상관관계 분석
#주말이용여부, 동반자녀수, 공원까지 거리, 기구 만족도,
#게임 만족도, 대기시간 만족도, 청결도 만족도, 전체 만족도
tp <- read.csv('C:/Java/놀이동산에 대한 만족도.csv', header = T)
str(tp)
tp[,2:8]

#그래프 확인
plot(tp$overall~tp$rides) #놀이기구/전체만족도 상관관계

#공분산
cov(tp$overall, tp$rides)

#상관계수
cor(tp$overall, tp$rides)

#상관계수 가설검증
cor.test(tp$overall, tp$rides)

#전체만족도와 세부만족도에 대한 상관관계 분석
plot(tp[,4:8]) #산포도 작성
tp_cor <- cor(tp[,4:8])
corrplot(tp_cor, method = 'pie',type = 'lower') #상관행렬 그래프
