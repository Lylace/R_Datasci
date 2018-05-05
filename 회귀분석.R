#회귀분석
#상관분석은 변수들이 서로 얼마나 밀접한 관계를 가지고 있는지
#분석하는 통계적 기법

#한편, 회귀분석은 상관분석 + 예측하는 통계적 기법
#회귀분석 시 변수는 1개 이상이 될 수 있음
#각각의 변수들을 독립변수와 종속변수로 나누어 관계 파악

#예를 들어, 작년 여름에 온도가 30도 이상일 때
#빙과류가 하루 평균 100개 팔렸다
#올해 여름에도 온도가 30도 이상되면
#빙과류가 과연 30개 이상 팔릴까? - 회귀분석

#즉, 앞으로 발생할 일은 지난 과거에 일어난 일의 
#평균 수준으로 돌아가려는 성질이 있음

#영국 유전학자 골턴은 부모의 키와 자녀들의 키 사이의
#연관관계 조사 - 선형적 관계 있음을 파악
#후에 칼 피어슨이 이것을 수학적으로 증명함 -> 회귀분석 이론 정립

#따라서, 회귀분석은 시간에 변화하는 데이터나
#어떤 영향, 가설적 실험, 인과관계등의 모델링 등의
#통계적 예측에 사용될 수 있음

#일정한 패턴을 분석해서 활용하면 무언가를 예측할 수 있다
#예를 들어, 어떤 회사가 광고를 5번 했을 때 판매량은 얼마나 될까?를
#조사 한다고 할 때 회귀분석을 이용하면 된다
#산포도에서 일정한 점들이 모여있는 패턴을 파악하고
#공식으로 도출해 낸다면 판매량을 예측할 수 있다
#공식을 도출해서 y=50+30x가 나왔다면
#x=5를 적용하면 y(판매량)은 200이 된다

#이렇게 점들이 퍼져있는 형태에서 일정한 패턴을 찾고
#이 패턴을 통해 무언가를 예측하는 것이 회귀분석이다

#회귀분석에는 선형회귀분석과, 로지스틱 회귀분석이 있음

#종속변수에 영향을 주는 변수가 1개 - 단일회귀 1차방정식
#변수가 2개 이상 - 다중회귀 2차방정식
#확률 계산 - 로지스틱 회귀

#부모와 자식의 IQ관계 파악
#부모의 IQ가 117이라면 자식의 IQ는 얼마일까?
#부모: 110,120,130,140,150
#자식: 100,105,128,115,142

p <- c(110,120,130,140,150)
c <- c(100,105,128,115,142)

plot(p,c, pch=20,col='red')

pc_iq <- lm(c~p) #y = -4.20 + 0.94x 

abline(pc_iq,col = 'blue')

#회귀모형 검증 및 적합도 파악
#lm() 함수로 구한 회귀식이 통계적으로 유의 여부
#어느정도 설명 가능한지 여부 확인
summary(pc_iq)

# Call:
#   lm(formula = c ~ p)
# 
# Residuals:
#   1     2     3     4     5 
# 0.8  -3.6  10.0 -12.4   5.2 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)  
# (Intercept)  -4.2000    40.9644  -0.103   0.9248  
# p             0.9400     0.3133   3.001   0.0576 .
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 9.906 on 3 degrees of freedom
# Multiple R-squared:  0.7501,	Adjusted R-squared:  0.6668 
# F-statistic: 9.004 on 1 and 3 DF,  p-value: 0.05764

#F통계량
#p-value : 0.05764 통계적으로 의미 없음
#R제곱 : Adjused R-squared: 0.6668 (약 67%)
#       통계 설명 가능 - 예측값을 믿을 수 있는 정도
#

coef(pc_iq)
predict(pc_iq, data.frame(c(117,117,117,117,117))) #예측값 계산

#자동차 주행속도와 제동거리 간의 관계 파악
str(cars)

#주행속도와 제동 거리 간 회귀식은?
lm(cars$dist~cars$speed)  #y = 

distsp <- lm(cars$dist~cars$speed)
abline(distsp, col='blue')

#속도가 100km일 때 제동거리 예측
-17.579 + 3.932 * 100

-17.579 + 3.932 * 10

summary(distsp)
# Call:
#   lm(formula = cars$dist ~ cars$speed)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -29.069  -9.525  -2.272   9.215  43.201 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
#   cars$speed    3.9324     0.4155   9.464 1.49e-12 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 15.38 on 48 degrees of freedom
# Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
# F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

