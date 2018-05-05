#결측치 - NA, 999999, unknown, not answer ...
#누락된 값, 비어있는 값 - 함수 적용불가, 분석결과 왜곡
#제거 또는 대체 후 분석 실시
gender <- c('남','여','남','남','여')
score <- c(5,3,2,NA,4)
df <- data.frame(gender, score)

#결측치 확인
is.na(df)

#결측치 빈도 확인
table(is.na(df))
df[3,1] <- NA
table(is.na(df))

table(is.na(df$gender))   #성별에서 결측치 측정

#평균계산 - 결측치NA 포함 상태
mean(df$score)       #NA로 출력
sum(df$score)

#결측치 처리 - na.rm
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

#결측치 처리 - na.omit()
odf <- na.omit(df)
df
odf
mean(odf$score)
sum(odf$score)

#MASS 라이브러리의 Cars93데이터 집합에서
#결측값이 모두 몇 개 인지 확인
library(MASS)
table(is.na(Cars93))
str(Cars93)

#결측치 확인 - 관측치에 결측값이 있는지 여부 검사
#데이터 프레임의 각 행에 대해 결측치를 확인
#행에 저장된 값이 모두 결측치가 아닌 경우에만 TRUE 반환
complete.cases(Cars93)
table(complete.cases(Cars93))
Cars93[!complete.cases(Cars93),]

#is.na vs complete.cases
#is.na는 값에 대해 NA여부 확인
#complete.cases는 행에 대해 NA여부 확인

#간단한 예제
iris_na <- iris
iris_na[c(10,20,35,40,32,33),3] <- NA
iris_na[c(33,100,125),1] <- NA

iris_na
#is.na 결과는?
table(is.na(iris_na))

#complete.cases 결과는?
table(complete.cases(iris_na))

#결측값 처리
#결측값이 있는 행을 제거
#평균값 또는 임의의 값으로 대체
#R에서는 DMwR 패키지를 이용해서 중앙값으로 대체
#R에서는 DMwR 패키지의 KNN 알고리즘을 이용해서 가중평균치로 대체

#가중평균치로 대체

#임의의 값으로 대체
df
odf <- df
odf$score
odf$score[is.na(odf$score)] <- 0
odf

str(iris_na)
iris_na$Sepal.Length
iris_na$Sepal.Length[is.na(iris_na$Sepal.Length)] <- 0

#평균값
odf <- df
odf

odf$score <- ifelse(is.na(odf$score),mean(odf$score,na.rm = T),odf$score)
odf

iris_na$Sepal.Length <- ifelse(is.na(iris_na$Sepal.Length),
                               mean(iris_na$Sepal.Length, na.rm = T),
                               iris_na$Sepal.Length)

#DMwR패키지 - 중앙값 대체
iris_na[1:4]
mapply(median, iris_na[1:4], na.rm=T)
#위에서 구한 중앙값을 NA가 위치한 곳에 대체 - 불편

install.packages('DMwR')
library(DMwR)
centralImputation(iris_na[1:4])[c(10,20,35,40,32,100,125,33),]

table(is.na(iris_na))

#DMwR 패키지 - KNN알고리즘 가중평균치 대체
knnImputation(iris_na[1:4])[c(10,20,35,40,32,100,125,33),]

#이상치
#정상기준에서 벗어나면 결측 처리
#논리적 판단 : 나이가 150을 넘어서면 (이상)극단치
#              국어점수가 100을 넘어서면 극단치
#통계적 판단 : 평균으로부터 3표준편차 떨어진 값
#              사분위수에서 하단/상단 경계값을 벗어난 값
age <- c(10,23,33,999,121)
score <- c(50, 75, 88, 200, 150)
name <- c('a','b','c','d','e')
df2<- data.frame(name,age,score)
df2

#이상치 판단 - NA 대체 > 결측치 처리
df2$age <- ifelse(df2$age > 100 | df2$age < 0, NA, df2$age)
df2$score <- ifelse(df2$score > 100, NA, df2$score)
df2
mapply(median, df2[2:3],na.rm=T)
#논리적 판단에 의해 
!complete.cases(df2)
df2_na <- centralImputation(df2)[!complete.cases(df2),]
df2_na
rm(df2_na)
#NA 결측치들은 평균값으로 대체
df2 <- rbind(na.omit(df2),df2_na)
df2
#NA 결측치는 제거하고, 평균값으로 대체된 행과 합침

#KNN 알고리즘 이용해서 가중 평균치로 대체
df2_na <- knnImputation(df2)[!complete.cases(df2),]
df2_na
#데이터가 소량이라 경고 발생!

#mpg 데이터 집합에서 drv(차량종류)에 이상치가 있는지 알아보고 적절하게 수정하세요
#결측 처리 시 %in% 연산자를 사용하세요 - %in% c('f','r','4')
#drv : r(후륜구동), f(전륜구동), 4(4륜구동)
library(ggplot2)
str(mpg)
table(mpg$drv %in% c('f','r','4'))
table(mpg$drv)

mpgdrv <- mpg$drv
mpgdrv <- ifelse(mpgdrv %in% c('r'), NA, mpgdrv)

mpgdrv

mpgdrv_na <- knnImputation(mpgdrv)[!complete.cases(mpgdrv),]
mpgdrv <- rbind(na.omit(mpgdrv), mpgdrv_na)
