library(dplyr)

# Take codes of proper sources
SCC <- readRDS("Source_Classification_Code.rds")
codes <- SCC %>% select(SCC, Short.Name, SCC.Level.One, SCC.Level.Three) %>%
  mutate(
    SCC.Level.One = as.character(SCC.Level.One), 
    SCC.Level.Three = as.character(SCC.Level.Three)) %>%
  filter(
    grepl("combustion", SCC.Level.One, ignore.case = T), 
    grepl("coal", SCC.Level.Three, ignore.case = T)) %>%
  select(SCC)

# Filter emissions data by sources codes
pmSummary <- readRDS("summarySCC_PM25.rds")
plotDt <- pmSummary %>% 
  filter(SCC %in% codes$SCC) %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Plotting the data
png("plot4.png")

plot(plotDt, main = "Emissions from coal combustion-related sources", ylab = "PM2.5 Emission", col = "red", type = "l", pch = 19)
with(plotDt, abline(lm(total ~ year), lty = "18"))

dev.off()
rm(SCC, codes, pmSummary, plotDt)