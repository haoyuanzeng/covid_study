rm(list=ls())

# Create a folder to store raw data ---------------------------------------

if (!dir.exists('raw_data')){
  dir.create('raw_data')
}

# Download country code data 1----------------------------------------------

library("jsonlite")

json_file <- 'https://datahub.io/JohnSnowLabs/country-and-continent-codes-list/datapackage.json'
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

for(i in 1:length(json_data$resources$datahub$type)){
  if(json_data$resources$datahub$type[i]=='derived/csv'){
    path_to_file = json_data$resources$path[i]
    download.file(url = path_to_file, destfile = 'raw_data/country_code_list_1.csv')
  }
}

# Download country code data 2 --------------------------------------------

json_file <- 'https://datahub.io/core/country-codes/datapackage.json'
json_data <- fromJSON(paste(readLines(json_file), collapse=""))


for(i in 1:length(json_data$resources$datahub$type)){
  if(json_data$resources$datahub$type[i]=='derived/csv'){
    path_to_file = json_data$resources$path[i]
    data <- read.csv(url(path_to_file))
    download.file(url = path_to_file, destfile = 'raw_data/country_code_list_2.csv')
  }
}


# Download covid data from WHO --------------------------------------------

download.file(url = 'https://covid19.who.int/WHO-COVID-19-global-table-data.csv',
              destfile = 'raw_data/covid_data.csv')


# Download culture data ---------------------------------------------------

download.file(url = 'http://geerthofstede.com/wp-content/uploads/2016/08/6-dimensions-for-website-2015-08-16.csv',
              destfile = 'raw_data/culture_data.csv')


# Download institutional data ---------------------------------------------

# remotes::install_github("xmarquez/democracyData")


# Download state capacity data --------------------------------------------

download.file(url = 'https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/NRR7MB/6DC2YR',
              destfile = 'raw_data/state_capacity.tab')

# Download country-specific basic information ---------------------------------------------

library(WDI)

# GDP per capita in 2020 (measured in constant 2010 US$)
gdp_data<-WDI(
  country = "all",
  indicator = "NY.GDP.PCAP.KD",
  start = 2020,
  end = 2020,
  extra = FALSE,
  cache = NULL,
  latest = NULL,
  language = "en"
)

write.csv(gdp_data, 'raw_data/gdp_data.csv')

# Population in 2020

pop_data<-WDI(
  country = "all",
  indicator = "SP.POP.TOTL",
  start = 2020,
  end = 2020,
  extra = FALSE,
  cache = NULL,
  latest = NULL,
  language = "en"
)

write.csv(gdp_data, 'raw_data/pop_data.csv')

