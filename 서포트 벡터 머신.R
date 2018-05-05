#서포트 벡터 머신
#https://www.csie.ntu.edu.tw/~cjlin/libsvm/
#지도학습을 통한 분류를 지원
#다양한 데이터 분포에서도 잘 작동하는 분류기법
#기계학습의 한 분야로 자료분석, 패턴인식에 주로 사용

#두 카테고리 중 하나에 속하는 데이터 집합이 주어졌을 때
#SVM은 주어진 데이터 집합을 바탕으로 새로운 데이터가 어디에 
#속할지 판단하는(비확률) 이진 (비)선형분류 모델을 사용

#분류모델은 데이터가 배치된 공간에서 경계로 표현
#SVM은 그 중 가장 큰 폭을 가진(마진이 큰) 경계를 찾는 것

#SVM은 선형분류(linear)와 더불어 비선형분류(radial)에도
#사용가능한데, 이 때 커널트릭을 이용해서 효율적으로 분류

#SVM으로 선형분류 해보기
#정규분포 난수를 이용해서 데이터 집합 생성
set.seed(9898)
x <- matrix(rnorm(20*2), ncol=2)
y <- c(rep(-1,10), rep(1,10))
x[y==1,] <- x[y==1,]+1

x
y

#생성한 데이터 집합을 산점도로 표시
plot(x, col=3-y)

#선형 분류를 하기 위해
#먼저 데이터들을 데이터 프레임으로 재 생성
data <- data.frame(x=x, y=as.factor(y))
data

#R에서 SVM을 사용하려면 e1071패키지를 이용
library(e1071)
svmfit <- svm(y~x.2+x.1,data=data, kernel='linear', cost=0.01)
?svm
plot(svmfit, data)

summary(svmfit)

#최적의 분류를  위해 적절한 cost를 찾아보자
tune.out <- tune(svm, y~x.2+x.1, data = data, kernel='linear', range=list(cost=c(0.001,0.01,0.1,1.5,10,100)))
summary(tune.out)

#검증 데이터 작성 및 예측
xtest <- matrix(rnorm(20*2), ncol = 2)
ytest <- sample(c(-1,1), 20, rep=T)
xtest[ytest==1,] <- xtest[ytest==1,]+1
testdat <- data.frame(x=xtest, y=as.factor(ytest))
testdat
svmfit2 <- svm(y~., data = testdat, kernel='linear', cost= 9999)
plot(svmfit2, testdat)

#tune함수를 통해 찾아낸 최적의 cost로 데이터 학습
bestmod <- tune.out$best.model
summary(bestmod)

pred <- predict(bestmod, testdat)
table(pred, testdat$y)

library(caret)
confusionMatrix(pred, testdat$y)

#cost가 1000일 때 와 bestmod일 때 비교
svmfit <- svm(y~., data=data, kernel='linear', cost=1000)
pred <- predict(svmfit, testdat)
table(pred, testdat$y)


#iris데이터 집합을 e1071패키지 svm으로 분류
library(caret)
library(e1071)
idx <- createDataPartition(iris$Species, p= 0.7, list = F)
train <- iris[idx,]
test <- iris[-idx,]

svm.result <- svm(Species~., train, kernel='radial')

pred <- predict(svm.result, test, type= 'response')
table(pred, test$Species)
confusionMatrix(pred, test$Species)

#iris데이터 집합을 kernlab패키지의 ksvm으로 분류
library(kernlab)
idx <- createDataPartition(iris$Species, p= 0.7, list = F)
train <- iris[idx,]
test <- iris[-idx,]

svm.result <- ksvm(Species~., train, kernel='rbfdot')
#rbfdot: radial basic function
pred <- predict(svm.result, test, type= 'response')
table(pred, test$Species)
confusionMatrix(pred, test$Species)



set.seed(9898)
x <- matrix(rnorm(20*2), ncol=2)
y <- c(rep(-1,10), rep(1,10))
x[y==1,] <- x[y==1,]+1

x
y

