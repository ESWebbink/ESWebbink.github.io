# FRED API Test 20210506

library(fredr)
library(readr)
library(tidyr)

fred_indicators <- read_csv("data/FRED_Indicators.csv")

# 1 - Request API key at https://fredaccount.stlouisfed.org/apikey
# 2 - Set FRED_API_KEY in .Renviron
# 3 - In RStudio, go to Session -> Restart R to reload .Renviron file
fredr_set_key(Sys.getenv("FRED_API_KEY"))

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

# quarterly_series <- c("A191RL1Q225SBEA", "A191RO1Q156NBEA", "B230RC0Q173SBEA",
#                       "CAPUTLB50001SQ", "GDPPOT", "ND000334Q")

fac_q <- read_tsv("data/Facets_Quarterly.txt")

quarterly_series <- colnames(fac_q)[2:NROW(colnames(fac_q))]

series1_quarterly <- series1[series1$series_id %in% quarterly_series,] 
  
facets_quarterly <- spread(series1_quarterly, key = series_id, value = value )

colnames(facets_quarterly)[1] <- "DATE"

drop_cols <- c("realtime_start", "realtime_end")
facets_quarterly <- facets_quarterly[,!colnames(facets_quarterly) %in% drop_cols]


if (!FALSE %in% c(colnames(fac_q)==colnames(facets_quarterly))) {
  
  write.table(facets_quarterly,
              "data/Facets_Quarterly_API.txt",
              sep = "\t",
              na = "",
              row.names = F)
  
} else {
  
  print("Check Quarterly data Input/Output -- Columns do not match")
  
}


# Update Monthly Facets
fac_m <- read_tsv("data/Facets_Monthly.txt")
# colnames(fac_m)  -- generated:
# [1] "DATE"                "CEU0500000002"       "CEU0500000003"       "CNP16OV"            
# [5] "CPIAUCSL"            "CPILFESL"            "GS1"                 "GS10"               
# [9] "GS5"                 "LFWA64TTUSM647S"     "LNU01000000"         "LNU03000000"        
# [13] "LNU05000000"         "PCEPI"               "PCEPILFE"            "PCETRIM1M158SFRBDAL"
# [17] "POPTHM"              "STLPPM"   

# monthly_series <- c("CEU0500000002", "CEU0500000003", "CNP16OV", ...)

monthly_series <- colnames(fac_m)[2:NROW(colnames(fac_m))]

series1_monthly <- series1[series1$series_id %in% monthly_series,] 

facets_monthly <- spread(series1_monthly, key = series_id, value = value )

colnames(facets_monthly)[1] <- "DATE"

drop_cols <- c("realtime_start", "realtime_end")
facets_monthly <- facets_monthly[,!colnames(facets_monthly) %in% drop_cols]

if (!FALSE %in% c(colnames(fac_m)==colnames(facets_monthly))) {
  
  write.table(facets_monthly,
              "data/Facets_Monthly_API.txt",
              sep = "\t",
              na = "",
              row.names = F)

} else {
  
  print("Check Monthly data Input/Output -- Columns do not match")
  
}
  
# - How do you prep the Facets_Monthly.csv (as a CSV &/or just a data.frame)?

# - How do you prep the Facets_Quarterly.csv (as a CSV &/or data.frame)?
