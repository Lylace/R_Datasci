#의사결정나무
#가게에 찾아오는 고객에게 설문지를 돌려
#간단한 인적사항이나 개인정보를 조사하면서 할인쿠폰을
#선물로 준다고 가정하자 이 때, 할인 쿠폰에 대한
#반응도를 Y/N로 구분하고 어떤 패턴을 가진 사람이 쿠폰을
#좋아하는지 관찰한다

#이러한 문제를 분류문제라 한다
#즉, 입력값의 결과가 Y/N 같이 이산형 데이터가 출력
#따라서, 이러한 값을 예측하도록 훈련시키는 것을
#감독(지도)학습이라 한다
#보통 분류문제는 보기 2/3개 중 하나를 고르는 것이다

#앞서 받은 설문지 데이터에서 고객의 특징이나 규칙을
#파악하고 싶다: 패턴 - 의사결정나무 알고리즘 이용!

#다음달에 연체할 카드가입 회원은 누구인가?
#약정 끝나면 이탈할 고객은 누구인가?
#타이타닉에서 살아남을 사람은 누구인가?
#(http://titanic-survivor.herokuapp.com)

#기계학습의 하나로 특정항목에 대한 의사결정규칙을
#이진 트리 형태로 분류해나가는 분석기법
#수치형/범주형 데이터 모두 사용 가능

#의사결정나무 분석방법에는 통계학에 기반한
#카이제곱, t검증, F검증등을 활용한
#CART, CHAID 알고리즘이나 기계학습계열(에트로피, 정보이득)인
#ID3, C4.5, C5.0등이 존재 rpart 함수는 ID3알고리즘 적용
#tree 패키지는 CART 알고리즘 적용

skin <- read.csv('c:/Java/skin.csv')
head(skin)
#설문조사 내용 중 직장이 있고, 30대인 기혼자는
#쿠폰을 사용해서 구매할 수 있도록 한다
skin <- skin[-1]
head(skin)
str(skin)  #구성데이터들은 모두 범주형

library(rpart)  #의사결정나무 생성용 패키지
tree1 <- rpart(쿠폰반응여부~., data=skin,
                     control=rpart.control(minsplit = 3))
#minsplit: 의사결정트리 가지 분화 수
plot(tree1,compress=T,uniform=T)
text(tree1,use.n=T,col = 'blue')


#CART 알고리즘을 사용하는 tree패키지 적용
install.packages("tree")
library(tree)
skin2 <- tree(쿠폰반응여부~.,data=skin)
plot(skin2)
text(skin2)

#skin의 각 변수에 대해 쿠폰반응여부를 확인
xtabs(~결혼여부+쿠폰반응여부, data=skin)
#          쿠폰반응여부
# 결혼여부 NO YES
#     NO   10  0
#    YES   8  12
chisq.test(xtabs(~결혼여부+쿠폰반응여부, data=skin))
# Pearson's Chi-squared test with Yates' continuity correction
# 
# data:  xtabs(~결혼여부 + 쿠폰반응여부, data = skin)
# X-squared = 7.6562, df = 1, p-value = 0.005658
xtabs(~성별+쿠폰반응여부, data=skin)
xtabs(~차량보유여부+쿠폰반응여부, data=skin)
xtabs(~직장여부+쿠폰반응여부, data=skin)

#의사결정나무 비율(가중치) 확인
tree1


install.packages('partykit')
#예제
