# Interest Rates

library(tidyverse)

df_i <- read_csv("data/interest.csv")

# Reshaping dataframe to graph multiple lines
# need to convert multiple variable to single with multiple categories

df_int_cat <- gather(df_i, 
                     key = "Maturity", 
                     value = "Treasuries", 
                     -DATE,
                     na.rm=FALSE)

# Plot as categorical data to show legend

# This works
ggplot(data = df_int_cat, 
       aes(x=DATE, y=Treasuries,
           color = Maturity)) +
  geom_line() +
  scale_colour_hue(l=40,c=35) +
  labs(title="Treasury Bonds", 
       y="Interest Rate", x="Mo/Yr", 
       caption="Source: BEA") +
  labs(subtitle="Legend: Top-Left Inside the Plot")

# what works .... but  with extra notes
ggplot(data = df_int_cat, 
        aes(x=DATE, y=Treasuries,
        color = Maturity)) +
  geom_line() +
  scale_colour_hue(l=20,c=35) +
  labs(title="Treasury Bonds", 
       y="Interest Rate", x="Mo/Yr", 
       caption="Source: BEA") +
  # theme(legend.title = element_text(size=12, color = "salmon", face="bold"),
  #      legend.justification=c(0,1), 
  #       legend.position=c(0.05, 0.95),
  #       legend.background = element_blank(),
  #       legend.key = element_blank()) + 
  labs(subtitle="Legend: Top-Left Inside the Plot")

# scale_colour_hue(l=60,c=35) --> 
#   l,luminence: 0dark-100light
#   c,chroma:intensity
#   h,hue

# this is just okay
ggplot(data = df_int_cat, 
       aes(x=DATE, y=Treasuries,
           color = Maturity)) +
  geom_line() +
  scale_colour_hue(l=50,c=60, h = c(250, 360)) +
  labs(title="Treasury Bonds", 
       y="Interest Rate", x="Mo/Yr", 
       caption="Source: BEA") +
  labs(subtitle="1 yr, 5 yr, and 10 yr")

ggplot(data = df_int_cat, 
       aes(x=DATE, y=Treasuries,
           color = Maturity)) +
  geom_line() +
  scale_colour_brewer(palette = "BuPu") +
  labs(title="Treasury Bonds", 
       y="Interest Rate", x="Mo/Yr", 
       caption="Source: BEA") +
  labs(subtitle="Legend: Top-Left Inside the Plot")

# Testing area ... didn't work
ggplot2(data = df_int_cat, 
       aes(x=DATE, y=Treasuries,
           color = Maturity)) +
  geom_bar(position_dodge())

