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
# we will need date & time for this plot
#
sub_data$time_stamp <- as.POSIXct(paste(sub_data$Date, sub_data$Time), format="%Y-%m-%d %H:%M:%S")
#
# set up output device
#
png("plot2.png")  ## 480 width and 480 height are default
#
# generate plot
#
with(sub_data, plot(time_stamp, Global_active_power, type = "n",
                    xlab = "",
                    ylab ="Global Active Power (kilowatts)"))
with(sub_data, lines(time_stamp, Global_active_power, type="l")) 
#
# close output device
#
dev.off()
