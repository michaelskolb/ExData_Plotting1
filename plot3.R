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

## Create plot 3
plot3 <- function() {
	plot(epc1$Timestamp, epc1$Sub_metering_1, type="l", xlab="", 
	ylab="Energy sub metering")
	lines(epc1$Timestamp,epc1$Sub_metering_2,col="red")
	lines(epc1$Timestamp,epc1$Sub_metering_3,col="blue")
	legend("topright", col=c("black","red","blue"), 
		c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), 
		lwd=c(1,1))
	dev.copy(png, file="plot3.png", width=480, height=480)
	dev.off()
      print("Created plot3.png")
}
plot3()
