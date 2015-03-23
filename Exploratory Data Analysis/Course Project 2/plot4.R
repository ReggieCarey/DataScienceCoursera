#############################################################################
# Student Name : Reginald Carey
# Course : Coursera - Data Science Specialization : Exploratory Data Analysis
# School : Johns Hopkins University
# Date : March 19, 2015
# Assignment : Course Project #2
# File : plot4.R
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

#Question 4
#----------
#
#   Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

if (!exists("NEI_SumCoalCombustionByYear")) {
    SCC_CoalCombustion <- subset(SCC,
                                 grepl("coal", SCC.Level.Three, ignore.case = TRUE)
                                 & grepl("combustion", SCC.Level.Four, ignore.case = TRUE),
                                 select=SCC)
    NEI_CoalCombustion <- subset(NEI, SCC %in% SCC_CoalCombustion[[1]])
    NEI_SumCoalCombustionByYear <- aggregate(NEI_CoalCombustion$Emissions, by = list(Year = NEI_CoalCombustion$year), FUN = sum)
    names(NEI_SumCoalCombustionByYear) <- c("Year", "TotalEmissions")
}

# Write this plot to a file
png("plot4.png", width = 480, height = 480)

# Set up margins to show our labels
par(mar=c(4.5,5.5,4,2))

# Lets plot the data.
plot(NEI_SumCoalCombustionByYear$TotalEmissions ~ NEI_SumCoalCombustionByYear$Year,
     main="Total U.S. PM2.5 Emissions by Year\nCoal Combustion Sources",
     xlab="Years",
     ylab="Total Emissions\n(tons/year)",
     lwd=2,
     col="blue",
     pch=19,
     ylim=c(1200,2000)
)

# Lets put a legend on it so we know what we're looking at
legend("topright",
       legend=c("Total Emissions"),
       pty('p'),
       pch=c(19),
       lty=c(0),
       col=c("blue"),
       lwd=2)

# Lets add some labels to each point to explicitly identify the data values
names <- sprintf("%0.2f tons\nin %d", NEI_SumCoalCombustionByYear$TotalEmissions, NEI_SumCoalCombustionByYear$Year)
text(NEI_SumCoalCombustionByYear$TotalEmissions ~ NEI_SumCoalCombustionByYear$Year, labels=names, cex = 0.65, pos=c(4,3,3,2))

dev.off()

