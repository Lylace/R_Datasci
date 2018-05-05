#나이브베이즈

#iris 데이터 집합을 이용해서 베이즈 정리로 분류 분석
#데이터를 학습/평가 데이터로 분리
install.packages('e1071')
install.packages("caret")
library(caret)          #ggplot2, lattice필요
idx <- createDataPartition(iris$Species, p=0.7, list=F)
#7:3비율로 데이터를 학습/평가로 분리
train <- iris[idx,]
test <- iris[-idx,]

table(train$Species)
table(test$Species)

#베이즈 이론으로 조건부 확률 계산 후 적용
library(e1071)
naive.result<-naiveBayes(train, train$Species,laplace=1)
naive.result
naive.pred<-predict(naive.result, test, type="class")

table(naive.pred, test$Species)

confusionMatrix(naive.pred, test$Species)

#영화마케팅 문제를 베이즈 정리로 해결
#영화관객의 성향을 설문조사로 정리
#관객의 속성으로 영화 취향을 파악해보자

# 사전확률
# P(B): 20대, 여, IT, 미혼, 애인없음
# P(A): 공포 영화를 선택할 확률
# 주변확률: P(B|A)
# 조건부확률: P(A|B)

# P(B|A) = P(20대, 여, IT, 미혼, 애인없음 | 공포) =
# P(20대 | 공포) * P(여 | 공포) * P(IT | 공포)
# P(미혼 | 공포) * P(애인없음 | 공포)

movie <- read.csv('c:/Java/movie.csv', header = T)
head(movie)

m_idx <- createDataPartition(movie$장르, p=0.7, list=F)

m_train <- movie[idx,]
m_test <- movie[-idx,]

table(m_train$장르)
table(m_test$장르)

m_result <- naiveBayes(m_train , m_train$장르, laplace=1 )
m_result

m_pred <- predict(m_result, m_test, type = 'class')

table(m_pred, m_test$장르)

confusionMatrix(m_pred, m_test$장르)

nbmovie <- naiveBayes(movie[1:5], movie$장르, laplace=0)

result01 <- predict(nbmovie, movie[1:5])

sum(movie$장르 != result01)

result01


table(result01, movie$장르)
confusionMatrix(result01, movie$장르)


#사내메일 중 스팸메일 가려내기
#메일에 특정 키워드가 있는 경우 스팸으로 처리

#사전확률
#P(B): 특강이라는 단어가 포함될 확률
#P(A): 메일이 스팸일 확률
#주변 확률 : P(B|A)
#조건부 확률: P(A|B) = P(B|A)*P(A) / P(B)

spam <- read.csv('c:/Java/spam.csv')
spam <- spam[,-1]
spam

s_idx <- createDataPartition(spam$메일종류, p=0.7, list=F)

s_train <- spam[idx,]
s_test <- spam[-idx,]

table(s_train$메일종류)
table(s_test$메일종류)

s_result01 <- naiveBayes(s_train, s_train$메일종류, laplace = 1)
s_result01
s_pred01 <- predict(s_result01, s_test)


s_result <- naiveBayes(spam[,-1], spam$메일종류,laplace=1)
s_result
s_pred <- predict(s_result, spam[,-1], type="class")

table(s_pred, spam$메일종류)

confusionMatrix(s_pred, spam$메일종류)

result02 <- predict(s_result, spam[,1:12])
sum(spam$메일종류 != result02)  #비 일치 항목 수 출력
table(result02, spam$메일종류)

confusionMatrix(result02, spam$메일종류)

#입사 지원 시 조건에 따른 합격 여부 판별
#나이,장래희망유무,인터뷰태도,고교성적,합격여부

#사전확률
#P(B): 나이, 장래희망유무, 인터뷰태도, 고교성적
#P(A): 합격
#주변확률: P(B|A)
#조건부 확률:P(A|B)

#테스트 데이터: 적음, 없음, 매우좋음, 보통,???
#P(합격여부=합격): 13/20
#P(합격여부=불합격): 7/20

#P(나이=적음|합격): 4/13
#P(나이=적음|불합격): 3/7

#P(장래=없음|합격): 1/13
#P(장래=없음|불합격): 7/7

#P(인터뷰=매우좋음|합격): 3/13
#P(인터뷰=매우좋음|불합격): 1/7

#P(성적=보통|합격): 2/13
#P(성적=보통|불합격): 3/7

#P(나이=적음): 7/20 
#P(장래=없음): 7/20
#P(인터뷰=매우좋음): 4/20
#P(성적=보통): 5/20

#P(A|B) = P(합격 | 적음, 없음, 매우좋음, 보통)   =a_b =
        
#P(B|A) = P(적음, 없음, 매우좋음, 보통 | 합격)   =b_a
b_a <- (3/7) * (7/7) * (1/7) * (3/7) * (7/20)
#P(A) = P(합격) : 13/20                          =a
a <- 13/20
#P(B) = P(적음, 없음, 매우좋음, 보통)            ?





pas1 <-(4/13) * (1/13) * (3/13) * (2/13) * (13/20)  #P(B|A)*P(A) P(A)=합격일 때
pas1
npas1 <-(3/7) * (7/7) * (1/7) * (3/7) * (7/20)  #P(B|A)*P(A) P(A)=불합격일 때
npas1





pass <- read.csv('c:/Java/지원자.csv')
head(pass)


p_result <- naiveBayes(pass[,-5], pass$합격여부, laplace=1)
p_result

p_pred <- predict(p_result, pass, type = "class")

table(p_pred, pass$합격여부)

confusionMatrix(p_pred, pass$합격여부)
