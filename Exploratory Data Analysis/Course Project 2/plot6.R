#############################################################################
# Student Name : Reginald Carey
# Course : Coursera - Data Science Specialization : Exploratory Data Analysis
# School : Johns Hopkins University
# Date : March 19, 2015
# Assignment : Course Project #2
# File : plot6.R
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

#Question 6
#----------
#
#   Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
#   sources in **Los Angeles County**, California (```fips == "06037"```). Which city has seen greater
#   changes over time in motor vehicle emissions?

if (!exists("NEI_BaltSumMotorVehicleByYear")) {
    SCC_MotorVehicle <- subset(SCC, grepl("vehicle", Short.Name, ignore.case = TRUE), select=SCC)
    NEI_Baltimore <- subset(NEI, fips == "24510")
    NEI_MotorVehicle <- subset(NEI_Baltimore, SCC %in% SCC_MotorVehicle[[1]])
    NEI_BaltSumMotorVehicleByYear <- aggregate(NEI_MotorVehicle$Emissions, by = list(Year = NEI_MotorVehicle$year), FUN = sum)
    names(NEI_BaltSumMotorVehicleByYear) <- c("Year", "TotalEmissions")
}

if (!exists("NEI_LosAngelesSumMotorVehicleByYear")) {
    SCC_MotorVehicle <- subset(SCC, grepl("vehicle", Short.Name, ignore.case = TRUE), select=SCC)
    NEI_LosAngeles <- subset(NEI, fips == "06037")
    NEI_MotorVehicle <- subset(NEI_LosAngeles, SCC %in% SCC_MotorVehicle[[1]])
    NEI_LosAngelesSumMotorVehicleByYear <- aggregate(NEI_MotorVehicle$Emissions, by = list(Year = NEI_MotorVehicle$year), FUN = sum)
    names(NEI_LosAngelesSumMotorVehicleByYear) <- c("Year", "TotalEmissions")
}

# Write this plot to a file
png("plot6.png", width = 480, height = 480)

# Set up margins to show our labels
par(mar=c(4.5,2.5,6,2))

# Lets plot the data.
plot(log(NEI_BaltSumMotorVehicleByYear$TotalEmissions) ~ NEI_BaltSumMotorVehicleByYear$Year,
     main = "City Comparison Baltimore vs. Los Angeles \nPM2.5 Emissions by Year\nMotor Vehicle Sources",
     xlab = "Years",
     ylab = "",
     yaxt = "n",
     type = "n",
     ylim = c(2,9)
)
mtext("Total Emissions (tons - log scale)",side=2,line=1)
points(log(NEI_LosAngelesSumMotorVehicleByYear$TotalEmissions) ~ NEI_LosAngelesSumMotorVehicleByYear$Year,
       lwd = 2,
       pch = 19,
       col = "red",
#       type = "p"
)
abline(lm(log(NEI_LosAngelesSumMotorVehicleByYear$TotalEmissions) ~ NEI_LosAngelesSumMotorVehicleByYear$Year),
       lwd = 1, lty = 1, col = "red",#type = "l"
)

points(log(NEI_BaltSumMotorVehicleByYear$TotalEmissions) ~ NEI_BaltSumMotorVehicleByYear$Year,
       lwd = 2,
       pch = 19,
       col = "blue",
#       type = "p"
)
abline(lm(log(NEI_BaltSumMotorVehicleByYear$TotalEmissions) ~ NEI_BaltSumMotorVehicleByYear$Year),
       lwd = 1, lty = 1, col = "blue", #type = "l"
)

# Lets put a legend on it so we know what we're looking at
legend("topright",
       legend = c("Total Emissions Baltimore","Total Emissions Los Angeles"),
       pty('p'),
       pch = c(19,19),
       lty = c(0),
       col = c("blue","red"),
       cex = 0.75,
       lwd = 2)

# Lets add some labels to each point to explicitly identify the data values

names <- sprintf("%0.2f tons in %d\n%0.2f%% Change from high",
                 NEI_BaltSumMotorVehicleByYear$TotalEmissions,
                 NEI_BaltSumMotorVehicleByYear$Year,
                 100*(1-(NEI_BaltSumMotorVehicleByYear$TotalEmissions/max(NEI_BaltSumMotorVehicleByYear$TotalEmissions))))
text(log(NEI_BaltSumMotorVehicleByYear$TotalEmissions) ~
         NEI_BaltSumMotorVehicleByYear$Year,
     labels = names,
     cex = 0.75,
     pos = c(4,1,3,2))

names <- sprintf("%0.2f tons in %d\n%0.2f%% Change from high",
                 NEI_LosAngelesSumMotorVehicleByYear$TotalEmissions,
                 NEI_LosAngelesSumMotorVehicleByYear$Year,
                 100*(1-(NEI_LosAngelesSumMotorVehicleByYear$TotalEmissions/max(NEI_LosAngelesSumMotorVehicleByYear$TotalEmissions))))
text(log(NEI_LosAngelesSumMotorVehicleByYear$TotalEmissions) ~
         NEI_LosAngelesSumMotorVehicleByYear$Year,
     labels = names,
     cex = 0.75,
     pos = c(4,1,3,2))

dev.off()
