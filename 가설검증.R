#추정
#보통 어떤 그룹(모집단)의 특징을 알고싶다 - 조사
#현실에서는 시간/비용상의 문제 때문에
#모든 구성원 대상 조사는 어려움 - 표본 이용(일부조사)

#알고자 하는 모집단의 특징을 숫자로 표현 - 모수
#표본으로 뽑은 데이터 - 통계량
#표본의 통계량으로 '모수가 이럴 것이다'라고 추리 - 추정

#추정은 일부 데이터로 전체를 추리하기 때문에
#100% 정답은 아니고 일부 오차는 존재한다
#추정에는 점추정과 구간추정이 있음

#점추정
#예를 들어 한국 성인 남자(모집단)의 평균(모수) 키를 파악
#성인 남자 1000명을 표본으로 뽑아 조사 - 172.38cm(통계량)
#이처럼 하나 값(점)으로 표현 - 점 추정

#그런데, 진짜 한국 성인남자의 평균 키가 172.38cm일까?
#당연히 그럴 확률은 희박 - 표본 수 작음, 오차 존재
#따라서, 특성상 점추정치는 신뢰하기 어려운 면이 존재

#구간추정
#이러한 점추정의 한계를 극복하기 위한 방법
#즉, 점추정치를 기준으로 일정구간을 설정
#예를 들어 점추정치가 172.38cm가 나왔다면
#여기에 +-5를 하여 일정구간(167~177cm)를 만듦
#그러면, 이 구간에 모수가 포함될 확률은 높아짐

#추정치의 신뢰도를 높이기 위해 점추정치를 중심으로 일정 구간을 만드는 것 - 구간추정

#신뢰구간
#점추정은 그 특성상 신뢰도가 떨어짐 - 구간추정으로 보완
#그러면, 구간 추정시 어느 정도 까지 구간을 설정해야 할까?
#만일, 성인 남자 평균키에 대한 구간추정을 150~190으로 잡으면? - 너무 넓다

#일단, 이러한 구간은 짧으면 좋다 - 너무 짧아도 문제
#너무 넓지도 너무 짧지도 않게 나름의 기준에
#따라 신뢰할 수 있는 구간을 설정 - 신뢰구간
#항상 신뢰구간이라고 완벽한 것은 아님
#신뢰 구간에 포함되지 않을 확률은 항상 존재 - 변수 알파
#이 확률은 구간 양 쪽에 존재 - 알파/2
#따라서 신뢰구간은 신뢰수준(1-알파)를 기반으로 설정

#단일 모집단의 모평균에 대한 신뢰구간 추정 및 검증
t.test()

#A회사의 금년도 대졸자 초임을 조사하기 위해
#15명의 표본을 SRS로 뽑아 월 임금을 조사했다
#평균 임금 x에 대한 95% 신뢰구간을 구하라
#165,159,170,168,170,172,167,158,170,171,164,165,168,167,171
sal <- c(165,159,170,168,170,172,167,158,170,171,164,165,168,167,171)
t.test(sal)

#한 공장에서 생산되는 소 단위 소금 한 봉지의 무게는
#다음과 같다 평균무게를 신뢰구간 95%, 99%로 추정하시오
#102,103,104,103,105,104,101,103,102,104,104,103,105,104,101
salt <- c(102,103,104,103,105,104,101,103,102,104,104,103,105,104,101)
salt_a <- c(102,103,104,103,105,104)
t.test(salt_a)
t.test(salt)
t.test(salt, conf.level = .99)

#단일 모집단의 모분산에 대한 신뢰구간 추정 및 검증
카이제곱검증

#단일 모집단의 모비율에 대한 신뢰구간 추정 및 검증
prop.test()

#어느 상표에 대한 선호도를 조사한 결과, 100명 중 48명이
#이 상표를 선호하는 것으로 나타났다. 95% 신뢰구간은?
prop.test(48, 100)  #기본은 95% 신뢰구간으로 추정
prop.test(48,100, conf.level = .9)   # 90% 신뢰구간 추정

#어떤 대학의 학생 1350명 중 620명이 담배 한 갑을 핀다고 한다.
#지난 주에 최소한 담배 한 갑을 핀 학생들의
#모비율에 대해 95%, 99% 신뢰구간을 추정하시오.
prop.test(620, 1350, conf.level = .99)
prop.test(620, 1350)

#가설검증
#통계적 가설검증이란?
#세상에는 수 많은 분야에 걸쳐 다양한 이론/관념이 존재
#이러한 이론/관념들은 그 자체로 정답이라기 보다는
#'이럴것이다'라는 하나의 가설에 불과
#정답이 아니고 가설이므로 항상 불완전함이 내포

#한편, 불완전함을 채우기위해 새로운 가설이 등장하기도 함
#예를 들어 과학적 지식이 없던 옛날 - 신화적 상상 우주
#중세시대 -지구를 중심으로 태양이 돈다 - 천동설
#현재 - 태양을 중심으로 지구가 돈다 - 지동설
#즉, 신화적 상상 -> 천동설 -> 지동설 순으로 생겨난 셈

