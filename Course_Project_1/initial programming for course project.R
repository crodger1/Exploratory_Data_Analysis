## course project 1
## chris rodger

## read in the source data file (will do version without initial subsetting first, may update later)

setwd("C:/Users/crodger/Documents/GitHub/Exploratory_Data_Analysis/Course_Project_1/")

df<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
               header=TRUE,
               sep=";",
               stringsAsFactors=FALSE,
               na.strings=c("?"))

class(df)
names(df)
class(df$Date)


## use sqldf package to speed up reading data (only read a subset)
# install.packages("sqldf")
library(sqldf)
power<-file("./exdata-data-household_power_consumption/household_power_consumption.txt")
powerdf<-sqldf('select * from power where "Date" == "01/02/2007" ', file.format= list(sep=";"))

dim(powerdf)
class(powerdf)
names(powerdf)
head(powerdf)
class(powerdf$Date)
class(powerdf$Date)


# install.packages("lubridate")
library(lubridate)

## convert date variable to a date format
df$Date<-dmy(df$Date)

## use new date variable to get subset of data
df2<-subset(df,df$Date %in% c(ymd("2007-02-01"),ymd("2007-02-02")) )
dim(df)
dim(df2)
head(df2)
tail(df2)

## need time information for some of the graphs -- extract from data
df2$datetime<-paste(df2$Date,df2$Time)
head(df2$datetime)
class(df2$datetime)
df2$datetime2<-strptime(df2$datetime,"%F %T")
class(df2$datetime2)


## data have been subset, now work on the graphs

## first plot

png("plot1.png",width=480,height=480)

hist(df2$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")


dev.off()


## second plot

plot(df2$datetime2,df2$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

