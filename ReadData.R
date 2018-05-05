#데이터를 외부로부터 가져오는 방법
#1. 키보드로 입력 - edit(), fix()
#작은 데이터 집합을 사용해야 하는 경우 유용

smalldata <- data.frame( age=numeric(0), weight=numeric(0.0))
smalldata <- edit(smalldata)
smalldata

#R의 데이터 타입 : numeric, character, logical, complex(복소수)
manager <- data.frame( Manager=numeric(), Date=character(),Country=character(),
                       Gender=character(), Age=numeric(), q1=numeric(),q2=numeric(),
                       q3=numeric(),q4=numeric(),q5=numeric())
manager <- edit(manager)
manager

#텍스트 형태로 입력 - read.table() 함수를 사용
txtdata <- '
age weight
1 0.7
2 1.3
3 2.1
'
txtdata

smalldata <- read.table(header = T, text = txtdata)
smalldata

#예제
Table4.1_t <-'
Manager Date Country Gender Age q1 q2 q3 q4 q5
1 10/24/14 US M 32 5 4 5 5 5
2 10/28/14 US F 45 3 5 2 5 5
3 10/01/14 UK F 25 3 5 5 5 2
4 10/12/14 UK M 39 3 3 4 "" ""
5 05/01/14 UK F 99 2 2 1 2 1
'
Table4.1 <- read.table(header = T, text = Table4.1_t)
Table4.1

#구분된 텍스트 파일에서 데이터 읽어오기
#read.table(파일명, 옵션)

sales <- read.table('c:/Java/sales.txt',sep = ',',header = T)

sales <- read.table('c:/Java/sales.txt',sep = ',',header = T,
                    colClasses = (c('character','numeric','numeric')))
#파일로 읽어들이는 데이터의 자료유형 설정 - colClasses
str(sales)
sales

?read.table

#Students
std <- read.table('c:/Java/students.txt',sep='\t',header=T)
str(std)
std
#Stations
stat = read.table('c:/Java/stations.csv', sep=',',header = F)
str(stat)
stat
#SummerMedalists - csv파일 중 table로 읽으면 오류 날 때 가 있음
medalists <- read.csv2('c:/Java/medalists.csv', sep=',',header=T)
str(medalists)

#csv파일 읽기

stat = read.csv('c:/Java/stations.csv',header = F, na.strings = "")
stat

#엑셀로 데이터 읽어오기
install.packages('readxl')
library(readxl)
medal <- read_excel('c:/Java/SummerMedallists.xlsx',sheet = 1)
str(medal)


#또 다른 패키지(xlsx)
Sys.setenv(JAVA_HOME = 'C:/Java/jdk1.8.0_152')
install.packages('rJava')
install.packages('xlsx')
library('xlsx')
medal <- read.xlsx('c:/Java/SummerMedallists.xlsx', sheetIndex = 1)
str(medal)


#html, xml 파일 읽어 오기
install.packages('XML')
library('XML')
library('methods')
xmldata <- xmlParse('c:/Java/emp.xml')
empdata <- xmlToDataFrame('c:/Java/emp.xml')
str(empdata)
empdata

#JSON 형식으로 데이터 읽기
install.packages('jsonlite')
library('jsonlite')
install.packages('httr')
library('httr')

# jsondata <- fromJSON('c:/Java/primer-dataset.json')
jsondata <- fromJSON('https://api.github.com/users/hadley/repos')
str(jsondata)
names(jsondata)     #JSON 데이터의 키를 출력

#대용량 파일 읽어오기
zip1 <- read.table('c:/Java/서울특별시-2017.10.csv', sep = ',', stringsAsFactors = F, header = T, fill=T)
#fill = T 오류 없이 입력 되는데 다 넣어지지 않음
zip2 <- read.csv2('c:/Java/서울특별시-2017.10.csv', sep = ',', stringsAsFactors = F, header = T)
str(zip1)
str(zip2)

install.packages('data.table')
library(data.table)

?fread
zip3 <- fread('c:/Java/서울특별시-2017.10.csv',sep = ',',header = T,stringsAsFactors = F)
str(zip3)

#관계형 데이터베이스
#R에서는 RDBMS에서 데이터를 읽어올 수 있는 다양한 환경 지원
#R <- MySQL
install.packages('RMySQL')
library('RMySQL')

mysqlconn <- dbConnect(MySQL(), user ='lylace', password = 'Abcdef_12',
                       dbname='lylace', host='192.168.136.128')

str(mysqlconn)

dbListTables(mysqlconn)     #테이블목록 출력

empdata <- dbSendQuery(mysqlconn, 'select * from employees')
emp <- fetch(empdata)
# emp <- dbGetQuery(mysqlconn, 'select * from employees')
str(emp)

dbWriteTable(mysqlconn, '테이블명', 객체명, overwrite=T)

dbDisconnect(mysqlconn)

#R <- Oracle
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_152')
install.packages('DBI',dep=T)
install.packages('RJDBC',dep=T)
library(DBI)
library(RJDBC)
library(rJava)

drv <- JDBC('oracle.jdbc.OracleDriver',classPath = 'D:\\빅데이터\\Java\\JDBC\\ojdbc7.jar')
oraconn <- dbConnect(drv,'jdbc:oracle:thin:@192.168.136.128:1521/xe','hr','hr')

emp <- dbGetQuery(oraconn, 'select * from EMPLOYEES')

dbDisconnect(oraconn)

str(emp)
