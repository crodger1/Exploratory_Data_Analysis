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


# install.packages("lubridate")
library(lubridate)
df$Date<-dmy(df$Date)

df2<-subset(df,df$Date %in% c(ymd("2007-02-01"),ymd("2007-02-02")) )
dim(df)
dim(df2)
head(df2)
tail(df2)


df2$datetime<-paste(df2$Date,df2$Time)
head(df2$datetime)
class(df2$datetime)
df2$datetime2<-strptime(df2$datetime,"%F %T")
class(df2$datetime2)


## data have been subset, now work on the graphs

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

