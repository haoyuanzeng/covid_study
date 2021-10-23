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


# Download covid data from our world in data (with country code) --------------------------------------------
download.file(url = 'https://github.com/owid/covid-19-data/raw/master/public/data/latest/owid-covid-latest.xlsx',
              destfile = 'raw_data/covid_data.xlsx')

# Download culture data ---------------------------------------------------

download.file(url = 'http://geerthofstede.com/wp-content/uploads/2016/08/6-dimensions-for-website-2015-08-16.csv',
              destfile = 'raw_data/culture_data.csv')


# Download institutional data ---------------------------------------------

# demovracy: use polity 5 data
download.file(url = 'http://www.systemicpeace.org/inscr/p5v2018.xls',
              destfile = 'raw_data/polity5.xls')


# Download state capacity data --------------------------------------------

download.file(url = 'https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/NRR7MB/6DC2YR',
              destfile = 'raw_data/state_capacity.tab')




