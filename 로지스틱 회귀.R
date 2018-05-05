#로지스틱 회귀
#데이터 x의 분류가 Y일 확률을 p, N일 확률을 1-p라 할 때
#       log(p/(1-p)) / b0 + b1X 식을 활용
#독립변수 x와 종속변수 y의 관계를 회귀식을 이용해서
#연속형 값을 예측하는 것과 달리
#X변수에 대한 범주형 범수를 예측하는 것이 핵심

#예)우선 독립변수가 하나인 단순 선형회귀의 경우
#공부한시간: 2, 4, 5, 8
#성적: 81,93,91,97

#하지만, 로지스틱 회귀의 경우
#공부한시간: 2,4,6,8,10,12,14
#성적: 불합격 불합격 불합격 불합격 합격 합격 합격

#y축은 0 ~ 1 사이값을 갖고
#x축은 -무한대 ~ +무한대의 값을 가질 수 있음
#이 값들을 이용해 1차방정식을 그려보면 S모양 그래프 생성
#이러한 그래프를 그려주는 함수를 시그모이드 함수라 함

#사원들의 근태여부 판별
#나이, 결혼여부, 성별 등이 지각여부에 영향을 미칠지 분석
emp <- read.csv('c:/Java/drink.csv')
str(emp)

attach(emp)
library(class)
glm.result <- glm(지각여부~. , family=binomial(link = 'logit'),data=emp)
summary(glm.result)
#p-value값이 0.05 이하: 유의미한 결과

predict(glm.result, emp, type = 'response')
#예측값을 0~1사이의 범위로 출력

predict(glm.result, emp, type = 'response') >= 0.5
#지각여부를 알아보기 위해 0.5이상인 값들을 출력

table(emp$지각여부, predict(glm.result, emp, type = 'response') > 0.5)
#실제값과 예측값(0.5이상)들을 출력

#iris 데이터 집합을 로지스틱 회귀로 분석
#iris 데이터 집합의 Species는 setosa,versicolor,virginica
#따라서, 예측값은 이항이어야 하므로
#versicolor,virginica만 예측하도록 해보자
bi_iris <- subset(iris, Species=='versicolor' | Species=='virginica')
str(bi_iris)
bi_iris$Species <- factor(bi_iris$Species)
str(bi_iris)

#glm함수로 로지스틱 회귀 적용
glm.result01 <- glm(Species~., family = 'binomial', data = bi_iris)
summary(glm.result01)

pre_iris <- predict(glm.result01, bi_iris, type = 'response')
#0~1 사이값 예측

pre_iris >= 0.5

table(bi_iris$Species, pre_iris > .5)

#setosa, virginica만 예측 해보자
bi_iris2 <- subset(iris, Species=='setosa' | Species=='virginica')
bi_iris2$Species <- factor(bi_iris2$Species)
str(bi_iris2)

glm.result02 <- glm(Species~., family = 'binomial', data= bi_iris2)
summary(glm.result02)

pre_iris2 <- predict(glm.result02, bi_iris2, type = 'response')

pre_iris2 >= 0.5

table(bi_iris2$Species, pre_iris2 > .5)

#공부한시간에 따른 합격여부 예측
study <- read.csv('c:/Java/test.csv')
study$Pass <- factor(study$Pass)
study_glm <- glm(Pass~Hours, family = 'binomial', data = study)
summary(study_glm)

#독립변수 x의 갯수에 따른 summary출력결과
glm.result01 <- glm(Species~Sepal.Width, data = bi_iris, family = 'binomial')
summary(glm.result01)   #정상적으로? p-value 출력
glm.result01 <- glm(Species~Sepal.Width+Sepal.Length, data = bi_iris, family = 'binomial')
summary(glm.result01)   #다소 비정상적으로? p-value 출력

#predict함수 외에 fitted함수로 예측값 조사
pred <- fitted(glm.result01)
pred

#다항 로지스틱 회귀- 범주가 3개 이상의 값을 가진 경우
#glm 함수 대신 multinom 함수를 사용한다
library(caret)
library(nnet)

train.idx <- createDataPartition(iris$Species, p=0.7, list = F)
iris_train <- iris[train.idx,]
iris_test <- iris[-train.idx,]

multi.result <- multinom(Species~., iris_train)
# 다항 로지스틱 회귀분석
multi.pred <- predict(multi.result, iris_test)

table(multi.pred, iris_test$Species)
confusionMatrix(multi.pred, iris_test$Species)

#여성이 좋아할 만한 선물을 예측하는 예제
#연령, 직업에 따라 선물 예측 - 다항 로지스틱 회귀
#범주가 3개의 값을 가지고 있기 때문에
#범주의 값을 2개로 줄여 glm 함수를 이용하던지
#다항 로지스틱 회귀함수인 multinom을 이용
present <- read.csv('c:/Java/present.csv')
str(present)

present.idx <- createDataPartition(present$선물, p=0.7, list=F)
present_train <- present[present.idx,]
present_test <- present[-present.idx,]

present_result <- multinom(선물~., present_train)
summary(present_result)
present_pred <- predict(present_result, present_test)

table(present_pred, present_test$선물)
confusionMatrix(present_pred, present_test$선물)
