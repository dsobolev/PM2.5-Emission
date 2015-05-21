pmSummary <- readRDS("summarySCC_PM25.rds")

library(dplyr)
dtPlot <- pmSummary %>% 
          select(Emissions, year) %>% 
          group_by(year) %>% 
          summarize(total = sum(Emissions))

png("plot1.png")

plot(dtPlot, main = "PM2.5 Emission", ylab = "Total PM2.5 Emission", col = "red", pch = 19)
with(dtPlot, abline(lm(total ~ year), lty = "18"))

dev.off()
rm(dtPlot, pmSummary)