#p-value: 1.49e-12   (0.05)유의 범위 5% 내  - 통계 유의미
#Adjusted R-squared:  0.6438    64% 정도 신뢰 가능성 존재
#speed    3.9324     0.4155   9.464   1.49e-12 ***


#놀이동산 만족도 여부 회귀분석
tp <- read.csv('c:/Java/놀이동산에 대한 만족도.csv')

#놀이기구rides와 전체만족도overall 사이 회귀분석
tp_or <- lm(tp$overall~tp$rides)
plot(tp$overall~tp$rides)
abline(tp_or, col='blue')
tp_or  #y= -94.962 + 1.703x


#회귀모형 검증 및 적합도 확인
summary(tp_or)
Call:
  lm(formula = tp$overall ~ tp$rides)

Coefficients:
  (Intercept)     tp$rides  
-94.962        1.703  

abline(tp_or, col='blue')
#회귀모형 검증 및 적합도 확인
summary(tp_or)
# Call:
#   lm(formula = tp$overall ~ tp$rides)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -33.597 -10.048   0.425   8.694  34.699 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -94.9622     9.0790  -10.46   <2e-16 ***
#   tp$rides      1.7033     0.1055   16.14   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 12.88 on 498 degrees of freedom
# Multiple R-squared:  0.3434,	Adjusted R-squared:  0.3421 
# F-statistic: 260.4 on 1 and 498 DF,  p-value: < 2.2e-16

#F검증
#rides      1.7033     0.1055   16.14   <2e-16 ***
#rides값은 유의수준 5%보다 작음 : 회귀식이 유의미
#즉, rides값이 증가하면 overall도 증가함
#p값 p-value: < 2.2e-16 (통계가 유의미)
#R제곱 Adjusted R-squared:  0.3421 (설명력 34%)


#다항선형 회귀분석
#단순선형 회귀분석에 비해 변수가 2개 이상 증가
#놀이기구에 대한 전체만족도를 분석에서
#놀이기구+게임+청결도와 전체만족도 관계 분석
lm_tp <- lm(tp$overall~tp$rides+tp$games+tp$clean)
lm_tp #회귀식 : -131.6788 +0.5780a + 0.2603b + 1.2838c  

summary(lm_tp)
# Call:
#   lm(formula = tp$overall ~ tp$rides + tp$games + tp$clean)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -31.628  -8.820   0.387   8.488  35.261 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -131.67877    9.38425 -14.032  < 2e-16 ***
#   tp$rides       0.57798    0.15991   3.614 0.000332 ***
#   tp$games       0.26028    0.07709   3.376 0.000793 ***
#   tp$clean       1.28381    0.17764   7.227 1.88e-12 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 11.93 on 496 degrees of freedom
# Multiple R-squared:  0.4392,	Adjusted R-squared:  0.4358 
# F-statistic: 129.5 on 3 and 496 DF,  

#p값 p-value: < 2.2e-16
#r제곱 Adjusted R-squared:  0.4358

#로지스틱 회귀분석
#선형 회귀분석에서는 특정 독립변수를 입력하면
#회귀식을 통해 수치값으로 결과를 얻게 됨
#따라서, 소득, 시험성적, 연간소득을 알려면
#선형회귀분석 사용

#하지만, 내가 예측하고자하는 것이 수치적으로 나타내기
#어려운 것인 경우 로지스틱 회귀분석을 이용
#예를 들어, 고객의 부도 발생 여부,
#조난된 배에서 살아남을지 여부, 어떤 학생의 최종학력 등

#회귀분석이므로 기본적으로 지도 학습에 속하고
#(기계학습 가능) 다양한 분야에서 분류 및 예측을 위한
#기법으로 사용

#단, 선형회귀 분석과 달리 결과변수가 범주형 데이터인
#경우 사용되는 기법임을 명심하자

#다음 시험점수와 순위로 해당 학교에 입학 가능여부 확인
#입학여부, gre(고등학교졸업점수), gpa(내신성적), 학교등급
#admit
univ <- read.csv('c:/Java/대학입학성적.csv')
str(univ)
glm()

#rank는 이산형 데이터이므로 범주형 변수로 변환
range(univ$rank)  # 1~4
univ$rank <- as.factor(univ$rank)

#회귀식 분석
glm_univ <- glm(univ$admit~univ$gre+univ$gpa+univ$rank,
                family = 'binomial')
glm_univ
