## If .txt file does not exist in wd, then download and unzip .txt file
if(!file.exists("household_power_consumption.txt")){
	fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileURL, destfile="./elecDat.zip")
	epc <- unzip("elecDat.zip")
}

## Read data from .txt file into epc data.frame
epc <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")

## Create epc1 data.frame to subset dates within analysis range
epc1 <- epc[epc$Date %in% c("1/2/2007", "2/2/2007"),]

## Format date and create Timestamp in epc1 data.frame
epc1$Date <- as.Date(epc1$Date, format="%d/%m/%Y")
epc1$Timestamp <- as.POSIXct(paste(epc1$Date, epc1$Time))

## Create plot 4
plot4 <- function() {
	par(mfrow=c(2,2))

	plot(epc1$Timestamp, epc1$Global_active_power, type="l", xlab="", 
	ylab="Global Active Power")

	plot(epc1$Timestamp, epc1$Voltage, type="l", xlab="datetime", 
	ylab="Voltage")

	plot(epc1$Timestamp, epc1$Sub_metering_1, type="l", xlab="", 
	ylab="Energy sub metering")
	lines(epc1$Timestamp,epc1$Sub_metering_2,col="red")
	lines(epc1$Timestamp,epc1$Sub_metering_3,col="blue")
	legend("topright", col=c("black","red","blue"),
		c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
		lty=c(1,1), bty="n", cex=.5)

	plot(epc1$Timestamp,epc1$Global_reactive_power, type="l", xlab="datetime", 
	ylab="Global_reactive_power")

	dev.copy(png, file="plot4.png", width=480, height=480)
	dev.off()
	print("Created plot4.png")
}
plot4()