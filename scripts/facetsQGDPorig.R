# 20210130 - Examine Actual and potential RGDP

library(tidyverse)
library(plotly)

df_q_rgdp <- read_tsv("data/FacetsQ.csv")

# transform data
df_q_rgdp$gdp_gap <- 100 * (df_q_rgdp$RealGDPsaar - df_q_rgdp$`RGDP-Potential-saar`) / df_q_rgdp$`RGDP-Potential-saar`

# graph stuff


  ggplot(data = df_q_rgdp, aes(x = DATE, y = gdp_gap)) +
    geom_col(fill="darkorchid") +
  #  geom_smooth(se=FALSE) +
  # new stuff
    theme(panel.background = element_rect(fill = "#eeeeee", colour = "#777777")) +
    labs(title="Gap: Real GDP less Potential", 
         y="% of Potential (+over/-underperforming)", x="Monthly, Seasonally Adjusted, Annualized Rate", 
         caption="Source: BEA") 
   # labs(subtitle="Legend: Top-Left Inside the Plot"


# read_tsv() -- review how to import TSV/CSV data without auto-mangling it.
