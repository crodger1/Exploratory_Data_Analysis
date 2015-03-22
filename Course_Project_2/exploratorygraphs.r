setwd("C:/Users/crodger/Documents/GitHub/Exploratory_Data_Analysis/Course_Project_2")
dir()


## read data per instructions
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
names(NEI)

head(SCC)
names(SCC)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

table(NEI$Pollutant)
table(NEI$year)

