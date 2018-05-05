#KNN
#iris 자료를 분석하기 위해 KNN사용

data(iris)
head(iris, n=10) #10개 행 출력

#train, test데이터로 나눔
set.seed(as.double(Sys.time()))
idx <- sample(nrow(iris), size=nrow(iris)*0.75)
train <- iris[idx,]
test <- iris[-idx,]

#데이터 집합 갯수와 차원 확인
dim(train)         #갯수, 차원
dim(test)
table(train$Species)   #빈도
table(test$Species) 

#KNN알고리즘 적용
library(class)
knn1 <- knn(train[,-5], test[,-5], train$Species, k=1, prob = T)
# knn <- knn(train[,-5], test[,-5], train$Species, k=1, prob = F)
knn1

knn3 <- knn(train[,-5], test[,-5], train$Species, k=3, prob = T)
knn3

#예측값 평가
knn1conf <- table(knn1, test$Species)
knn1conf
knn1acc <- sum(diag(knn1conf)) / nrow(test)
knn1acc

knn3conf <- table(knn3, test$Species)
knn3conf
knn3acc <- sum(diag(knn3conf)) / nrow(test)
knn3acc

#누구와 소개팅하면 좋을까? - 결혼정보 시스템 짝 이어주기
isLike <- read.csv('c:/Java/like.csv')
isLike
q1idx <- sample(nrow(isLike), size=nrow(isLike)*0.75)
q1train <- isLike[q1idx,]
q1test <- isLike[-q1idx,]

q1train
q1test

q1knn1 <- knn(q1train[,-8], q1test[,-8], q1train$호감LABEL, k=1 , prob=T)
q1knn1

q1knn3 <- knn(q1train[,-8], q1test[,-8], q1train$호감LABEL, k=3 , prob=T)
q1knn3


q1knn1conf <- table(q1knn1, q1test$호감LABEL)
q1knn1conf
q1knn1acc <- sum(diag(q1knn1conf)) / nrow(q1test)
q1knn1acc

q1knn3conf <- table(q1knn3, q1test$호감LABEL)
q1knn3conf
q1knn3acc <- sum(diag(q1knn3conf)) / nrow(q1test)
q1knn3acc

#누가 이 상품을 구매할까? - 매장 방문고객 타겟마케팅
isBuy <- read.csv('c:/Java/buy.csv')
class(isBuy)
isBuy_s <- scale(isBuy[,-3])
isBuy_s
isBuy1 <- isBuy_s[,1:2]
isBuy1 <- as.data.frame(isBuy1)
isBuys <- isBuy[,3]
isBuys <- cbind(isBuy1,'상품구매여부'=isBuys)
isBuys

# 선생님 예제 test값 임의 만들기
# test$나이 <- (test$나이 - mean(isBuy$나이)) / sd(isBuy$나이)
# test$월수입 <- (test$월수입 - mean(isBuy$월수입)) / sd(isBuy$월수입)

q2idx <- sample(nrow(isBuys), size=nrow(isBuys)*0.75)
q2train <- isBuy[q2idx,]
q2test <- isBuy[-q2idx,]

dim(q2train)
dim(q2test)

q2knn1 <- knn(q2train[,-3],q2test[,-3], q2train$상품구매여부, k=1, prob=T)
q2knn1

q2knn3 <- knn(q2train[,-3],q2test[,-3], q2train$상품구매여부, k=3, prob=T)
q2knn3

q2knn1conf <- table(q2knn1, q2test$상품구매여부)
q2knn1conf
q2knn1acc <- sum(diag(q2knn1conf)) / nrow(q2test)
q2knn1acc

q2knn3conf <- table(q2knn3, q2test$상품구매여부)
q2knn3conf
q2knn3acc <- sum(diag(q2knn3conf)) / nrow(q2test)
q2knn3acc
