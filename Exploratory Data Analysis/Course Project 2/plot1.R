#############################################################################
# Student Name : Reginald Carey
# Course : Coursera - Data Science Specialization : Exploratory Data Analysis
# School : Johns Hopkins University
# Date : March 19, 2015
# Assignment : Course Project #2
# File : plot1.R
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

#Question 1
#----------
#
#    Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#    Using the **base** plotting system, make a plot showing the total PM2.5 emission
#    from all sources for each of the years 1999, 2002, 2005, and 2008.

if (!exists("NEI_SumByYear")) {
    NEI_SumByYear <- aggregate(NEI$Emissions/1000, by = list(Year = NEI$year), FUN = sum)
    names(NEI_SumByYear) <- c("Year", "TotalEmissions")
}

# Write this plot to a file
png("plot1.png", width = 480, height = 480)

# Set up margins to show our labels
par(mar=c(4.5,5.5,4,2))

# Lets plot the data.
plot(NEI_SumByYear$TotalEmissions ~ NEI_SumByYear$Year,
     main="Total PM2.5 emissions from all sources by Year",
     xlab="Years",
     ylab="Total Emissions\n(kilo-tons/year)",
     lwd=2,
     col="blue",
     pch=19,
     ylim=c(min(floor(NEI_SumByYear$TotalEmissions/1000)*1000),
            max(ceiling(NEI_SumByYear$TotalEmissions/1000)*1000)))

# Lets add a regression line showing the trend
regressionLine <- lm(NEI_SumByYear$TotalEmissions ~ NEI_SumByYear$Year)
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
names <- sprintf("%0.2f kilo-tons\nin %d", NEI_SumByYear$TotalEmissions, NEI_SumByYear$Year)
text(NEI_SumByYear$TotalEmissions ~ NEI_SumByYear$Year, labels=names, cex = 0.75, pos=c(4,1,3,2))

dev.off()
