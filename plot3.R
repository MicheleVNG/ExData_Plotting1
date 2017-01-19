library(lubridate)
library(dplyr)

## Read the data
df <- read.csv2("household_power_consumption.txt", na.strings = "?", dec = ".",
		colClasses = c("character", "character", rep("numeric", 7)))
tbl <- tbl_df(df)
tbl <- tbl %>% 
	mutate(Datetime = dmy_hms(paste(Date, Time))) %>% 
	select(-(Date:Time)) %>% 
	filter(Datetime > ymd("2007-02-01") & Datetime < ymd("2007-02-03"))

## Set up the PNG graphics device
png(filename = "plot3.png", width = 480, height = 480,
    units = "px", pointsize = 12, bg = "transparent")

## Create the graph
plot(tbl$Sub_metering_1 ~ tbl$Datetime, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(tbl$Sub_metering_2 ~ tbl$Datetime, col = "red")
lines(tbl$Sub_metering_3 ~ tbl$Datetime, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))

dev.off()