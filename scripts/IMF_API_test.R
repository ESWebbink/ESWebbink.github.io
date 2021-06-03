# Looking for structure of IMF data
# See also: https://cran.r-project.org/web/packages/imfr/imfr.pdf
# IMF: How to Use the API (Python and R)
#      https://datahelp.imf.org/knowledgebase/articles/1968408-how-to-use-the-api-python-and-r


# install.packages('imfr')

library(imfr)

imf_id_lists <- imf_ids(return_raw = T,times = 1)

real_ex <- imf_data(database_id = 'IFS', indicator = 'EREER_IX',
                    country = c('CN', 'GB', 'US'), freq = 'A',
                    start = 2000, end = current_year())

imfseries <- imf_codes('CL_INDICATOR_IFS')

# To get these tags, we filtered imfseries$description by:
# - "deficit" --> 3 codes, from which we manually selected = "CG01_GXCCB_G01_CA_XDC"
# - "population" --> 1 code, "LP_PE_NUM"
# - "gdp" --> 43 codes ... selected "NGDP_R_K_IX"

# find other variables [later]

def_pop_gdp <- imf_data(database_id = 'IFS',
                        indicator = c('CG01_GXCCB_G01_CA_XDC',  # deficit
                                      'LP_PE_NUM', # population
                                      'NGDP_R_K_IX'  # gdp
                        ),
                        country = c('CN', 'GB', 'US'), freq = 'A',
                        start = 2000, end = current_year())


# # no need to merge if all datasets were retrieved at once
# # merge datasets by country + year ####
# gdp_pop <- merge(gdp,
#                  population,
#                  by = c("iso2c", "year"),
#                  all = FALSE)

# might instead need to filter out incomplete rows 

# calculate per-capita gdp ####

# setup plot / add to Rmd ####


dsifs <- imf_codes("CL_INDICATOR_IFS")

write.csv(dsifs,
          "dsifs.csv",
          row.names = F
          )

dsbop <- imf_codes("CL_INDICATOR_BOP")
write.csv(dsbop,
          "dsbop.csv",
          row.names = F
)

write.csv(real_ex, 
          "real_ex.csv",
          # na = "",
          row.names = TRUE
          )

write.csv(imf_id_lists$Structure$Dataflows$Dataflow,
          "imf_id_lists.csv",
          row.names = F
          )
