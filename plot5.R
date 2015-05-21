library(dplyr)

# Take codes of motor vehicle sources
SCC <- readRDS("Source_Classification_Code.rds")
codes <- SCC %>% 
  filter(
    (
      grepl("vehicle", EI.Sector, ignore.case = T) & 
      grepl("on-road", EI.Sector, ignore.case = T)
    ) | (
      grepl("motor vehicle", SCC.Level.Three) 
    )
  ) %>% 
  select(SCC)

# Filter emissions data by sources codes for Baltimore City
pmSummary <- readRDS("summarySCC_PM25.rds")
plotDt <- pmSummary %>%  
  filter(
    fips == "24510",
    SCC %in% codes$SCC
  ) %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Plotting the data
png("plot5.png")

plot(plotDt, 
     main = "Emissions from motor vehicle sources (Baltimore City)",
     ylab = "PM2.5 Emission", 
     col = "red", type = "l", pch = 19)
with(plotDt, abline(lm(total ~ year), lty = "18"))

dev.off()

rm(SCC, codes, pmSummary)