#############################################################################
# Student Name : Reginald Carey
# Course : Coursera - Data Science Specialization : Exploratory Data Analysis
# School : Johns Hopkins University
# Date : March 19, 2015
# Assignment : Course Project #2
# File : plot2.R
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

#Question 2
#----------
#
#   Have total emissions from PM2.5 decreased in the **Baltimore City**, Maryland
#   ```(fips == "24510")``` from 1999 to 2008? Use the base plotting system to make a
#   plot answering this question.

if (!exists("NEI_BaltSumByYear")) {
    NEI_Baltimore <- subset(NEI, fips == 24510)
    NEI_BaltSumByYear <- aggregate(NEI_Baltimore$Emissions/1000, by = list(Year = NEI_Baltimore$year), FUN = sum)
    names(NEI_BaltSumByYear) <- c("Year", "TotalEmissions")
}

# Write this plot to a file
png("plot2.png", width = 480, height = 480)

# Set up margins to show our labels
par(mar=c(4.5,5.5,4,2))

# Lets plot the data.
plot(NEI_BaltSumByYear$TotalEmissions ~ NEI_BaltSumByYear$Year,
     main="Total PM2.5 emissions in Baltimore all sources by Year",
     xlab="Years",
     ylab="Total Emissions\n(kilo-tons/year)",
     lwd=2,
     col="blue",
     pch=19,
     ylim=c(min(floor(NEI_BaltSumByYear$TotalEmissions/5)*5),
            max(ceiling(NEI_BaltSumByYear$TotalEmissions/5)*5))
     )

# Lets add a regression line showing the trend
regressionLine <- lm(NEI_BaltSumByYear$TotalEmissions ~ NEI_BaltSumByYear$Year)
abline(regressionLine, col="red",lwd=2)

# Lets put a legend on it so we know what we're looking at
legend("topright",
       legend=c("Total Emissions","Emissions Trend"),
       pty('p','l'),
       pch=c(19,-1),
       lty=c(0,1),
       col=c("blue","red"),
       lwd=2)

# Lets add some labels to each point to explicitly identify the data values
names <- sprintf("%0.2f kilo-tons\nin %d", NEI_BaltSumByYear$TotalEmissions, NEI_BaltSumByYear$Year)
text(NEI_BaltSumByYear$TotalEmissions ~ NEI_BaltSumByYear$Year, labels=names, cex = 0.75, pos=c(4,1,1,2))

dev.off()
