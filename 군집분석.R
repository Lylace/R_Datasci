#군집분석
#다중척도법을 계량한 분석방법

#각 개체의 유사성을 측정하여 유사성이 높은 대상집단을
#분류하고 군집에 속한 유사성과 서로 다른 군집에 속한
#개체 간의 상이성을 규명하는 분석방법

#개별군집의 특성은 각 군집에 속한 구성원들의 평균값으로 나타낼 수 있고,
#이것은 다른 군집 간의 이질성을 구분하는데 사용할 수도 있음

#군집 분석의 유사성은 거리척도/상관계수를 이용
#즉, 거리는 값이 작을수록 서로 유사한 것으로 인식
#상관계수는 클수록 유사한 것으로 인식

#가장 가까운 데이터들 끼리 먼저 연결하여 트리형태로 표시
#이러한 트리를 덴드로그램이라 함

academy <- read.csv('c:/Java/academy.csv')
head(academy)

library(cluster)
#dist(academy, method='')
#euclidean,maximum,manhattan,canberra,binary,minkowski

aca_dist <- dist(academy)^2
hcl1 <- hclust(aca_dist, method = 'single')  #최단거리
plot(hcl1, hang=-1, xlab='학생',ylab='거리')

hcl2 <- hclust(aca_dist, method = 'complete')  #최장거리
plot(hcl2, hang=-1, xlab='학생',ylab='거리')

hcl3 <- hclust(aca_dist, method = 'average')  #평균거리
plot(hcl3, hang=-1, xlab='학생',ylab='거리')

#비계층적 군집방법: k-means 군집
kms4 <- kmeans(academy, 4);kms4   #4개 군집

kms5 <- kmeans(academy, 5);kms5   #4개 군집

kms6 <- kmeans(academy, 6);kms4   #4개 군집

#Cluster means: 각 군집의 중심점(평균값)
#Clustering vector: 각 요소의 군집 분류번호

#군집화된 결과를 그래프로 표시
plot(academy, col=kms4$cluster)
plot(academy, col=kms5$cluster)
plot(academy, col=kms6$cluster)
