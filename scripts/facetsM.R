# 20210130 - Examine Actual and potential RGDP

library(tidyverse)

df_m <- read_tsv("data/FacetsM.csv")

# transform data
df_m$LaborForceParticipationRate <- 100 * (df_m$LaborForce / df_m$PopOver16)
df_m$UnemploymentRate <- 100 * df_m$Unemployed / df_m$LaborForce

df_m$UnemployedPctP <- 100 * df_m$Unemployed /df_m$Population
df_m$Employed <- df_m$LaborForce - df_m$Unemployed
df_m$EmployedPctP <- 100 * df_m$Employed /df_m$Population
df_m$PopNotInLFPctP <- 100 * (df_m$PopOver16 - df_m$LaborForce) / df_m$Population
df_m$PopUnder16PctP <- 100 * (df_m$Population - df_m$PopOver16) / df_m$Population

# subset population percentages
df_m_pct <- df_m[,c("DATE","EmployedPctP", "UnemployedPctP",
                    "PopNotInLFPctP","PopUnder16PctP")]

# Reshape dataframe to graph multiple lines
# need to convert multiple variable to single with multiple categories

df_pop_cat <- gather(df_m_pct, 
                     key = "Population", 
                     value = "Percent", 
                     -DATE,
                     na.rm=FALSE)

# Fix names in Population Column
df_pop_cat$Population <- gsub("EmployedPctP", 
                              "Employed", 
                              df_pop_cat$Population)

df_pop_cat$Population <- gsub("PopNotInLFPctP", 
                              "Not In Labor Force", 
                              df_pop_cat$Population)

df_pop_cat$Population <- gsub("PopUnder16PctP", 
                              "Under 16", 
                              df_pop_cat$Population)

df_pop_cat$Population <- gsub("UnemployedPctP", 
                              "Unemployed", 
                              df_pop_cat$Population)

# Make 'Population' an ordered factor

df_pop_cat$Population <- ordered(df_pop_cat$Population,
                                 levels = c("Employed",
                                            "Unemployed",
                                            "Not In Labor Force",
                                            "Under 16"))


# Plot as categorical data to show legend


# KEEP THIS ONE!!!!!!! ####
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
  theme(panel.background = element_rect(fill = "#eeeeee", colour = "grey")) +
  labs(title="Population & Employment", 
       y="Percent of Total", x="Monthly, not seasonally adjusted", 
       caption="Source: BEA") +
  labs(subtitle="Percent of Total Population")

#Try to make a bar chart with 4 variables
# Example
# library(ggplot2)
# library(tidyr)
# library(dplyr)
# df <- data.frame(table_name =c("a", "b","c"), 
#                  expected=runif(3), 
#                  observed=runif(3))
# gather(df, key, value, -table_name) %>% 
#   ggplot(aes(table_name, value, fill=key))+ 
#   geom_bar(stat="identity", position="dodge")

ggplot(data = df_pop_cat, 
       aes(x=DATE, y=Percent,
           fill = Population)) +
  geom_bar(position = "dodge") +
  scale_fill_brewer("RdPu") +
  theme(panel.background = element_rect(fill = "white", colour = "white")) +
  labs(title="Population & Employment", 
       y="Percent of Total", x="Mo/Yr", 
       caption="Source: BEA") +
  labs(subtitle="Legend: Top-Left Inside the Plot")


ggplot(data = df_pop_cat, 
       aes(x=DATE, y=Percent,
           fill = Population)) +
  geom_bar() +
  scale_fill_brewer("RdPu") +
  theme(panel.background = element_rect(fill = "white", colour = "white")) +
  labs(title="Population & Employment", 
       y="Percent of Total", x="Mo/Yr", 
       caption="Source: BEA") +
  labs(subtitle="Legend: Top-Left Inside the Plot")

# Try to rename. rescale,reorder variables

# graph stuff

ggplot(data = df_m, aes(x = DATE, y = PopOver16Pct)) +
  geom_line(fill="darkorchid")

ggplot(data = df_m, aes(x = DATE, y = LaborForcePct)) +
  geom_line(fill="darkorchid")

ggplot(data = df_m, aes(x = DATE, y = UnemployedPct)) +
  geom_col(fill="darkorchid")

ggplot(data = df_m, aes(x=DATE)) +
  geom_line(aes(y = PopOver16Pct), color = "darkorchid") + 
  geom_line(aes(y = LaborForcePct), color="steelblue", linetype="twodash")

ggplot(data = df_m, aes(x=DATE)) +
  geom_line(aes(y = PopOver16Pct), color = "darkorchid")+ 
  geom_line(aes(y = LaborForcePct), color="steelblue", linetype="twodash") +
  labs(title="Population Age 16 and Older", 
       y="Population >16", x="Year", 
       caption="Source: BEA") +
  theme(legend.title = element_text(size=12, color = "salmon", face="bold"),
        legend.justification=c(0,1), 
        legend.position=c(0.05, 0.95),
        legend.background = element_blank(),
        legend.key = element_blank()) + 
  labs(subtitle="Legend: Top-Left Inside the Plot")

# This works but colors are default
ggplot(data = df_pop_cat, 
       aes(x=DATE, y=Percent,
           fill = Population)) +
  geom_area() +
  scale_fill_brewer("RdPu") +
  theme(panel.background = element_rect(fill = "white", colour = "white")) +
  labs(title="Population & Employment", 
       y="Percent of Total", x="Mo/Yr", 
       caption="Source: BEA") +
  labs(subtitle="Legend: Top-Left Inside the Plot")

#testing version
#Greens
ggplot(data = df_pop_cat, 
       aes(x=DATE, 
           color=Population, 
           y=Percent)) +
  #  geom_bar(position = "dodge", 
  #           stat = "identity") +
  geom_line() +
  #  scale_colour_brewer(palette = "RdPu") +
  scale_colour_hue(l = 50, 
                   h = c(100, 150) + 15,
                   c = 50) +
  theme(panel.background = element_rect(fill = "white", colour = "white")) +
  labs(title="Population & Employment", 
       y="Percent of Total", x="Mo/Yr", 
       caption="Source: BEA") +
  labs(subtitle="Legend: Top-Left Inside the Plot")

  