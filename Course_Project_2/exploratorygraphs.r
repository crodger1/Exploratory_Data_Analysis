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
    png("plot4.png",width=480,height=480)
    qplot(data=ussum,year,Emissions,geom="line",
          xlab="Year",
          ylab="Total Emissions (Tons)",
          main="Total Emissions Across the United States")
    dev.off()



# 5) How have emissions from motor vehicle sources changed from 1999-2008 in 
#    Baltimore City?

  ## restrict merged data to Balitmore only
    baltmerge <- merged[ which(merged$fips == "24510"), ]

  ## extract vehicle data using EI.Sector information
    vehicle<-baltmerge[ grep("Vehicle", baltmerge$EI.Sector), ]

  ## aggregate to national level by year
    vehiclesum <- aggregate(Emissions ~ year, vehicle, sum)

  ## create plot as png for upload
    png("plot5.png",width=480,height=480)
    qplot(data=vehiclesum,year,Emissions,geom="line",
          xlab="Year",
          ylab="Total Vehicle Emissions (Tons)",
          main="Total Vehicle Emissions in Baltimore City")
    dev.off()



# 6) Compare emissions from motor vehicle sources in Baltimore City with emissions
#    from motor vehicle sources in Los Angeles County, California (fips == 
#    "06037"). Which city has seen greater changes over time in motor vehicle
#    emissions?

  ## extract baltimore and la data from merged SCC and NEI dataset
    balt_la <- merged[ which(merged$fips %in% c("24510","06037") ), ]
    table(balt_la$fips)

  ## extract vehicle data using EI.Sector information
    vehicle<-balt_la[ grep("Vehicle", balt_la$EI.Sector), ]
  
  ## aggregate to national level by year
    vehiclesum <- aggregate(Emissions ~ year + fips, vehicle, sum)

  ## create output as panels for easy comparison
  ## add names for the counties to make data easier to understand
  attach(vehiclesum)
    vehiclesum$County_Name[fips=="24510"] <- "Baltimore City"
    vehiclesum$County_Name[fips=="06037"] <- "Los Angeles County"
  detach(vehiclesum)

  png("plot6.png",width=580,height=450)
    qplot(data=vehiclesum,year,Emissions,
          facets= . ~ County_Name,
          color=County_Name,
          geom="line",
          xlab="Year",
          ylab="Total Vehicle Emissions (Tons)",
          main="Total Vehicle Emissions in Baltimore City vs. Los Angeles County")
  dev.off()

