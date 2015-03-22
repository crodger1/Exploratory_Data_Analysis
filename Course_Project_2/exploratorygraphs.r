setwd("C:/Users/crodger/Documents/GitHub/Exploratory_Data_Analysis/Course_Project_2")
dir()


## read data per instructions
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
names(NEI)

head(SCC)
names(SCC)

# 1) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

## check some data details to be sure I understand format
table(NEI$Pollutant)
table(NEI$year)

## aggregate emissions data by year
yearsum <- aggregate(Emissions ~ year, NEI, sum)

## create a plot of data by year, create png for upload
png("plot1.png",width=480,height=480)
  plot(yearsum$year,yearsum$Emissions,
       type="l",
       xlab="Year",
       ylab="Total Emissions (Tons)")
  title(main="Total Emissions in Tons by Year")
dev.off()


# 2) Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#    (fips == "24510") from 1999 to 2008? Use the base plotting system to make
#    a plot answering this question.


## restrict to Balitmore City data based on FIPS
baltdata <- NEI[ which(NEI$fips == "24510"), ]
table(baltdata$fips)

## aggregate by year
baltsum <- aggregate(Emissions ~ year, baltdata, sum)

## create plot, output to a png for upload
png("plot2.png",width=480,height=480)
plot(baltsum$year , baltsum$Emissions,
     type="l",
     xlab="Year",
     ylab="Total Emissions (Tons)")
title(main="Total Emissions in Tons by Year for Balitmore City")
dev.off()



# 3) Of the four types of sources indicated by the type (point, nonpoint, 
#    onroad, nonroad) variable, which of these four sources have seen decreases
#    in emissions from 1999-2008 for Baltimore City? Which have seen increases 
#    in emissions from 1999-2008? Use the ggplot2 plotting system to make a 
#    plot answer this question.

## restrict to Baltimore City data based on FIPS
baltdata <- NEI[ which(NEI$fips == "24510"), ]

## aggregate by year and type
baltsum <- aggregate(Emissions ~ year + type, baltdata, sum)

## create plot using ggplot2 library, output to a png for upload
require(ggplot2)
library(ggplot2)

png("plot3.png",width=480,height=480)
qplot(data=baltsum,year,Emissions,color=type,geom="line",
      xlab="Year",
      ylab="Total Emissions (Tons)",
      main="Total Emissions in Baltimore City by Type")
dev.off()



# 4) Across the United States, how have emissions from coal combustion-related
#    sources changed from 1999-2008?

## merge the NEI and SCC data by SCC code to get national data
merged<-merge(NEI,SCC,by="SCC")
head(merged)

## restrict data to coal-based items using EI.Sector
coal<-merged[grep("Coal", merged$EI.Sector), ]
head(coal)

## aggregate to national level by year
ussum <- aggregate(Emissions ~ year, coal, sum)

## create plot as png for upload
png("plot3.png",width=480,height=480)
qplot(data=ussum,year,Emissions,geom="line",
      xlab="Year",
      ylab="Total Emissions (Tons)",
      main="Total Emissions Across the United States")
def.off()



# 5) How have emissions from motor vehicle sources changed from 1999-2008 in 
#    Baltimore City?

## restrict merged data to Balitmore only
baltmerge <- merged[ which(NEI$fips == "24510"), ]


merged<-merge(NEI,SCC,by="SCC")
vehicle<-[grep("Vehicle", merged$EI.Sector), ]




# 6) Compare emissions from motor vehicle sources in Baltimore City with emissions
#    from motor vehicle sources in Los Angeles County, California (fips == 
#    "06037"). Which city has seen greater changes over time in motor vehicle
#    emissions?



# 
# 
# 
# # first plot
# plot(powerdf$datetime,powerdf$Global_active_power,
#      type="l",
#      xlab="",
#      ylab="Global Active Power (kilowatts)")
# 
# # second plot -- datetime and voltage
# plot(powerdf$datetime,powerdf$Voltage,
#      type="l",
#      xlab="datetime",
#      ylab="")
# 
# # third plot
# plot(powerdf$datetime,powerdf$Sub_metering_1,type="l",col="black",
#      xlab="",ylab="Energy sub metering")
# points(powerdf$datetime,powerdf$Sub_metering_2,type="l",col="red")
# points(powerdf$datetime,powerdf$Sub_metering_3,type="l",col="blue")
# legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
#        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# 
# # fourth plot
# plot(powerdf$datetime,powerdf$Global_reactive_power,
#      type="l",
#      xlab="datetime",
#      ylab="Global_reactive_power")
# 
# dev.off()
# 
