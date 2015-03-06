## course project 1
## chris rodger

## read in the source data file (will do version without initial subsetting first, may update later)

# setwd("C:/Users/crodger/Documents/GitHub/Exploratory_Data_Analysis/Course_Project_1/")
# setwd("C:/Users/Chris/Documents/GitHub/Exploratory_Data_Analysis/Course_Project_1/")

# df<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
#                header=TRUE,
#                sep=";",
#                stringsAsFactors=FALSE,
#                na.strings=c("?"),
#                nrows=10)

# class(df)
# names(df)
# class(df$Date)


## use sqldf package to speed up reading data (only read a subset)
# install.packages("sqldf")
library(sqldf)
power<-file("./exdata-data-household_power_consumption/household_power_consumption.txt")
powerdf<-sqldf('select * from power WHERE Date IN ("1/2/2007","2/2/2007") ',
               file.format = list(sep=";"))

# dim(powerdf)
# class(powerdf)
# names(powerdf)
# head(powerdf)
# class(powerdf$Global_active_power)
# class(powerdf$Sub_metering_1)

powerdf$datetime<-strptime(paste(powerdf$Date,powerdf$Time),"%d/%m/%Y %T")
head(powerdf$datetime)
class(powerdf$datetime)

df<-powerdf



# install.packages("lubridate")
# library(lubridate)

## convert date variable to a date format
# class(df$Date)
# df$Date<-dmy(df$Date)
# class(df$Date)


## use new date variable to get subset of data
dim(df)
dim(df2)
head(df2)
tail(df2)

df2<-df


df2$datetime<-paste(df2$Date,df2$Time)


## need time information for some of the graphs -- extract from data
df2$datetime<-paste(df2$Date,df2$Time)
head(df2$datetime)
class(df2$datetime)
df2$datetime2<-strptime(df2$datetime,"%F %T")
head(df2$datetime2)
class(df2$datetime2)


## data have been subset, now work on the graphs

## first plot
par(mfrow=c(1,1))
png("plot1.png",width=480,height=480)

hist(powerdf$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()


## second plot
par(mfrow=c(1,1))
png("plot2.png",width=480,height=480)

plot(df2$datetime2,df2$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()


plot(powerdf$datetime,powerdf$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")



## third plot
par(mfrow=c(1,1))
png("plot3.png",width=480,height=480)

plot(df2$datetime2,df2$Sub_metering_1,type="l",col="black",
     xlab="",ylab="Energy sub metering")
points(df2$datetime2,df2$Sub_metering_2,type="l",col="red")
points(df2$datetime2,df2$Sub_metering_3,type="l",col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()


## fourth plot (multiple plots)
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))

  # first plot
    plot(df2$datetime2,df2$Global_active_power,
         type="l",
         xlab="",
         ylab="Global Active Power (kilowatts)")

  # second plot -- datetime and voltage
    plot(df2$datetime2,df2$Voltage,
         type="l",
         xlab="datetime",
         ylab="")

  # third plot
    plot(df2$datetime2,df2$Sub_metering_1,type="l",col="black",
         xlab="",ylab="Energy sub metering")
    points(df2$datetime2,df2$Sub_metering_2,type="l",col="red")
    points(df2$datetime2,df2$Sub_metering_3,type="l",col="blue")
    legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

  # fourth plot
    plot(df2$datetime2,df2$Global_reactive_power,
         type="l",
         xlab="datetime",
         ylab="Global_reactive_power")

dev.off()