#그런데 새로운 가설이 나왔더라도 현재 가설보다 
#합리적이고 신뢰적인가?
#오히려, 새로운 가설보다 이전 가설이 더 합리적일 수 도 있음
#따라서, 두 가설 중 어떤 가설이 더 신뢰성이 있고 정확한지
#판단해야 할 필요 존재 - 이 과정을 가설 검증이라 함

#통계에서는 현재 가설을 귀무가설(H0)
#새로운 가설을 대립가설(H1)이라 함
#가설 검증은 어느 가설이 더 타당한지 판단한다 - 통계 활용

#참고) 통계를 이용한 가설검증이 모든 분야의
#가설을 다 판단 할 수는 없음 -  수학 특성상 제약이 존재
#따라서, 판단의 의사결정 시 수학적 방법을 이용하는 것도 좋지만,
#수학의 틀에서 벗어나 의사결정하는 것도 좋음 - insight 직감,영감 이용
#그래서 통계적 가설검증은 수학을 활용하여 의사결정하기 좋을 경우에만 사용

#새로운 당뇨병 치료제를 만든 제약회사가
#신약의 효과를 측정하고 싶다
#치료의 차도가 외부요인때문인지 여부 확인
#10명의 당뇨병 환자를 선별해서 기존약과 신약을 투여 했을 때의
#혈당 차이를 유의 수준 5%에서 검증
#귀무가설: 신약은 치료효과가 있다 (혈당a = 혈당b)
#대립가설: 신약은 치료효과가 없다 (혈당a > 혈당b)
x1 <- c(51.4,52.0,45.5,54.5,52.3,50.9,52.7,50.3,53.8,53.1) #기존약 투여 시 혈당 변화
x2 <- c(50.1,51.5,45.9,53.1,51.8,50.3,52.0,49.9,50.5,53.0) #신약 투여 시 혈당 변화

#각 각의 평균/분산의 차 계산
t.test(x1, x2, paired = T)


#신발 밑창 원재료에 따라 소모정도가 다른가?
#20명의 아이들 중 10명은 A사의 밑창재료로 만든 신발을
#나머지 10명은 B사의 밑창재료로 만든 신발을 신었을 때
#일정기간이 지난 후 소모 정도의 차이 조사
#귀무가설 : 원재료A,B의 소모 정도는 같다
#대립가설 : 원재료A,B의 소모 정도는 다르다
x3 <- c(13.2,8.2,10.9,14.3,10.7,6.6,9.5,10.8,8.8,13.3) #원재료A 신발 소모 정도
x4 <- c(14.0,8.8,11.2,14.2,11.8,6.4,9.8,11.3,9.3,13.6) #원재료B 신발 소모 정도

t.test(x3,x4, paired = T)

# One Sample t-test
# 
# data:  salt_a
# t = 241.72, df = 5, p-value = 2.299e-11
# (t검정치), (자유도), (위험치)
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
#   102.3993 104.6007
# sample estimates:
#   mean of x 
# 103.5 (평균)

#t검정치: var()이나 sd()로 분산이나 표준편차를 계산 후

# Paired t-test
# 
# data:  x1 and x2
# t = 2.6324, df = 9, p-value = 0.02725
# (위험도(p) : 귀무가설을 기각해도 틀릴 확률)
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   0.1181548 1.5618452
# sample estimates:
#   mean of the differences 
# 0.84

#자동차 판매지역에 따라 가격이 다른가?
#A라는 자동차를 미국에서 판매할 때와
#타 지역에서 판매 때 가격차이 여부 조사
#귀무가설: 미국 내와 타 지역 자동차 판매가격은 같다
#대립가설 : 미국 내와 타 지역 자동차 판매가격은 다르다

#A회사 직장인 500명과 B회사 직장인 600명을 대상으로
#흡연율이 각 32%와 41%로 조사 됐다
#A회사의 흡연율과 B회사의 흡연율에는 차이가 존재하는가?
#유의 수준 5%이내에서 검즘
#귀무가설 : A/B회사의 흡연율은 같다
#대립가설 : A/B회사의 흡연율은 다르다

x5 <- c(0.33,0.41) #흡연률
x6 <- c(500,600)   #조사 인원 수
evnet <- x5 * x6   #흡연 발생률

prop.test(evnet,x6)

# 2-sample test for equality of proportions with continuity correction
# 
# data:  evnet out of x6
# X-squared = 7.1203, df = 1, p-value = 0.007622
# (위험도(p) : 귀무가설을 기각해도 틀릴확률)
# alternative hypothesis: two.sided
# 95 percent confidence interval:
#   -0.13881966 -0.02118034
# sample estimates:
#   prop 1 prop 2 
# 0.33   0.41 
