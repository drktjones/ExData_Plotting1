# This assignment uses data from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets.

# Read data by creating a temp file in which the downloaded and unzipped data
# will be stored and then removed after reading in relevant data for the 
# assignment
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              temp, method="curl")
data <- subset(read.table(unz(temp, "household_power_consumption.txt"), 
                   header=TRUE, na.strings="?", sep=";",
                   colClasses=c("character","character","numeric","numeric",
                                "numeric","numeric","numeric","numeric","numeric")), 
                   (as.Date(Date, "%d/%m/%Y")=="2007/02/01" |
                            as.Date(Date, "%d/%m/%Y")=="2007/02/02"))
unlink(temp)

# Plot 
data$date_time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S") # Create datetime
par(mfrow=c(2,2), mar=c(5.1,4.1,4.1,2)) # Set margins
with(data, {
        plot(date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        plot(date_time, Voltage, type="l", xlab="datetime", ylab="Voltage")
        plot(date_time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
                points(date_time, Sub_metering_1, col="black", type="l")
                points(date_time, Sub_metering_2, col="red", type="l")
                points(date_time, Sub_metering_3, col="blue", type="l")
                legend("topright", lwd="1", bty="n", pt.cex=1, cex=0.5, col=c("black", "red", "blue"),
                       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(date_time, Global_reactive_power, type="l", 
             xlab="datetime", ylab="Global_reactive_power")
})
          
# Save file
setwd("datasciencecoursera/gcd")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

