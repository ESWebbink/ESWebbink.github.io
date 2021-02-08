# 20210206 - Gap between Actual and Potential RGDP, nsa, and Capacity Utilizatin

library(tidyverse)
library(plotly)

# TODO ####
# Facets_Quarterly.csv is here truncated to 2002-01-2020-10 and names made clearer
# Revert to generic downlod after learning how to define time range and rename series
# Truncate values, e.g. to 1 decimal point

# Read in data
df_q_gdp <- read_tsv("data/Facets_Quarterly.csv")

# transform data
df_q_gdp$rgdp_pot_nsa_q <- .25 * df_q_gdp$rgdp_pot_nsa
df_q_gdp$gdp_gap <- 100 * ((df_q_gdp$rgdp_nsa - df_q_gdp$rgdp_pot_nsa_q) /df_q_gdp$rgdp_nsa)

# graphs

  ggplot(data = df_q_gdp, aes(x = DATE, y = rgdp_pctch_qa_sa)) +
    geom_col(fill="darkorchid") +
  #  geom_smooth(se=FALSE) +
  # new stuff
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Real GDP Growth over Prior Quarter Potential", 
         y="% of Potential (+over/-underperforming)", x="Quarterly, Seasonally Adjusted, Annualized Rate", 
         caption="Source: BEA") 
   # labs(subtitle="Legend: Top-Left Inside the Plot"
  
  ggplot(data = df_q_gdp, aes(x = DATE, y = rgdp_pctch_ya_sa)) +
    geom_col(fill="darkorchid") +
    #  geom_smooth(se=FALSE) +
    # new stuff
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Real GDP Growth over Prior Year Potential", 
         y="% of Potential (+over/-underperforming)", x="Quarterly, Seasonally Adjusted, Annualized Rate", 
         caption="Source: BEA") 
  # labs(subtitle="Legend: Top-Left Inside the Plot"
  
  ggplot(data = df_q_gdp, aes(x = DATE, y = gdp_gap)) +
    geom_col(fill="darkorchid") +
    #  geom_smooth(se=FALSE) +
    # new stuff
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Gap: Real GDP less Potential", 
         y="% of Potential (+over/-underperforming)", x="Quarterly, Not Seasonally Adjusted", 
         caption="Source: BEA") 
  # labs(subtitle="Legend: Top-Left Inside the Plot"
  
  ggplot(data = df_q_gdp, aes(x = DATE, y = capacity_utilization)) +
    geom_line(colour = "darkorchid") +
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Capacity Utilization", 
         y="Percent", x="Quarterly", 
         caption="Source: BEA") +
    labs(subtitle="Percent of Total Population")
  
  
  # For Reference only below this line (8-Feb-2021) ####
  # KEEP THIS ONE!!!!!!!
  ggplot(data = df_q_gdp, 
         aes(x = DATE, 
             y = REAL_GDP_nsa)) +
    geom_line() +
    scale_colour_hue(l = 40, 
                     h = c(160, 300) + 15,
                     c = 100) +
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Population & Employment", 
         y="Percent of Total", x="Quarterly, not seasonally adjusted", 
         caption="Source: BEA") +
    labs(subtitle="Percent of Total Population")
    
  ggplot(data = df_pop_cat, 
         aes(x=DATE, 
             color=Population, 
             y=Percent)) +
    #  geom_bar(position = "dodge", 
    #           stat = "identity") +
    geom_line() +
    #  scale_colour_brewer(palette = "RdPu") +
    scale_colour_hue(l = 40, 
                     h = c(160, 300) + 15,
                     c = 100) +
    theme(panel.background = element_rect(fill = "#eeeeee")) +
    labs(title="Population & Employment", 
         y="Percent of Total", x="Monthly, not seasonally adjusted", 
         caption="Source: BEA") +
    labs(subtitle="Percent of Total Population")


# read_tsv() -- review how to import TSV/CSV data without auto-mangling it.
  
  # Rename data series
  df_q_gdp$Population <- gsub("EmployedPctP", 
                              "Employed", 
                              df_pop_cat$Population)
  
  df_q_gdp$Population <- gsub("PopNotInLFPctP", 
                              "Not In Labor Force", 
                              df_pop_cat$Population)
  
  df_q_gdp$Population <- gsub("PopUnder16PctP", 
                              "Under 16", 
                              df_pop_cat$Population)
  
  df_q_gdp$Population <- gsub("UnemployedPctP", 
                              "Unemployed", 
                              df_pop_cat$Population)
  
