#선형그래프 - plot
#시간 별 추세를 표시하는데 적합
apple <- c(30,90,120,160,230)
plot(apple, type = 'o', col='red', axes=F,ann=F,ylim = c(0,250))
axis(1, at=1:5, lab=c('월','화','수','목','금'))
axis(2)
title(main='요일별 사과 섭취량', col.main='purple',font.main=4)
title(xlab='요일',col.lab='black')
title(ylab='섭취량',col.lab='blue')

#막대 그래프 - barplot
#여러가지 통계나 사물의 양을 막대 모양의 길이로
#나타내어 알아보기 쉽도록 그린 그래프
#수량의 많고 적음이나 늘고 줄어드는 양, 크고 작음을
#비교하거나 변화 상황의 일, 월, 연 별 통계 등에
#많이 이용 - 자료를 쉽게 비교
peach <- c(20,45,50,30,25)
berry <- c(10,15,15,10,5)

fruits <- data.frame(apple,peach,berry)

barplot(as.matrix(fruits), main = '과일 섭취량', ylab='섭취량', xlab='과일', col=rainbow(5),
        beside=T,ylim=c(0,250))

#히스토그램 -
#각 데이터의 구간을 대표하는 대표값을 기준으로 나타낸 분포표를 그래프로 나타낸 것
#연속 적인 데이터의 분포를 주로 표현하는데 사용
score <- c(0,1,2,3,4,4,5,8,12,11,0)
hist(score,main = '성적 히스토그램', breaks=10)

#원그래프 - pie
#전체를 기준으로 한 부분의 상대적 크기를 표시
#전체에 대한 부분의 비율을 쉽게 알 수 있게 해줌
#각 항목의 합 100%가 되어야 한다

slices <- c(10,12,4,16,8)
lbls <- c('미국','영국','호주','독일','프랑스')
pie(slices,lbls,main = '국가별 주류 소비량',col=rainbow(5))

#상자수염 그래프 - boxplot
#중앙값, 평균, 사분위수 등과 같은 주요 통계 측정치를 시각화
#변수의 주요 통계 속성을 검사하는 데 유용한
#시각적 보조 도구를 제공
boxplot(apple, peach, berry,
        col = c('red','yellow','green'),
        names=c('사과','복숭아','딸기'))

boxplot(apple, peach, berry,
        col = c('red','yellow','green'),
        names=c('사과','복숭아','딸기'),
        horizontal=T)    #상자수염그래프를 수평으로 표시

boxplot(iris$Sepal.Width,iris$Petal.Width,
        col = rainbow(2),
        names = c('꽃받침 너비','꽃잎 너비'))
