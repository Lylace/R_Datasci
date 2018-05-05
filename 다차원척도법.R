#다차원 척도법
#개체사이의 유사/비유사성을 측정하여 2/3차원 공간에
#점으로 표현하는 분석방법
#개체간의 근접성을 시각화하여 데이터 속에 잠재해 있는
#패턴이나 구조를 찾아내는 통계기법
#개체 간의 거리계산은 유클리드 거리 행렬을 이용

#계량적 다차원 척도법
#데이터가 연속형 변수인 경우 사용하는 분석방법
library(MASS)
data("eurodist")  #유럽 21개ㅐ 도시 간의 거리를 측정한 데이터
eurodist

#각 도시 정보를 2차원으로 정리
citydist <- cmdscale(eurodist)
citydist

#도시 정보를 x, y로 맵핑
x <- citydist[,1]
y <- -citydist[,2]

#지도에 도시정보 출력
plot(x,y,type = 'n')
text(x,y,rownames(citydist),cex = 0.8,col='red')
abline(v=0,h=0,lty=2,lwd=1.2)

#자동차에 대한 선호도 조사를 다차원척도법으로 분석
#5대의 차종에 대한 호감도를 1-9로 평가
set.seed(as.double(Sys.time()))
qmatrix <- matrix(sample(c(1:9),25,replace = T),
                  nrow = 5,ncol = 5)
#설문조사내용을 난수로 만들어 행렬에 저장
car_names = c('모닝', '아반떼', '소나타','아슬란','그랜져')
colnames(qmatrix) <- car_names
rownames(qmatrix) <- car_names
#행렬에 행제목과 열제목 작성

qm <-dist(qmatrix)
qm <-cmdscale(qm)

plot(qm,type = 'p')
abline(h=0,v=0,col = c('red','blue'))
text(qm,c(rownames(qmatrix)))

#
qmatrix <- matrix(rnorm(100),nrow = 5)
q <- dist(qmatrix)
q <- cmdscale(q)


plot(q,type='p')
abline(h=0,v=0,col = c('red','blue'))

#유사부류 찾기 - 거리개념 이용(유클리드 거리행렬)
#학업집중도에 따라 학생 반편성 해보기
academy <- read.csv('c:/Java/academy.csv')
str(academy)
head(academy)
aca <- dist(academy)   #유클리드 거리행렬 계산
aca_xy <- cmdscale(aca)  #2차원 좌표형식으로 전환
plot(aca_xy, type = 'n')
abline(h=mean(aca_xy[,2]),v=mean(aca_xy[,1]),col=c('red','blue'))
text(aca_xy, as.character(1:52))
#국 영 수 과 학업 집중도 유사성


#고객들이 선호하는 음식메뉴 유사성 알아보기
food <- read.csv('c:/Java/food.csv')
str(food)
head(food)
f <- dist(food)
f_xy <- cmdscale(f)
plot(f_xy,type = 'n')
abline(h=mean(f_xy[,2]),v=mean(f_xy[,1]),col=c('red','blue'))
text(f_xy, rownames(food))
#18번 고객이 선택한 추어탕, 갈비탕 간의 거리 :0
#2번 고객이 선택한 추어탕, 갈비탕 간의 거리 :0
#즉, 추어탕, 갈비탕을 선택한 고객과
#추어탕, 갈비탕을 선택한 고객이 같은 결과값을 가짐:
#중요도가 없음 - 서로 구분지어 줘야 할 필요 존재

#
food2 <- food[-1] #1열 제외
food2 <- t(as.matrix(food2)) %*% as.matrix(food2) #기존 데이터를 행렬로 전환
        #t() : 기존 데이터를 행렬로 전환
        #거리계산이 제대로 되도록 자기 자신을 한번 더 곱함
f2
f2 <- dist(food2)
f2_xy <- cmdscale(f2)
plot(f2_xy, type='n')
abline(h=mean(f2_xy[,2]),v=mean(f2_xy[,1]),col=c('red','blue'))
text(f2_xy, rownames(food2))


rm(food2)
food2a <- t(as.matrix(food2)) %*% as.matrix(food2)
food2b <- t(as.matrix(food2))
head(food2a)
head(food2b)
