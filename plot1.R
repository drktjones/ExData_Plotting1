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

# Plot histogram
par(mar=c(5.1,4.1,4.1,2)) # Set margins
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# Save file
setwd("datasciencecoursera/gcd")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

