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
# only keep idv: individualism vs. collectivism
culture2 <- subset(culture, select = c("ctr", "country","idv"))
# rename
culture2 <- rename(culture2, iso_code = ctr)
# change idv to numeric var
culture2$idv <- as.numeric(culture2$idv)

# read democracy data
library(readxl)
demo <- read_xls("raw_data/polity5.xls" )
# only keep most recent 5 years: 2014-2018
demo2 <- filter(demo, year>=2014 & year<=2018)
# only useful var
demo2 <- subset(demo2, select = c("scode", "country", "year", "democ","polity2"))
# democ is a measure for democracy, policy2 is a measure for a combination of democracy and autocracy
# replace democ = NA if it's negative (which means transition or missing)
demo2$democ[demo2$democ<0] <- NA
# calculate five-year average
demo_sum <- demo2 %>% group_by(country, scode) %>% summarize(mean(democ,na.rm = TRUE), mean(polity2,na.rm = TRUE))
demo_sum <- rename(demo_sum, democ = "mean(democ, na.rm = TRUE)", polity2 = "mean(polity2, na.rm = TRUE)", iso_code = scode)

# read state capacity data
capacity = read_delim("raw_data/state_capacity.tab", col_names = TRUE)
# only keep most recent 5 years: 2014-2018
capacity2 <- filter(capacity, year>=2014 & year<=2018)
# only useful var
capacity2 <- subset(capacity2, select = c("ISO3", "country", "year", "ape1","rpegdp", "rprwork", "rpafull"))
# ape1: Absolute Political Extraction, an absolute measure of the extractive capacity of governments.APE uses Stochastic Frontier Analysis to directly measure the extractive capacity of nations.
# rpegdp: relative Political Extraction, RPE approximates the ability of governments to appropriate portions of the national output to advance public goals.
# rprwork: RPR gauges the capacity of governments to mobilize populations under their control.
# rpafull: Relative Political Allocation is a composite indicator to measure how public expenditures are prioritized in the government budget, RPA measures the gaps between the actual percentage distribution of general government outlays and what the estimated percentages of the “best” expenditure portfolio to allocate to each functional area to maximize the living standards of the population. 
# calculate five-year average
capacity_sum <- capacity2 %>% group_by(country, ISO3) %>% summarize(mean(ape1,na.rm = TRUE), mean(rpegdp,na.rm = TRUE), mean(rprwork,na.rm = TRUE), mean(rpafull,na.rm = TRUE))
capacity_sum <- rename(capacity_sum, ape = "mean(ape1, na.rm = TRUE)", rpe = "mean(rpegdp, na.rm = TRUE)", rpr = "mean(rprwork, na.rm = TRUE)", rpa = "mean(rpafull, na.rm = TRUE)", iso_code = ISO3)


# merge datasets ----------------------------------------------------------
# merge covid with democracy data
merge_1 <- full_join(covid2, demo_sum, by = "iso_code")
View(dplyr::select(merge_1,c('iso_code','location', 'country','democ','polity2')))

# merge covid with culture data
merge_2 <- full_join(covid2, culture2, by = "iso_code")
View(dplyr::select(merge_2,c('iso_code','location', 'country','idv')))

# merge covid with capacity data
merge_3 <- full_join(covid2, capacity_sum, by = "iso_code")
View(dplyr::select(merge_3,c('iso_code','location', 'country','ape','rpe','rpr','rpa')))


