## course project 1
## chris rodger

## read in the source data file (will do version without initial subsetting first, may update later)

setwd("C:/Users/crodger/Documents/GitHub/Exploratory_Data_Analysis/Course_Project_1/")

df<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
           header=TRUE,
           sep=";",
           stringsAsFactors=FALSE)

class(df)
attributes(df)
class(df$Date)

# install.packages("lubridate")
library(lubridate)
df$Date<-dmy(df$Date)

df2<-subset(df,df$Date>=ymd("2007-02-01"))
dim(df)
dim(df2)

# 
# When loading the dataset into R, please consider the following:
#   
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# 
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
# 
# Note that in this dataset missing values are coded as ?.
