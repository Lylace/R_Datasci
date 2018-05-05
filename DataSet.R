#변수 - 알파벳, 숫자, _, .으로 구성
#첫 글자는 문자나 .으로 시작할 것
a <- 0
b1 <- 2
.x <- 3
.x
#3c <- 4    #잘못된 변수명
#.4 <- 5    #잘못된 변수명

#변수할당 <-(추천!), <<-, =

#변수명을 입력하면 값을 출력
a
b1
.x

#데이터집합 : 행(관측값, 레코드, 사례), 열(변수, 필드, 속성)로
#             이루어진 2차원 배열
#R에서 데이터를 생성하려면 스칼라, 벡터, 배열, 데이터프레임, 리스트등의
#다양한 자료구조를 사용
#R에서 다룰 수 있는 데이터의 유형은 숫자, 문자 논리 복소수 등이 있음

#벡터 : 숫자, 문자, 논리형 데이터들로 구성된 1차원 배열
#스칼라 : 요소가 하나만 존재하는 벡터
#벡터 안의 자료는 반드시 단일 유형이어야 함

a <- 3 #스칼라 유형
b <- 4.5
c <- a + b   #산술연산자 사용가능
d <- 'hello, world'    #문자형은 '', ""로 묶어야 함

e <- c(1,2,3,4,5,-9,-8,-7,-6)
f <- c('one','two','three','가','나','다')   #문자
g <- c(TRUE,FALSE,T,F,false,true)   #논리값 (false, true는 안됨@)
h <- c('9',8,'7')   #벡터는 단일 유형만 저장 가능
i <- c(1,'2',3)  #자동으로 형변환 일어남
j <- c(9,8,7, c(1,2,3))   #벡터를 중첩으로 저장하면? - 1차원으로 자동전환
k <- 1:10 #숫자 데이터형의 경우'시작값:끝값' 형태로 값 생성 가능
l <- seq(1, 10)  #seq(시작, 끝, 간격) 함수
m <- seq(1, 10, 2)
n <- rep(1:2, 3)  #rep(값, 반복) 함수
o <- rep(1:2, each=5)
e[3]        #[]를 이용해서 벡터/스칼라의 요소를 출력
e[-3]       #위치값이 음수라면 - 해당 요소를 제외
e[c(1,5,7)]       #지정 위치값을 벡터에 저장해서 검색
e[2:6]      #위치값을 범위로 지정 - 시작값:끝값

PatientID <- seq(1,4)
AdmDate <- c('10/15/2014', '11/01/2014', '10/21/2014', '10/28/2014')
Age <- c(25,34,28,52)
Diabetes <- c('Type1', 'Type2', 'Type1', 'Type1')
Status <- c('Poor', 'Improved', 'Excellent', 'Poor')

?seq
?rep

seq(0, 1, 0.001)
seq(0, 1, length.out = 1000)
seq(0, 1, length.out = 1001)
seq(0, 1, length.out = 1003)

length(m)

#비교 연산자 : <, >, !=, ==
ex <- c(1,3,5,7,9, NA)   #데이터에 값이 존재하지 않을 경우 NA로 설정
ans <- ex < 5
print(ans)

#산술 연산자 : +, -, *, /, %%, %/%
ex - 5
ex %% 5     #나머지 구함
ex %/% 5    #정수 나누기 (나머지 버림)

#논리 연산자 : &, |, !, &&, ||
c(T, F) & c(F, T)      #벡터의 각 원소 간 연산 처리
c(T, F) && c(F, T)     #단일 논리값을 계산 (단축식 평가 지원)

ex[1]     #벡터의 위치값은 0이 아닌 1부터 시작
is.na(ex[6])   #요소가 na인지 검사

x <- NULL      #변수를 선언 할 뿐 초기화하지 않는 경우 NULL 사용
is.null(x)
is.null(1)
is.null(NA)

#matrix : 벡터의 2차원 배열 - 동일한 유형의 원소들로 구성
#1행은 숫자, 2행은 문자 같은 구성은 불가
#matrix(벡터, nrow=숫자,ncol=숫자)

a <- matrix(c(1,2,3,4,5,6,7,8,9,10),nrow = 2)  
b <- matrix(c(1,2,3,4,5,6,7,8,9,10),ncol = 2)


c <- matrix(1:20, nrow = 5, ncol = 4)
c <- matrix(1:20, nrow = 5)                  #2개가 같음

cells <- c(1, 35, 67, 99)
rnames <- c('r1', 'r2')
cnames <- c('c1', 'c2')
d <- matrix(cells, nrow = 2, ncol = 2, byrow = F,  #byrow 행우선
            dimnames = list(rnames, cnames))


#행렬의 각 요소는 '행렬이름[행,열]'로 접근 가능
#imnames()로 행과 이름에 이름을 부여했다면 그 이름을 접근 가능
d['r1',] #1행만 출력
d[,'c2'] #2열만 출력
d[1,]
d[,2]
d[2,2]

dim(d)  #행렬의 차원을 출력
ncol(d)
nrow(d)

solve(d)   #역행렬
t(d)       #전치 행렬

# array : n차원 행렬
# array(벡터, 차원, 행렬이름)

