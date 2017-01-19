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
png(filename = "plot4.png", width = 480, height = 480,
    units = "px", pointsize = 12, bg = "transparent")

## Create the graph
par(mfrow = c(2, 2))
plot(tbl$Global_active_power ~ tbl$Datetime, type = "l",
     ylab = "Global Active Power", xlab = "")
plot(tbl$Voltage ~ tbl$Datetime, type = "l",
     ylab = "Voltage", xlab = "datetime")
plot(tbl$Sub_metering_1 ~ tbl$Datetime, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(tbl$Sub_metering_2 ~ tbl$Datetime, col = "red")
lines(tbl$Sub_metering_3 ~ tbl$Datetime, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(tbl$Global_reactive_power ~ tbl$Datetime, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")


dev.off()