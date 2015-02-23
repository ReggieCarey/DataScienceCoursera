acs <- read.csv("acs.csv")
agricultureLogical <- acs$ACR==3 & acs$AGS==6
cat("Q1:", which(agricultureLogical)[1:3],"\n")

jeff <- readJPEG("jeff.jpg", native=TRUE)
cat("Q2:", quantile(jeff, probs=c(0.30,0.80)),"\n")

GDP <- read.table("gdp.csv",nrows = 190, skip = 5, sep=",", dec = ",", quote = '"')
GDP <- rename(GDP, id=V1, Ranking=V2, Economy=V4,Value=V5)
GDP$Value <- as.numeric(gsub(",","",GDP$Value))
GDP <- select(GDP, id, Ranking, Economy, Value)
FEDSTATS_Country <- read.csv("FedStats_Country.csv")
merged <- merge(GDP, FEDSTATS_Country, by.x="id", by.y="CountryCode", all=FALSE)
sorted <- arrange(merged, desc(Ranking))
cat("Q3:",length(intersect(GDP$id, FEDSTATS_Country$CountryCode)),"matches,","13th country is",as.character(sorted[13,"Economy"]),"\n")

q4 <- arrange(filter(summarize(group_by(merged, Income.Group), mean(Ranking)), Income.Group %in% c("High income: OECD", "High income: nonOECD")),desc(Income.Group))
cat("Q4:", q4[[2]],"\n")

# Add a quantile column
merged$Quantile <- cut(merged$Ranking, breaks = 5, labels = c("Q1","Q2","Q3","Q4","Q5"))
cat("Q5:", table(merged$Quantile,merged$Income.Group)[1,"Lower middle income"], "\n")
