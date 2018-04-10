plot4 <- function() {
        # install.packages("dplyr")
        library(dplyr)
        
        # DOWNLOAD THE SOURCE DATA ZIP FILE
        #setwd("/Users/toddrimes/Desktop/coursera/ExploratoryDataAnalysis/Week1")
        #download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","exdata%2Fdata%2Fhousehold_power_consumption.zip")
        #zipF<-"exdata%2Fdata%2Fhousehold_power_consumption.zip" %>% 
        #       unzip(exdir=".")
        header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
        dat   <- read.table("household_power_consumption.txt", skip = 66630, nrows = 3370, header = FALSE, sep =';')
        colnames( dat ) <- unlist(header)
        dat <- subset(dat,dat$Date=="1/2/2007" | dat$Date=="2/2/2007")
        dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
        dat$timestamp <-  as.POSIXct(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
        png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
        par(mfcol=c(2,2))
        
        "topleft"
        with(dat,plot(dat$timestamp,dat$Global_active_power, type="l", xlab="", ylab="Global Active Power"))

        #bottomleft
        with(dat,plot(dat$timestamp,dat$Sub_metering_1, xlab="", ylab="Energy sub metering",type="l"))
        with(dat,lines(dat$timestamp,dat$Sub_metering_2, type="l", col="red"))
        with(dat,lines(dat$timestamp,dat$Sub_metering_3, type="l", col="blue"))
        legend("topright",pch="",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1:1,box.lty=0)
        
        "topright"
        with(dat,plot(dat$timestamp,dat$Voltage, type="l", xlab="datetime", ylab="Voltage"))
        
        "bottomright"
        with(dat,plot(dat$timestamp,dat$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
        
        dev.off()
        return(dat)
}