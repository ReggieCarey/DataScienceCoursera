#############################################################################
# Student Name : Reginald Carey
# Course : Coursera - Data Science Specialization : Exploratory Data Analysis
# School : Johns Hopkins University
# Date : March 19, 2015
# Assignment : Course Project #2
# File : plot3.R
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

#Question 3
#----------
#
#   Of the four types of sources indicated by the ```type``` (point, nonpoint, onroad, nonroad)
#   variable, which of these four sources have seen decreases in emissions from 1999–2008
#   for **Baltimore City**? Which have seen increases in emissions from 1999–2008? Use the
#   **ggplot2** plotting system to make a plot answer this question.

if (!exists("NEI_BaltSumByTypeYear")) {
    NEI_Baltimore <- subset(NEI, fips == "24510")
    NEI_BaltSumByTypeYear <- aggregate(NEI_Baltimore$Emissions,
                                       by = list(NEI_Baltimore$year,NEI_Baltimore$type),
                                       FUN = sum)
    names(NEI_BaltSumByTypeYear) <- c("Year", "Type", "TotalEmissions")
}

# Write this plot to a file
png("plot3.png", width = 480, height = 480)

# Use GGPLOT2 Plotting System
library(ggplot2)

# Lets plot the data.
print(
    qplot(Year, TotalEmissions,
          data = NEI_BaltSumByTypeYear,
          facets = . ~ Type,
          geom=c("point", "smooth"),
          method="lm",
          se=FALSE) +
        ggtitle("PM 2.5 for Baltimore City - Trends by Sensor Sources\nTotal Emissions per Year") +
        ylab("Total Emissions (tons)")
)

dev.off()
