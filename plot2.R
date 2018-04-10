plot2 <- function() {
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
        png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
        with(dat,plot(dat$timestamp,dat$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
        dev.off()
}