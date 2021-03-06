# 20210206 - Gap between Actual and Potential RGDP, nsa, and Capacity Utilizatin

library(tidyverse)
library(plotly)
library(readr)

# TODO ####
# Facets_Quarterly.csv is here truncated to 2002-01-2020-10 and names made clearer
# Revert to generic downlod after learning how to define time range and rename series
# Truncate values, e.g. to 1 decimal point

# Read in data
df_q_gdp <- read_tsv("data/Facets_Quarterly.txt")

# transform data
df_q_gdp$rgdp_pot_nsa_q <- .25 * df_q_gdp$rgdp_pot_nsa
df_q_gdp$gdp_gap <- 100 * ((df_q_gdp$rgdp_nsa - df_q_gdp$rgdp_pot_nsa_q) /df_q_gdp$rgdp_nsa)

# plots ####

  ggplot(data = df_q_gdp, aes(x = DATE, y = rgdp_pctch_qa_sa)) +
    geom_col(fill="darkorchid") +
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Real GDP Growth over Prior Quarter Potential", 
         y="% of Potential (+over/-underperforming)", x="Quarterly, Seasonally Adjusted, Annualized Rate", 
         caption="Source: BEA")
  
  ggplot(data = df_q_gdp, aes(x = DATE, y = rgdp_pctch_ya_sa)) +
    geom_col(fill="darkorchid") +
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Real GDP Growth over Prior Year Potential", 
         y="% of Potential (+over/-underperforming)", x="Quarterly, Seasonally Adjusted, Annualized Rate", 
         caption="Source: BEA")
  
  ggplot(data = df_q_gdp, aes(x = DATE, y = gdp_gap)) +
    geom_col(fill="darkorchid") +
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Gap: Real GDP less Potential", 
         y="% of Potential (+over/-underperforming)", x="Quarterly, Not Seasonally Adjusted", 
         caption="Source: BEA")
  
  ggplot(data = df_q_gdp, aes(x = DATE, y = capacity_utilization)) +
    geom_line(colour = "darkorchid") +
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Capacity Utilization", 
         y="Percent", x="Quarterly", 
         caption="Source: BEA") +
    labs(subtitle="Percent of Total Population")

# read_tsv() -- review how to import TSV/CSV data without auto-mangling it.
  
# Rename data series
