# make sure to set your working directory to the location of the data and script files
#
library(lubridate)
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
# we will need date & time for these plots
#
sub_data$time_stamp <- as.POSIXct(paste(sub_data$Date, sub_data$Time), format="%Y-%m-%d %H:%M:%S")
#
# set up output device
#
png("plot4.png")  ## 480 width and 480 height are default
#
# set up 2x2 matrix
#
par(mfcol=c(2,2), mar=c(2.5,4,2.5,2.5)) ## will fill 1st column and then 2nd column
#
# generate top left plot
#
with(sub_data, plot(time_stamp, Global_active_power, type = "n",
                    xlab = "",
                    ylab ="Global Active Power (kilowatts)"))
with(sub_data, lines(time_stamp, Global_active_power, type="l")) 
#
# generate bottom left plot
#
with(sub_data, plot(time_stamp, Sub_metering_1, type = "n",
                    xlab = "",
                    ylab ="Energy sub metering"))
with(sub_data, lines(time_stamp, Sub_metering_1, type="l")) 
with(sub_data, lines(time_stamp, Sub_metering_2, type="l", col="red"))
with(sub_data, lines(time_stamp, Sub_metering_3, type="l", col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=c(1,1,1), cex=.5)  ## need to shrink legend
#
# generate top right plot
#
with(sub_data, plot(time_stamp, Voltage, type="l", xlab="datetime"))
#
# generate bottom right plot
#
with(sub_data, plot(time_stamp, Global_reactive_power, type="l", xlab="datetime"))
#
# close output device
#
dev.off()
