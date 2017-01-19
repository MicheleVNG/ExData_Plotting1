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
png(filename = "plot2.png", width = 480, height = 480,
    units = "px", pointsize = 12, bg = "transparent")

## Create the graph
plot(tbl$Global_active_power ~ tbl$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()