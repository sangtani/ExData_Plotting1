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


## Create four spots for graphs
par(mfrow=c(2,2))

## With the data, create the four graphs
with (febPCD, {

   
   plot(febPCD$dateTime, febPCD$Global_active_power, type="l", xaxs="r", ylab="Global Active Power", xlab="")

   plot(febPCD$dateTime, febPCD$Voltage, type="l", xaxs="r", ylab="Voltage", xlab="datetime")

   plot(febPCD$dateTime,febPCD$Sub_metering_1, col="black", type="l", xaxs="r", ylab="Energy sub metering", xlab="")
      lines(febPCD$dateTime, febPCD$Sub_metering_2, col="red")
      lines(febPCD$dateTime, febPCD$Sub_metering_3, col="blue")
      legend("topright", pch = NA, lty= c(1,1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

   plot(febPCD$dateTime, febPCD$Global_reactive_power, type="l", xaxs="r", ylab="Global_reactive_power", xlab="datetime")
})

## Write PNG File
dev.copy(png,file="plot4.png", width= 480, height=480, units = "px", pointsize = 12, bg="white")

## Dev Off
dev.off()
