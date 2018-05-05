#숫자와 텍스트만으로 작성된 통계결과는 지루/따분
#그래프와 그림형태로 제시(시각적 묘사) - 열정적 반응

#그래프 그리기 함수: plot(x, y), plot(y~x)
x <- 1:10
y <- 10:1
plot(x,y) #권장
# plot(y~x) #데카르트 방식

x <- -5:5
y <- 3*x + 5
plot(x,y)

x <- 1:100
y <- sqrt(x)
plot(x,y)

x <- 1:100
y <- log(x)
plot(x,y)

plot(rnorm(15))  #산점도
hist(rnorm(15))  #히스토그램
boxplot(rnorm(15))  #상자수염

#그래프 출력방향 지정 - sink()
# bmp('c:/Java/graph.bmp')  #그래프를 bmp방식으로 저장
# jpeg('c:/Java/graph.jpg')
# png('c:/Java/graph.png')
pdf('c:/Java/graph.pdf')    #한글 폰트 적용 하려면 추가 설정 필요!
attach(mtcars)
  plot(wt, mpg)    #x축 중량, y축 연비 / 산점도
  abline(lm(mpg~wt))  #상관관계를 의미하는 직선 추가
  title('차량중량에 따른 연비 상관관계')
detach(mtcars)
sink()         #작성한 내용을 지정한 장치로 전달
dev.off()      #sink해제


#그래프 그리기 사례
#두 약물에 따른 환자반응
dose <- c(20,30,40,45,60)
drugA <- c(16,20,27,40,60)
drugB <- c(15,18,25,31,40)

plot(dose,drugA)
plot(dose,drugA,type = 'p')  #점, default
plot(dose,drugA,type = 'l')  #선
plot(dose,drugA,type = 'h')  #수직선
plot(dose,drugA,type = 's')  #계단식 1번 아래시작
plot(dose,drugA,type = 'S')  #계단식 1번 위에서 시작

#그래프 옵션 설정 - par()
#pch: 점 종류 (0~25)
#lty: 선 종류 (1~6)
#cex: 기호 크기 1, 1.5, 0.5
#lwd: 선 굵기 1, 1.5, 0.5
par(lty=6,pch=3,lwd=2,cex=2)
plot(dose,drugB,type = 'b')

plot(dose,drugB, type = 'b',lty=1,pch=3)

par(bg='light cyan') #그래프 배경
plot(dose, drugB, type = 'b')

#col색상, fg 그래프 테두리색
plot(dose, drugA, col='red', col.axis='blue',
     col.lab = 'green', main = '메인제목',
     col.main='purple',sub = '서브제목',
     col.sub='navy',fg='orange', type = 'b')

#그래프에서 사용가능한 색상 조회 - colors()
colors()

#하지만, 자주 사용하는, 인기잇는 색상은 따로 있음
color1 <- rainbow(10)  #무지개색
color2 <- heat.colors(10)
color3 <- topo.colors(10)
color4 <- cm.colors(10)
color5 <- gray(0:10/10)

plot(1:10,10:1,col=color1)
plot(1:10,10:1,col=color2)
plot(1:10,10:1,col=color3)
plot(1:10,10:1,col=color4)
plot(1:10,10:1,col=color5)

#iris에서 종 별로 색상을 지정해서 산점도 출력
plot(iris$Petal.Width~iris$Sepal.Width, iris,
     xlab='Sepal 길이',ylab = 'Petal 너비',main='iris 샘플링',
     col=c('red','blue','green')[iris$Species])

#원 그래프(파이그래프)
pie(rep(1:10), labels = color1, col=color1)
pie(rep(1:10), labels = color2, col=color2)
pie(rep(1:10), labels = color3, col=color3)
pie(rep(1:10), labels = color4, col=color4)
pie(rep(1:10), labels = color5, col=color5)

#글씨체 변경 - windowsFonts

windowsFonts(
  A=windowsFont('궁서체'),
  B=windowsFont('Consolas'),
  C=windowsFont('맑은 고딕')
)
#폰트 : 1 기본, 2 진하게, 3 이탤릭, 진하고 이탤릭

par(mfrow=c(1,1))  #그래프 옵션 초기화
par(font.lab=3, font.main=4, font.axis=2, family= 'C')
plot(dose, drugA, type = 'b', main = '폰트연습')

#범례 - legend(위치, 제목, 범례,...)
install.packages('Hmisc') #그래프에 작은 눈금을 그림
library(Hmisc)
minor.tick(nx=3,ny=3,tick.ratio = 0.5)

par(mfrow=c(1,1))
plot(dose, drugA, type = 'b',
     pch=15,lty=1,col='red',ylim=c(0,60),
     main='환자와 약물A,B의 관계', xlab='환자',ylab='약물반응')

lines(dose,drugB,type = 'b',pch=17,lty=2,col='blue')
#2번째 그래프 작성

abline(h=30, lwd=1.5,lty=2,col='gray') #보조선

legend('center',inset= .05,title = '',c('A','B'),
       lty = c(1,2), pch=(c(15,17)),col = c('red','blue'))
#위치는 3x3으로 나누어진 영역을 top,center,bottom,left,center,right를 조합해서 지정

#한 화면에 여러개의 그래프 배치
#mfrow=c(행,열) 행중심
#mfcol=c(행,열) 열중심

#2x2 형태의 그래프 배치
par(mfrow=c(2,2))  #2x2 화면 나눔
attach(mtcars)
plot(wt, mpg, main='차량무게 대비 연비 산점도')
plot(wt, disp, main='차량무게 대비 연비 산점도')
hist(wt, main = '차량무게 히스토그램')
boxplot(wt, main='차량무게 박스수염그래프')
detach(mtcars)

#1x2형태의 그래프 배치
#layout : 영역의 갯수는 행렬을 이용
#layout(matrix(영역번호), 너비, 높이)
#layout.show: 영역을 미리 볼 수 있음
attach(mtcars)
par(mfrow=c(3,1))
hist(wt)    #차체중량
hist(mpg)   #연비
hist(disp)  #배기량
detach(mtcars)

attach(mtcars)
layout(matrix(c(1,1,2,3),2,2,byrow = T))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)

#split.scree() : 화면 분할
#split.scree(c(행,열), 스크린번호)
attach(mtcars)
split.screen(c(2,1)) #스크린을 2행 1열로 나눔
split.screen(scree=2,c(1,2))  # 2행 1열 스크린을 1행 2열로 나눔
screen(1)   #1,1
hist(wt)
screen(3)   #2,1
hist(mpg)
screen(4)   #2,2
hist(disp)
detach(mtcars)
close.screen(all=T)