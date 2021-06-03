# FRED API Test 20210506

library(fredr)
library(readr)
library(tidyr)

fred_indicators <- read_csv("data/FRED_Indicators.csv")

series1 <- fredr_series_observations(series_id = fred_indicators$Series_ID[1]) # "ND000334Q")

for (i in 2:NROW(fred_indicators$Series_ID)) {
  
  series_temp <- fredr_series_observations(series_id = fred_indicators$Series_ID[i])
  
  series1 <- rbind(series1, series_temp)
  
  Sys.sleep(1)
  print(i)
  
}

# How to re-organize series1 into data.frame shaped for index.Rmd scripts
# # Facets_Quarterly.txt headings:
# [1] "DATE"            "A191RL1Q225SBEA" "A191RO1Q156NBEA" "B230RC0Q173SBEA"
# [5] "CAPUTLB50001SQ"  "GDPPOT"          "ND000334Q" 
quarterly_series <- c("A191RL1Q225SBEA", "A191RO1Q156NBEA", "B230RC0Q173SBEA",
                      "CAPUTLB50001SQ", "GDPPOT", "ND000334Q")
series1_quarterly <- series1[series1$series_id %in% quarterly_series,] 
  
facets_quarterly <- spread(series1_quarterly, key = series_id, value = value )

colnames(facets_quarterly)[1] <- "DATE"

write.table(facets_quarterly,
            "data/Facets_Quarterly_API.txt",
            sep = "\t",
            na = "",
            row.names = F)

# fac_m <- read_tsv("data/Facets_Monthly.txt")
# colnames(fac_m)  -- generated:
# [1] "DATE"                "CEU0500000002"       "CEU0500000003"       "CNP16OV"            
# [5] "CPIAUCSL"            "CPILFESL"            "GS1"                 "GS10"               
# [9] "GS5"                 "LFWA64TTUSM647S"     "LNU01000000"         "LNU03000000"        
# [13] "LNU05000000"         "PCEPI"               "PCEPILFE"            "PCETRIM1M158SFRBDAL"
# [17] "POPTHM"              "STLPPM"   

# - How do you prep the Facets_Monthly.csv (as a CSV &/or just a data.frame)?

# - How do you prep the Facets_Quarterly.csv (as a CSV &/or data.frame)?




