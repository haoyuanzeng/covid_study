rm(list=ls())

# clean each dataset ----------------------------------------------------------
# read covid dataset
library(readxl)
covid <- read_xlsx("raw_data/covid_data.xlsx" )
# keep useful var only
library(dplyr)
covid2 <- subset(covid, select = c("iso_code", "continent", "location", "total_cases",
                                   "total_deaths","total_cases_per_million","total_deaths_per_million",
                                   "positive_rate","people_fully_vaccinated","people_fully_vaccinated_per_hundred",
                                   "population","population_density","median_age","aged_65_older","gdp_per_capita","human_development_index"))


# read culture data
library(readr)
culture = read_delim("raw_data/culture_data.csv", delim = ";", col_names = TRUE)
# only keep individualism vs. collectivism
culture2 <- subset(culture, select = c("ctr", "country","idv"))
# rename
culture2 <- rename(culture2, iso_code = ctr)

# read democracy data
library(readxl)
demo <- read_xls("raw_data/polity5.xls" )
# only keep most recent 5 years: 2014-2018
demo2 <- filter(demo, year>=2014 & year<=2018)
# only useful var
demo2 <- subset(demo2, select = c("scode", "country", "year", "democ","polity2"))
# replace democ = NA if it's negative (which means transition or missing)
demo2$democ[demo2$democ<0] <- NA
# calculate five-year average
demo_sum <- demo2 %>% group_by(country, scode) %>% summarize(mean(democ,na.rm = TRUE), mean(polity2,na.rm = TRUE))
demo_sum <- rename(demo_sum, democ = "mean(democ, na.rm = TRUE)", polity2 = "mean(polity2, na.rm = TRUE)", iso_code = scode)

# read state capacity data
capacity = read_delim("raw_data/state_capacity.tab", col_names = TRUE)










