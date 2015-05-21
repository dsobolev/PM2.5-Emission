pmSummary <- readRDS("summarySCC_PM25.rds")

library(dplyr)
library(ggplot2)

# Prepare data
dtPlot <- pmSummary %>% 
  filter(fips == "24510") %>% 
  select(Emissions, year, type) %>%
  mutate(type = as.factor(type)) %>%
  group_by(year, type) %>%
  summarize(emission = sum(Emissions))

# Build plotting object
plotObj <- qplot(year, emission, data = dtPlot, facets = . ~ type, geom = c("point", "smooth"), method = "lm") + 
  ggtitle("PM2.5 emissons by Types") + 
  theme(plot.title = element_text(face = "bold")) + 
  ylab("PM2.5 Emission") + 
  scale_x_continuous(breaks = c(2002, 2006))

# Print results
png("plot3.png")
print(plotObj)
dev.off()

rm(dtPlot, plotObj, pmSummary)