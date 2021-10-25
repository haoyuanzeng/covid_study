rm(list=ls())

# clean each dataset ----------------------------------------------------------
# read covid dataset
library(readxl)
covid <- read_xlsx("data/covid_data.xlsx")

# remove some non-country observations and adjust country codes for merging
covid <- covid[is.na(covid$continent) == FALSE,]
covid[covid$iso_code=="OWID_KOS", "iso_code"] <- 'XKX'

# keep useful var only
library(dplyr)
covid2 <- subset(covid, select = 
                   c("iso_code", "continent", "location", "total_cases",
                     "total_deaths","total_cases_per_million","total_deaths_per_million",
                     "positive_rate","people_fully_vaccinated","people_fully_vaccinated_per_hundred",
                     "population","population_density","median_age","aged_65_older","gdp_per_capita",
                     "human_development_index"))


# read culture data
library(readr)
culture = read_delim("data/culture_data.csv", delim = ";", col_names = TRUE)
# only keep idv: individualism vs. collectivism
culture2 <- subset(culture, select = c("ctr", "country","idv"))
# rename
culture2 <- rename(culture2, iso_code = ctr)
# change idv to numeric var
culture2$idv <- as.numeric(culture2$idv)
# remove Null data
culture2 <- culture2[is.na(culture2$idv) == FALSE,]
# adjust country name for merging
culture2[culture2$iso_code == 'CZE','country'] <- 'Czechia'
culture2[culture2$iso_code == 'GBR','country'] <- 'United Kingdom'
culture2[culture2$iso_code == 'KOR','country'] <- 'South Korea'
culture2[culture2$iso_code == 'SLK','country'] <- 'Slovakia'
culture2[culture2$iso_code == 'USA','country'] <- 'United States'

# read democracy data
library(readxl)
demo <- read_xls("data/polity5.xls" )
# only keep most recent 5 years: 2014-2018
demo2 <- filter(demo, year>=2014 & year<=2018)
# keep only useful var
demo2 <- subset(demo2, select = c("scode", "country", "year", "democ","polity2"))
# democ is a measure for democracy, policy2 is a measure for a combination of democracy and autocracy
# replace democ = NA if it's negative (which means transition or missing)
demo2$democ[demo2$democ<0] <- NA
# calculate five-year average
demo_sum <- demo2 %>% 
  group_by(country, scode) %>% 
  summarize(mean(democ,na.rm = TRUE), mean(polity2,na.rm = TRUE))
demo_sum <- rename(demo_sum, democ = "mean(democ, na.rm = TRUE)", 
                   polity2 = "mean(polity2, na.rm = TRUE)", iso_code = scode)

# adjust country name for merging
demo_sum[demo_sum$country == 'Cote D\'Ivoire','country'] <- 'Cote d\'Ivoire'
demo_sum[demo_sum$iso_code == 'CZR','country'] <- 'Czechia'
demo_sum[demo_sum$iso_code == 'CZR','country'] <- 'Czechia'
demo_sum[demo_sum$iso_code == 'ROK','country'] <- 'South Korea'
demo_sum[demo_sum$iso_code == 'MYA','country'] <- 'Myanmar'
demo_sum[demo_sum$iso_code == 'SLO','country'] <- 'Slovakia'
demo_sum[demo_sum$iso_code == 'CON','country'] <- 'Congo'
demo_sum[demo_sum$iso_code == 'ZAI','country'] <- 'Democratic Republic of Congo'
demo_sum[demo_sum$iso_code == 'SDN','country'] <- 'Sudan'
demo_sum[demo_sum$iso_code == 'SWA','country'] <- 'Eswatini'
demo_sum[demo_sum$iso_code == 'SWA','country'] <- 'Eswatini'
demo_sum[demo_sum$iso_code == 'ETM','country'] <- 'Timor'
demo_sum[demo_sum$iso_code == 'ETM','country'] <- 'Timor'
demo_sum[demo_sum$iso_code == 'UAE','country'] <- 'United Arab Emirates'
demo_sum[demo_sum$iso_code == 'MAC','country'] <-'North Macedonia'


# read state capacity data
capacity = read_delim("data/state_capacity.tab", col_names = TRUE)
# only keep most recent 5 years: 2014-2018
capacity2 <- filter(capacity, year>=2014 & year<=2018)
# only useful var
capacity2 <- subset(capacity2, select = c("ISO3", "country", "year", "ape1","rpegdp", "rprwork", "rpafull"))
# ape1: Absolute Political Extraction, an absolute measure of the extractive capacity of governments.APE uses Stochastic Frontier Analysis to directly measure the extractive capacity of nations.
# rpegdp: relative Political Extraction, RPE approximates the ability of governments to appropriate portions of the national output to advance public goals.
# rprwork: RPR gauges the capacity of governments to mobilize populations under their control.
# calculate five-year average
capacity_sum <- capacity2 %>% 
  group_by(country, ISO3) %>% 
  summarize(mean(ape1,na.rm = TRUE), 
            mean(rpegdp,na.rm = TRUE), 
            mean(rprwork,na.rm = TRUE))
capacity_sum <- rename(capacity_sum, 
                       ape = "mean(ape1, na.rm = TRUE)", 
                       rpe = "mean(rpegdp, na.rm = TRUE)", 
                       rpr = "mean(rprwork, na.rm = TRUE)", 
                       iso_code = ISO3)


# merge data ----------------------------------------------------------

covid_analysis <- covid2 %>% 
  left_join(demo_sum, by = c("location" = "country")) %>% 
  left_join(culture2, by = c("location" = "country")) %>% 
  left_join(capacity_sum, by = "iso_code")

# drop useless var and rename
covid_analysis2 <- select(covid_analysis, -starts_with("iso"),-"country")
covid_analysis2 <- rename(covid_analysis2, country = location)

# save data
write.csv(covid_analysis2, 'data/covid_analysis.csv')

