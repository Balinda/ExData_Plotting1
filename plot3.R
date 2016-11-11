#
library(lubridate)
setwd("~/Coursera/Data Science/Course 4 - Exploratory Data Analysis/Week 1/Project")
#
data <-read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#
# dates read in as factors; need to convert to dates in order to subset
#
data$Date <- dmy(data$Date)
#
# subset data to only 1 day
#
sub_data<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
#
# we will need date & time for this plot
#
sub_data$time_stamp <- as.POSIXct(paste(sub_data$Date, sub_data$Time), format="%Y-%m-%d %H:%M:%S")
#
# set up output device
#
png("plot3.png")  ## 480 width and 480 height are default
#
# generate plot
#
with(sub_data, plot(time_stamp, Sub_metering_1, type = "n",
                    xlab = "",
                    ylab ="Energy sub metering"))
with(sub_data, lines(time_stamp, Sub_metering_1, type="l")) 
with(sub_data, lines(time_stamp, Sub_metering_2, type="l", col="red"))
with(sub_data, lines(time_stamp, Sub_metering_3, type="l", col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                   col=c("black","red","blue"), lty=c(1,1,1))
#
# close output device
#
dev.off()