#생성한 데이터 집합을 산점도로 표시
plot(x, col=3-y)

#선형 분류를 하기 위해
#먼저 데이터들을 데이터 프레임으로 재 생성
data <- data.frame(x=x, y=as.factor(y))
data

#R에서 SVM을 사용하려면 e1071패키지를 이용
library(e1071)
svmfit <- svm(y~x.2+x.1,data=data, kernel='radial', cost=10000)
plot(svmfit, data)

summary(svmfit)

#최적의 분류를  위해 적절한 cost를 찾아보자
tune.out <- tune(svm, y~x.2+x.1, data = data, kernel='radial', range=list(cost=c(0.001,0.01,0.1,1.5,10,100)))
summary(tune.out)

#검증 데이터 작성 및 예측
xtest <- matrix(rnorm(20*2), ncol = 2)
ytest <- sample(c(-1,1), 20, rep=T)
xtest[ytest==1,] <- xtest[ytest==1,]+1
testdat <- data.frame(x=xtest, y=as.factor(ytest))
testdat
svmfit2 <- svm(y~., data = data, kernel='radial', cost= 100000)
plot(svmfit2, data)


#tune함수를 통해 찾아낸 최적의 cost로 데이터 학습
bestmod <- tune.out$best.model
summary(bestmod)

pred <- predict(bestmod, testdat)
table(pred, testdat$y)

library(caret)
confusionMatrix(pred, testdat$y)

#cost가 10000일 때 와 bestmod일 때 비교
svmfit <- svm(y~., data=data, kernel='radial', cost=100000)
pred <- predict(svmfit, testdat)
table(pred, testdat$y)
confusionMatrix(pred, testdat$y)


#ISLR패키지의 carseats데이터 집합을 이용한 SVM예제
#Carseats: 400개의 가게에서 팔린 유아용 자동차 시트
#판매 관련 데이터
install.packages('ISLR')
library(ISLR)
str(Carseats)
#판매량Sales의 평균보다 낮으면
#Profit이라는 변수에 No, 높으면 Yes라고 설정
#Urban, US, ShelveLoc변수를 제외
Profit <- ifelse(Carseats$Sales <= mean(Carseats$Sales), "No", "Yes")
nCarseats <- data.frame(Carseats, Profit)

#nCarseats에서 Sales, Urban, US, ShelveLoc 변수 제외
str(nCarseats)
nCarseats <- nCarseats[,-c(1,7,10,11)]
summary(nCarseats)

#데이터 집합을 7:3으로 train, test로 분리
idx <- createDataPartition(nCarseats$Profit, p= 0.7, list = F)
train <- nCarseats[idx,]
test <- nCarseats[-idx,]
factor(test$Profit)      #Profit변수를 범주형으로 변환

#svm을 적용한 후 학습
#단, 각 변수의 변량이 서로 다르기 때문에 scale 필요
tune.out <- tune(svm, Profit~., data = train, kernel='radial', range=list(cost=c(0.001,0.01,0.1,1.5,10,100)))
summary(tune.out)
svm.result <- svm(Profit~., data = train, kernel='radial', cost=0.85)
summary(svm.result)
pred <- predict(svm.result, test, type='response')

table(pred, test$Profit)
confusionMatrix(pred, test$Profit)

#카드 씀씀이를 통한 중산층 정도 판별 여부
#1년동안 종목별 소비지출액을 0~1사이 정규화scale 했음
#status가 1이면 중산층으로 분류
pos <- read.csv('c:/Java/posdata.csv')
str(pos)

idx <- createDataPartition(pos$status, p= 0.7, list = F)
train <- pos[idx,]
test <- pos[-idx,]

tune.out <- tune(svm, status~., data=train, kernel='radial',ranges = list(cost=c(0.001,0.01,0.1,1.5,10,100)))
summary(tune.out)
svm.result <- svm(status~., data=train, kernel = 'radial',type='C-classification', cost=99999)
pred <- predict(svm.result, test,type='response')

table(pred, test$status)
confusionMatrix(pred, test$status)
