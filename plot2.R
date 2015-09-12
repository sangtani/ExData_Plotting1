## Load required library
library(data.table)

## read file
pCD <- fread("./household_power_consumption.txt")

## Subset feb data

febPCD <- pCD[as.Date(pCD$Date, "%d/%m/%Y") >= as.Date("2007-02-01","%Y-%m-%d") & as.Date(pCD$Date, "%d/%m/%Y") <= as.Date("2007-02-02","%Y-%m-%d"),]
## Clean data
febPCD[,dateTime:=paste(febPCD$Date, febPCD$Time)]
febPCD$dateTime <- as.POSIXct(febPCD$dateTime,"%d/%m/%Y %H:%M:%S", tz="")
febPCD$Global_active_power <- as.numeric(febPCD$Global_active_power)
febPCD$Global_reactive_power <- as.numeric(febPCD$Global_reactive_power)
febPCD$Voltage <- as.numeric(febPCD$Voltage)
febPCD$Global_intensity <- as.numeric(febPCD$Global_intensity)


## Plot  Global Active Power on default device (monitor)

plot(febPCD$dateTime, febPCD$Global_active_power, type="l", xaxs="r", ylab="Global Active Power (kilowatts)", xlab="")

## Write PNG file

dev.copy(png,file="plot2.png", width= 480, height=480, units = "px", pointsize = 12, bg="white")

## Dev Off
dev.off()
