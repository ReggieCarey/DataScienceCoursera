#############################################################################
# Student Name : Reginald Carey
# Course : Coursera - Data Science Specialization : Exploratory Data Analysis
# School : Johns Hopkins University
# Date : March 19, 2015
# Assignment : Course Project #2
# File : plot5.R
#############################################################################

# Load The Data from the website - if not already Loaded

if (!file.exists("summarySCC_PM25.rds") || !file.exists("Source_Classification_Code.rds")) {
    if (!file.exists("exdata-data-NEI_data.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile = "exdata-data-NEI_data.zip",
                      method = "curl")
    }
    # Unwrap the data
    unzip(zipfile = "exdata-data-NEI_data.zip")
}

# Load the data into memory

if (!exists("NEI")) {
    NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

#Question 5
#----------
#
#   How have emissions from motor vehicle sources changed from 1999–2008 in **Baltimore City**?

if (!exists("NEI_BaltSumMotorVehicleByYear")) {
    SCC_MotorVehicle <- subset(SCC, grepl("vehicle", Short.Name, ignore.case = TRUE), select=SCC)
    NEI_Baltimore <- subset(NEI, fips == "24510")
    NEI_MotorVehicle <- subset(NEI_Baltimore, SCC %in% SCC_MotorVehicle[[1]])
    NEI_BaltSumMotorVehicleByYear <- aggregate(NEI_MotorVehicle$Emissions, by = list(Year = NEI_MotorVehicle$year), FUN = sum)
    names(NEI_BaltSumMotorVehicleByYear) <- c("Year", "TotalEmissions")
}

# Write this plot to a file
png("plot5.png", width = 480, height = 480)

# Set up margins to show our labels
par(mar=c(4.5,5.5,4,2))

# Lets plot the data.
plot(NEI_BaltSumMotorVehicleByYear$TotalEmissions ~ NEI_BaltSumMotorVehicleByYear$Year,
     main = "Total Baltimore City PM2.5 Emissions by Year\nMotor Vehicle Sources",
     xlab = "Years",
     ylab = "Total Emissions\n(tons/year)",
     lwd = 2,
     col = "blue",
     pch = 19,
     ylim = c(20,80)
)

# Lets put a legend on it so we know what we're looking at
legend("topright",
       legend = c("Total Emissions"),
       pty('p'),
       pch = c(19),
       lty = c(0),
       col = c("blue"),
       lwd = 2)

# Lets add some labels to each point to explicitly identify the data values
names <- sprintf("%0.2f tons\nin %d", NEI_BaltSumMotorVehicleByYear$TotalEmissions, NEI_BaltSumMotorVehicleByYear$Year)
text(NEI_BaltSumMotorVehicleByYear$TotalEmissions ~ NEI_BaltSumMotorVehicleByYear$Year,
     labels = names,
     cex = 0.65,
     pos = c(4,3,3,2))

dev.off()
