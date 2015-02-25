cat("Week 4 Quiz\n");

rm(list=ls());

filename <- 'getdata-data-ss06hid.csv';
if (!file.exists(filename)) {
  cat("Downloading data from the internet\n")
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',destfile = filename, method='curl');
}

cat("Loading data into memory\n\n")
acs <- read.csv(filename);
cat("Question 1: ");
print(strsplit(names(acs),'wgtp')[[123]]);

filename <- 'getdata-data-GDP.csv'
if (!file.exists(filename)) {
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = filename, method='curl')
}

library(dplyr);

GDP <- read.table(filename,nrows = 190, skip = 5, sep=",", dec = ",", quote = '"')
GDP <- rename(GDP, id=V1, Ranking=V2, Economy=V4,Value=V5)
GDP$Value <- as.numeric(gsub(",","",GDP$Value))
cat("Question 2: ", mean(GDP$Value), "\n");

countryNames <- as.character(GDP$Economy)

cat("Question 3: grep(\"United\",countryNames),", length(grep("^United", countryNames)), "\n")

GDP <- select(GDP, id, Ranking, Economy, Value)

filename <- 'get-data-FEDSTATS_Country.csv'
if (!file.exists(filename)) {
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = filename, method='curl')
}

FEDSTATS_Country <- read.csv(filename)
merged <- merge(GDP, FEDSTATS_Country, by.x="id", by.y="CountryCode", all=FALSE)

fy <- merged[grep('[fF]iscal [yY]ear', as.character(merged$Special.Notes)),]

endInJune <- fy[grep('[yY]ear +end: +June', as.character(fy$Special.Notes)),]

cat("Question 4: ", nrow(endInJune), "\n")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

samples2012 = amzn['2012']

numSamples2012 = nrow(samples2012)

mondays <- as.POSIXlt(time(samples2012))$wday==1

numMondays <- nrow(samples2012[mondays])

cat("Question 5: ",numSamples2012, ",", numMondays, "\n")
