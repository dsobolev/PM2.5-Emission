pmSummary <- readRDS("summarySCC_PM25.rds")

library(dplyr)
dtPlot <- pmSummary %>% 
          filter(fips == "24510") %>% 
          select(Emissions, year) %>% 
          group_by(year) %>% 
          summarize(total = sum(Emissions))

png("plot2.png")

plot(dtPlot, main = "PM2.5 Emission in Baltimore City", ylab = "PM2.5 Emission", col = "red", pch = 19)
with(dtPlot, abline(lm(total ~ year), lty = "18"))

dev.off()
rm(dtPlot)