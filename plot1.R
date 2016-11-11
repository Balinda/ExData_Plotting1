# make sure to set your working directory to the location of the data and script files
#
library(lubridate)
#
data <-read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#
# dates read in as factors; need to convert to dates in order to subset
data$Date <- dmy(data$Date)
#
# subset data to only 1 day
sub_data<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
#
# set up output device
#
png("plot1.png")  ## 480 width and 480 height are default
#
# generate histogram
#
with(sub_data, hist(Global_active_power, 
                    col="red", 
                    main="Global Active Power",
                    xlab="Global Active Power (kilowatts)"))
#
# close output device
#
dev.off()