#(2 x 3 x 4) 3차원 행렬 생성
dim1 <- c('A1','A2')
dim2 <- c('B1','B2','B3')
dim3 <- c('C1','C2','C3','C4')
z <- array(1:24, c(2,3,4),dimnames = list(dim1,dim2,dim3))

z[1,1,1]
z[1,2,3]
z[,,3]
dim(z)

#데이터 프레임 dataframe : 열마다 서로 다른 유형을 가질 수 있는 자료구조
#다양한 변수, 관측치, 범주(팩터)를 표현하기 위한 자료구조
#data, frame(열1,열2,열3)

x <- c(1,2,3,4,5)
y <- c('a','b','c','d','e')
z <- c(T,F,T,T,T)
s <- data.frame(x,y,z)
str(s)                #작업공간에 생성된 객체의 구조 확인
s$x                 #'데이터프레임이름$열이름' 형식으로 접근 가능
s[1,]               #컬럼의 차원이 1이 되면 벡터 값으로 자동 변환
s[,c('x','y')]      
s[,c('x')]
s[,c('x'),drop=F]   #자동으로 벡터로 변하는 것을 방지 하려면 drop=F 사용

x <- data.frame(x=1:1000)
head(x)   #데이터의 앞부분을 살펴봄
tail(x)   #데이터의 뒷부분을 살펴봄

t1Age <- c(1,3,5,2,11,9,3,9,12,3)
t1Weight <- c(4.4,5.3,7.2,5.2,8.5,7.3,6,10.4,10.2,6.1)
Table1.1 <- data.frame(t1Age,t1Weight)
Table2.1 <- data.frame(PatientID,AdmDate,Age,Diabetes,Status)

Table1.1
Table2.1
str(Table2.1) #데이터 객체의 구조를 출력
Table2.1[1:2] # 1, 2 속성 출력
Table2.1[c('Diabetes','Status')]   #속성명으로 출력
Table2.1$Age     #객체명에 $를 사용해서 속성명을 다룰 수 있음
#위 사례처럼 모든 변수 앞에 patientdata$를 사용해서
#특정 속성을 출력하는 것은 불편
#attach(), detach(), with() 사용해서 해결 가능

#attach : 특정 테이터프레임 명을 검색경로에 추가
#detach : 특정 데이터프레임 명을 검색경로에서 제거

attach(Table2.1)
  PatientID
  Age
  Diabetes
  Status
detach(Table2.1)
  
#with(객체명, {속성명})
with(Table2.1, { Age })
with(Table2.1, {
  print(Age)
  print(Status)
})

#list - 하나의 이름 아래 다양한 객체를 모아놓은 것
#키, 값 형태로 데이터를 담아 두는 연관 배열의 일종
#list(이름1=객체1, 이름2=객체2, 이름3=객체3, ...)

sj1 <- list(name='혜교', kor=99, eng=98, mat=87)
#단일 값으로 list를 구성
sj1
sj1[1]
sj1['name']
sj1[[1]]
sj1[['name']]

sja1 <- list(name='혜교', kem=c(99,98,87))
#벡터를 list의 원소로 구성
sja1
#혜교의 영어점수 출력
sja1[[2]][2]       #sja1[['kem']][2]


mixed <- list(a=sj1, b=sja1)
#리스트 자신을 리스트의 원소로 구성
mixed
#혜교의 영어점수 출력
mixed[[2]][[2]][2]    #mixed[['b']][['kem']][2]

g <- "My first List"
h <- c(25, 26, 18, 39)
j <- matrix(1:10, nrow-5)
k <- c("one","two","three")
mylist <- list(title=g,ages=h,j,k)

mylist
mylist[[2]]
mylist[["ages"]]
mylist[2]
mylist$ages

#smaple R scripts 3
mtcars         #자동차 관련 데이터 집합
?mtcars
#mpg에 대한 기본통계정보summary 출력
summary(mtcars$mpg)
plot(mtcars$disp, mtcars$mpg)   #연료소비율과 배기량의 관계
plot(mtcars$wt, mtcars$mpg)     #연료소비율과 차량무게의 관계

#attach, detach
attach(mtcars)
  summary(mpg)
  plot(disp,mpg)
  plot(wt,mpg)
detach(mtcars)

#with
with(mtcars {
  summary(mpg)
  plot(disp,mpg)
  plot(wt,mpg)
} )

#팩터 - 벡터자료구조에 추가 정보가 더해진 것
#카테고리 자료형을 만들어 데이터에 의미를 부여하고 할 때 사용
a <- 1:3      # 1,2,3
a
factor(a, levels = c(1,3,5))    #1, 3만 카테고리에 포함
factor(a, levels = c(1,3,5), labels = c('일','삼','오'))

#설문지 답변을 factor로 정의
# 1: 매우 나쁨 2: 나쁨 3: 보통 4: 좋음 5: 매우 좋음

mgr1_s <- c(5, 4, 5, 5, 5)
levels_s <- 1:5
labels_s <- c('매우 나쁨','나쁨','보통','좋음','매우 좋음')
factor(mgr1_s, levels = levels_s, labels = labels_s)
