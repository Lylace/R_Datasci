#간단한 실행 테스트
#주석 삽입은 ctrl + shift + c
#한 줄 실행은 ctrl + enter
print('Hello, R!!')
print('안녕, R3!!')

#여러줄에 걸쳐 입력하기 shift + enter
print(
  "Hello, R3!!"
)

#sample R script
#나이와 몸무게의 상관관계 파악
age <- c(1,3,5,2,11,9,3,9,12,3)
# a = c(1,3,5,2,11,9,3,9,12,3)   : 같은 의미
#벡터형식을 이용해 데이터를 정의하고 변수 age에 대입
weight <- c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)

age
weight  #입력된 값 확인

mean(weight)  #산술평균
sd(weight)    #표준편차(평균에서 얼마나 떨어져 있나?)
cor(age, weight)
#상관계수
#두 사건 간의 연관성(관계) 조사 : 두 변수 간의 선형적 관계 파악
#예) GDP와 기대수명, 키와 몸무게 간 관계

plot(age, weight)    #그래프 작성

#간단한 그래프 데모
demo() #데모 가능 목록 출력
demo('graphics')   #그래프 데모 시연

#도움말 함수
help.start()

#https://homepage.usask.ca/~chl948/doc/manual/R-intro-ko.html

help('q')  #q()에 대한 도움말 출력
?q         #도움말 출력2

q()  #R 종료

help.search('q')    #특정 단어를 포함하는 도움말 검색
RSiteSearch('q')    #온라인 상에서 도움말 검색
apropos('q', mode='function') #특정 단어가 포함된 함수를 찾아줌

data() #현재 설치된 패키지 상의 이용가능한 모든 자료집합을 나열
vignette()  #이용가능한 모든 소품문을 나열 (패키지에 대한 장문 안내서)

#작업공간 관련 함수
getwd()       #현재 작업 디렉토리 출력
# setwd("c:/java")    #새로운 작업 디렉토리를 설정

ls()    #현재 작업공간의 모든 객체를 출력
rm()    #하나 이상의 객체를 제거
rm(a)
rm(age)
rm(weight)
ls()

options()     #현재 작업공간에 사용가능한 설정에 대한 정보 제공
history()     #명령어 목록 출력
history(5)    #끝에서 n개의 명령어 출력
savehistory('c:/java/.Rhistory')     #명령어 히스토리를 저장(.Rhistory)
loadhistory('c:/java/.Rhistory')     #명령어 히스토리를 불러서 메모리에 적재

save(age, file='c:/java/age.data')    #특정객체를 파일에 저장
load('c:/java/age.data')              #파일을 작업공간으로 읽어들임

setwd('c:/java')
dir.create('xyz') #특정 디렉토리 생성

#sample R script 2
setwd('c:/java/xyz')
options('digits')   #소수점 출력 자리 수  (기본=7)
options(digits = 3)
options('digits')

x <- runif(20)      #20개의 임의의 난수 생성
x
summary(x)       #기본적인 통계 정보 출력
                 #최대/최소, 평균, 중간값median, 최빈값mode
                 #하한 사분위 값(데이터의 25%가 이 값보다 작거나 같음)
                 #상한 사분위 값(데이터의 75%가 이 값보다 크거나 같음)
hist(x)                 #히스토그램(막대그래프) 출력

#패키지 - 일정 규칙에 따라 누구나 제작하고 
#배포가능하다는 장점 때문에 R에는 수천가지의 다양한 패키지 제공
.libPaths()          #패키지 설치정보 확인

installed.packages()    #설치되어 있는 패키지 확인

library(help='datasets')       #특정 패키지에 대한 정보 확인

#datasets 패키지의 HairEyeColor 자료를 사용하려면?
library('datasets')           #특정 패키지를 메모리에 로드
HairEyeColor

install.packages('패키지명')    #특정 패키지를 설치
install.packages('rJava')

update.packages()      #패키지 업데이트 하기

remove.packages('패키지명')    #특정 패키지를 제거
remove.packages('rJava')

#패키지 설치는 단 한 번만 실행 라이브러리 적재는 매번 실행 해야함

#한편, 특정 함수를 실행할 때, library 명령 없이 실행 가능한 함수들이 있음
#base system 패키지


#도움말을 열어 'introduction R'을 열어보자
help.start()
#vcd 패키지를 설치하라
install.packages('vcd')
#이 패키지에서 이용가능한 함수와 데이터집합을 살펴보라
library(help='vcd')
#이 패키지를 적재하고 Arthritis 데이터집합을 살펴보라
library('vcd')
help('Arthritis')
#Arthritis 데이터집합을 출력하라
Arthritis
#Arthritis 예제를 실행하라
example('Arthritis')
plot(example('Arthritis'))
